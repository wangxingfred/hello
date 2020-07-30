import sys
import copy
import json
import time
import logging
import socket
import threading
import betterproto
from typing import Final

from term import codec
from protobuf import all_in_one


def get_class(module, name):
    return getattr(sys.modules[module], name)


def tcp_receive(conn, proto_dict):
    size_str = conn.recv(4)
    if not size_str:
        return False

    size_int = int.from_bytes(size_str, byteorder='big')
    logging.info('Receiving : size_str = %s, size = %d', size_str, size_int)

    c2s_bin = conn.recv(size_int - 1)
    logging.info('Receiving : len = %s, c2s_bin = %s', len(c2s_bin), c2s_bin)

    c2s_msg = all_in_one.C2s().parse(c2s_bin)
    logging.info('c2s_msg = %s', c2s_msg)

    msg_seq = c2s_msg.seq
    msg_type = c2s_msg.type
    msg_data = c2s_msg.data
    if msg_type != -1:
        proto_name = proto_dict.get(str(msg_type))
        logging.info('\t%d => %s : %s', msg_type, type(proto_name), proto_name)
        if proto_name is None:
            logging.info('\tmsg_data = %s', msg_data)
            erl_term = codec.binary_to_term(msg_data)
            (erl_val, tail) = erl_term
            logging.info('\terl_val = %s, type = %s, tail = %s', erl_val, type(erl_val), tail)

            term_bytes = codec.term_to_binary(erl_val)
            logging.info('\tcodec.term_to_binary(erl_val) = %s', term_bytes)
            erl_term2 = codec.binary_to_term(term_bytes)
            (erl_val2, tail2) = erl_term2
            logging.info('\terl_val2 = %s, type = %s, tail = %s', erl_val2, type(erl_val2), tail)
        else:
            cls = get_class('protobuf.all_in_one', proto_name)
            logging.info('\tcls = %s', cls)

            pb_msg = cls().parse(msg_data)
            logging.info('\tpb_msg = %s', pb_msg)

            cp_msg = copy.deepcopy(pb_msg)
            logging.info('\tcp_msg = %s', cp_msg)

            message_replace(cp_msg, UID_BASE_BOUNDARY * 3)
            logging.info('\tcp_msg = %s', cp_msg)

            # logging.info('\tmsg_data == bytes(pb_msg) -> %s', msg_data == bytes(pb_msg))
            # logging.info('\tlen(msg_data) == len(bytes(pb_msg)) -> %s', len(msg_data) == len(bytes(pb_msg)))
            # logging.info('\tmsg_data = %s', msg_data)
            # logging.info('\tpb_bytes = %s', bytes(pb_msg))
            # logging.info('\tpb_bytes == cpy_bytes -> %s', bytes(pb_msg) == bytes(cpy))
            # logging.info('\tlen(pb_bytes) == (cpy_bytes) -> %s', len(bytes(pb_msg)) == len(bytes(cpy)))

    need_response = int.from_bytes(conn.recv(1), byteorder='big')
    logging.info('need_response = %s', need_response)

    return True


UID_BASE_BOUNDARY: Final = 10000000000


def message_replace(message, uid_base):
    print("---------------------------------------------------")
    for attr, value in message.__dict__.items():
        # logging.info('%s : %s : %s', attr, type(value), value)
        if attr.startswith("_"):
            continue

        if isinstance(value, int):
            # logging.info('\tint : %s : %s', attr, value)
            if value >= UID_BASE_BOUNDARY:
                new_value = value % UID_BASE_BOUNDARY + uid_base
                logging.info('\tsetattr : %s : %s -> %s', attr, value, new_value)
                setattr(message, attr, new_value)
        elif isinstance(value, betterproto.Message):
            message_replace(value, x)
    print("<<<<<<<<<<<<<<<<<<<------------------------------------------")


def tcp_server_thread(name):
    logging.info("Thread %s: starting", name)

    s = socket.socket()
    # host = socket.gethostname()
    host = 'localhost'
    port = 7777
    s.bind((host, port))

    s.listen(5)

    with open('protobuf/c2s_proto.json') as f:
        proto_dict = json.load(f)
        # print('type("abc") = ', type("abc"))
        # for key, value in proto_dict.items():
        #     logging.info('%s -> %s : %s', key, type(value), value)

        conn, addr = s.accept()
        logging.info('Got connection from : %s', addr)

        while tcp_receive(conn, proto_dict):
            pass

    logging.info('Connection closed : %s', addr)


if __name__ == "__main__":
    log_format = "%(asctime)s: %(message)s"
    logging.basicConfig(format=log_format, level=logging.INFO, datefmt="%H:%M:%S")

    logging.info("Main    : before creating thread")
    x = threading.Thread(target=tcp_server_thread, args=(1,), daemon=True)
    logging.info("Main    : before running thread")
    x.start()
    logging.info("Main    : wait for the thread to finish")
    try:
        while x.is_alive():
            time.sleep(1)
    except (KeyboardInterrupt, SystemExit):
        print('KeyboardInterrupt')

    # time.sleep(10)
    logging.info("Main    : all done")
