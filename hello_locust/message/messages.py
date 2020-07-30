import sys
import json
import logging
import betterproto
from term import codec
from typing import Final
from protobuf import all_in_one

# 大于等于这个值的int被认为是uid
UID_BOUNDARY: Final = 1000000000


class Message(object):
    def __init__(self, msg_bytes, timing):
        self.msg_bytes = msg_bytes
        self.timing = timing

    def __bytes__(self):
        raise Exception("Not implemented")

    def replace_id(self, uid_base, the_id):
        Message.replace_uid(self, uid_base, the_id * UID_BOUNDARY)
        return self

    @staticmethod
    def replace_uid(obj, uid_base_old, uid_base_new):
        if isinstance(obj, int):
            logging.debug("\t replace_uid : int -> %d", obj)
            if obj >= UID_BOUNDARY:
                tail = obj % UID_BOUNDARY
                if obj == uid_base_old + tail:
                    return uid_base_new + tail
                else:
                    logging.warning("###### No expected uid base : %d", obj - tail)
            return None

        if isinstance(obj, list):
            index = 0
            for x in obj:
                result = Message.replace_uid(x, uid_base_old, uid_base_new)
                logging.debug("\t replace_uid : x = %s -> result = %s", x, result)
                if result is not None:
                    obj[index] = result
                    logging.debug("\t replace_uid : obj[%s] = %s", index, obj[index])
                index += 1
            return None

        if isinstance(obj, betterproto.Message) or isinstance(obj, Message):
            for attr, value in obj.__dict__.items():
                if attr.startswith("_"):
                    continue
                result = Message.replace_uid(value, uid_base_old, uid_base_new)
                if result is not None:
                    setattr(obj, attr, result)
            return None


class ProtoBufMessage(Message):
    def __init__(self, pb_bytes, cls, timing):
        super().__init__(pb_bytes, timing)
        self.pb_obj = cls().parse(pb_bytes)

    def __bytes__(self):
        return bytes(self.pb_obj)

    def __str__(self):
        return "ProtoBufMessage<{}>".format(self.pb_obj)


class ErlTermMessage(Message):
    def __init__(self, term_bytes, timing):
        super().__init__(term_bytes, timing)
        (erl_term, tail) = codec.binary_to_term(term_bytes)
        if tail != b'':
            logging.error("invalid term bytes : %s => (%s,%s)", term_bytes, erl_term, tail)

        self.erl_term = erl_term

    def __bytes__(self):
        # todo: 确定这个结果是否正确
        return codec.term_to_binary(self.erl_term)

    def __str__(self):
        return "ErlTermMessage<{}>".format(self.erl_term)


with open('protobuf/c2s_proto.json') as f:
    c2s_proto_dict = json.load(f)


class C2sMessage(ProtoBufMessage):
    HEART_BEAT_TYPE: Final = -1

    def __init__(self, msg_bytes, timing):
        super().__init__(msg_bytes[0:-1], all_in_one.C2s, timing)
        self.need_response = msg_bytes[-1] == 1
        self.seq = self.pb_obj.seq
        self.data_obj = None
        self._parse_data()

    def __bytes__(self):
        if self.data_obj is not None:
            self.pb_obj.data = bytes(self.data_obj)
        return bytes(self.pb_obj)

    def __str__(self):
        return "C2sMessage<seq={}, type={}, data={}".format(self.seq, self.pb_obj.type, self.data_obj)

    def _parse_data(self):
        c2s_obj = self.pb_obj
        if c2s_obj.type == self.HEART_BEAT_TYPE:
            return

        proto_name = c2s_proto_dict.get(str(c2s_obj.type))
        logging.debug('\tC2sMessage._parse_data: type = %d, proto_name = %s, c2s_obj.data = %s',
                      c2s_obj.type, proto_name, c2s_obj.data)
        data_is_term = proto_name is None
        if data_is_term:
            self.data_obj = ErlTermMessage(c2s_obj.data, self.timing)
        else:
            cls = getattr(sys.modules['protobuf.all_in_one'], proto_name)
            self.data_obj = ProtoBufMessage(c2s_obj.data, cls, self.timing)


class S2cMessage(ProtoBufMessage):
    def __init__(self, msg_bytes, timing=0):
        super().__init__(msg_bytes, all_in_one.S2c, timing)
        self.seq = self.pb_obj.seq
        self.err = self.pb_obj.err

    def replace_id(self, uid_base, the_id):
        raise Exception("Not implemented")
