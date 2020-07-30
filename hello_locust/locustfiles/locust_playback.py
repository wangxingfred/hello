import time
import inspect
import gevent
import logging
import locust, locust.env, locust.stats
from message.message_scheduler import MessageScheduler
from message.messages import *
from net.tcp_receiver import *


# def event_fail(start_time, e):
#     # name = sys._getframe(1).f_code.co_name
#     # name = inspect.stack()[1][3]
#     name = inspect.currentframe().f_back.f_code.co_name
#     total_time = int((time.time() - start_time) * 1000)
#     logging.info("event_fail : name=%s response_time=%d", name, total_time)
#     locust.env.events.request_failure.fire(
#         request_type="tcp socket",
#         name=name,
#         response_time=total_time,
#         exception=e)
#
#
# def event_success(start_time, response_length=0):
#     name = inspect.currentframe().f_back.f_code.co_name
#     total_time = int((time.time() - start_time) * 1000)
#     logging.info("event_success : name=%s response_time=%d", name, total_time)
#     locust.events.request_success.fire(
#         request_type="tcp socket",
#         name=name,
#         response_time=total_time,
#         response_length=response_length)


class TcpConnection(object):
    def __init__(self, environment, host, port, header_size):
        self.socket = socket.socket()
        self.host = host
        self.port = port
        self.header_size = header_size
        self.environment = environment

    def connect(self):
        start_time = time.time()
        try:
            self.socket.connect((self.host, self.port))
        except Exception as e:
            self.event_fail(start_time, e)
            logging.warning("connect fail -> %s:%d", self.host, self.port)
        else:
            self.event_success(start_time)
            logging.debug("connect success ===>> %s:%d", self.host, self.port)

    def close(self):
        start_time = time.time()
        try:
            self.socket.close()
        except Exception as e:
            self.event_fail(start_time, e)
            logging.warning("socket close exception : %s", e)
        else:
            self.event_success(start_time)

    def post(self, msg):
        start_time = time.time()
        try:
            self.socket.send(self._header(msg))
            self.socket.send(msg)
        except Exception as e:
            self.event_fail(start_time, e)
        else:
            self.event_success(start_time)

    def get(self, msg, response_check):
        start_time = time.time()
        try:
            self.socket.send(self._header(msg))
            self.socket.send(msg)
            while True:
                res_bytes = self._receive()
                if response_check(res_bytes):
                    response_length = len(res_bytes)
                    break
        except Exception as e:
            self.event_fail(start_time, e)
        else:
            self.event_success(start_time, response_length)

    def _receive(self):
        res_size_str = self.socket.recv(self.header_size)
        res_size_int = int.from_bytes(res_size_str, byteorder='big')
        res_bytes = self.socket.recv(res_size_int)
        return res_bytes

    def _header(self, msg):
        return len(msg).to_bytes(self.header_size, 'big')

    def event_fail(self, start_time, e):
        # name = sys._getframe(1).f_code.co_name
        # name = inspect.stack()[1][3]
        total_time = int((time.time() - start_time) * 1000)
        name = inspect.currentframe().f_back.f_code.co_name
        logging.warning("event_fail : name=%s response_time=%d", name, total_time)
        self.environment.events.request_failure.fire(
            request_type="tcp socket",
            name=name,
            response_time=total_time,
            exception=e)

    def event_success(self, start_time, response_length=0):
        total_time = int((time.time() - start_time) * 1000)
        name = inspect.currentframe().f_back.f_code.co_name
        logging.debug("event_success : name=%s response_time=%d", name, total_time)
        self.environment.events.request_success.fire(
            request_type="tcp socket",
            name=name,
            response_time=total_time,
            response_length=response_length)


