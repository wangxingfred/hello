import copy
import time
import random
import logging
import net.tcp_receiver
from message.messages import C2sMessage


class MessageFlow(object):

    def __init__(self):
        self._messages = []
        self.uid_base = None

    def next(self, index, timing):
        if index >= len(self._messages):
            return None

        message = self._messages[index]
        if timing < message.timing:
            return None

        return copy.deepcopy(message)

    def update(self):
        pass


class OnlineMessageFlow(MessageFlow):
    def __init__(self, receiver):
        super().__init__()
        self.receiver = receiver
        self.start_time = time.time()

    def update(self):
        msg_bytes = self.receiver.take()
        if msg_bytes is not None:
            c2s_msg = C2sMessage(msg_bytes, time.time() - self.start_time)
            logging.debug("OnlineMessageFlow.update : take c2s_msg : %s", c2s_msg)
            # logging.debug("OnlineMessageFlow.update : take msg_bytes 1 = %s ", msg_bytes)
            # logging.debug("OnlineMessageFlow.update : take msg_bytes 2 = %s ", bytes(c2s_msg))
            self._messages.append(c2s_msg)
            # cpy_msg = copy.deepcopy(c2s_msg)
            # logging.debug(" cpy_msg = %s", cpy_msg)
            # cpy_msg.replace_id(5000000000, 888)
            # logging.debug(" cpy_msg = %s", cpy_msg)
            # logging.debug("OnlineMessageFlow.update : len(self._messages) = %d ", len(self._messages))


class OfflineMessageFlow(MessageFlow):
    pass


class HybridMessageFlow(MessageFlow):
    pass


class MessageScheduler(object):
    instance = None

    def __init__(self, acceptor):
        self.flows = []
        acceptor.subscribe(self._on_tcp_accept)

    def start(self):
        pass

    def update(self):
        for flow in self.flows:
            flow.update()

        return True

    def choose_flow(self):
        if not self.flows:
            return None
        return random.choice(self.flows)

    def _on_tcp_accept(self, receiver):
        logging.debug("MessageScheduler._on_tcp_accept ... ")
        flow = OnlineMessageFlow(receiver)
        self.flows.append(flow)


if __name__ == "__main__":
    log_format = "%(asctime)s: %(message)s"
    logging.basicConfig(format=log_format, level=logging.INFO, datefmt="%H:%M:%S")

    logging.info("Main    : start TcpAcceptor")
    tcp_acceptor = net.tcp_receiver.TcpAcceptor("localhost", 7777, 4)
    tcp_acceptor.start()

    logging.info("Main    : start MessageScheduler")
    scheduler = MessageScheduler(tcp_acceptor)
    scheduler.start()

    MessageScheduler.instance = scheduler

    logging.info("Main    : start main loop")
    while True:
        if not tcp_acceptor.update():
            break
        if not scheduler.update():
            break
        time.sleep(0.01)

    logging.info("Main    : all done")