class GameClient(TcpConnection):
    def __init__(self, environment, host, port):
        super().__init__(environment, host, port, 2)

    def send(self, c2s_msg):
        logging.debug("GameClient.send : %s", str(c2s_msg))
        msg_bytes = bytes(c2s_msg)
        logging.debug("GameClient.send : msg_bytes = %s ", msg_bytes)
        if c2s_msg.need_response:
            def check(res):
                s2c_msg = S2cMessage(res)
                if s2c_msg.seq == 0:
                    return False
                if s2c_msg.seq != c2s_msg.seq:
                    raise Exception("s2c message seq not match. {} vs {}".format(c2s_msg.seq, s2c_msg.seq))
                if s2c_msg.err is not None:
                    raise Exception("s2c message err : {}".format(s2c_msg.err))
                return True

            self.get(msg_bytes, check)
        else:
            self.post(msg_bytes)
        pass


class PlaybackUser(locust.User):
    _msg_index: int
    _start_time: float

    user_id = 220000
    host = "127.0.0.1"  # 被测服务器地址
    port = 3030  # 被测服务器端口

    thread_lock = threading.Lock()

    wait_time = locust.between(0.2, 1)

    def __init__(self, environment):
        super().__init__(environment)
        self._client = GameClient(environment, PlaybackUser.host, PlaybackUser.port)
        with PlaybackUser.thread_lock:
            PlaybackUser.user_id += 1
            self._id = PlaybackUser.user_id
        logging.debug("PlaybackUser.user_id = %d", PlaybackUser.user_id)
        self._msg_flow = None

    def on_start(self):
        self._msg_index = 0
        self._start_time = time.time()
        self._client.connect()

    def on_after(self):
        self._client.close()

    @locust.task(1)
    def send_message(self):
        flow = self._get_flow()
        if flow is None:
            return

        msg = flow.next(self._msg_index, time.time() - self._start_time)
        if msg is None:
            return

        self._msg_index += 1

        if isinstance(msg.data_obj, ProtoBufMessage) and isinstance(msg.data_obj.pb_obj, all_in_one.LoginDev):
            msg.data_obj.pb_obj.login.channel_uid = str(self._id)
            flow.uid_base = msg.data_obj.pb_obj.uid_base
            logging.debug("set msg.data_obj.pb_obj.login.channel_uid = %s", msg.data_obj.pb_obj.login.channel_uid)
            logging.debug("set flow.uid_base = %d", flow.uid_base)

        logging.debug("flow.uid_base = %d", flow.uid_base)
        msg.replace_id(flow.uid_base, self._id)
        logging.debug(" msg = %s", msg)
        self._client.send(msg)

    def _get_flow(self):
        if self._msg_flow is None:
            self._msg_flow = MessageScheduler.instance.choose_flow()
        return self._msg_flow


if __name__ == "__main__":
    log_format = "%(asctime)s: %(message)s"
    logging.basicConfig(format=log_format, level=logging.INFO, datefmt="%H:%M:%S")

    logging.debug("Main     : debug log enabled")
    logging.info("Main    : start TcpAcceptor")
    acceptor = TcpAcceptor("localhost", 7777, 4)
    acceptor.start()

    logging.info("Main    : start MessageScheduler")
    scheduler = MessageScheduler(acceptor)
    scheduler.start()
    MessageScheduler.instance = scheduler

    # setup Environment and Runner
    env = locust.env.Environment(user_classes=[PlaybackUser])
    env.create_local_runner()
    # start a WebUI instance
    env.create_web_ui("127.0.0.1", 8089)
    # start a greenlet that periodically outputs the current stats
    # gevent.spawn(locust.stats.stats_printer(env.stats))
    # # start the test
    # env.runner.start(1, hatch_rate=10)
    # # in 60 seconds stop the runner
    # gevent.spawn_later(60, lambda: env.runner.quit())

    logging.info("Main    : loop begin")
    try:
        while True:
            if not acceptor.update():
                break
            if not scheduler.update():
                break
            time.sleep(0.01)
    except (KeyboardInterrupt, SystemExit):
        print('KeyboardInterrupt')
    logging.info("Main    : loop end")

    # wait for the greenlets
    # env.runner.greenlet.join()

    # stop the web server for good measures
    env.web_ui.stop()

    logging.info("Main    : all done")
