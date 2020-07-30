import sys
import logging
import socket
import threading
from queue import SimpleQueue


def thread_entry(obj):
    obj.thread_entry()


class TcpReceiver:
    def __init__(self, conn, addr, header_size):
        self.conn = conn
        self.addr = addr
        self.queue = SimpleQueue()
        self.header_size = header_size
        self.thread = threading.Thread(target=thread_entry, args=(self,), daemon=True)

    def start(self):
        self.thread.start()

    def update(self):
        pass

    def take(self):
        if self.queue.empty():
            return None
        return self.queue.get_nowait()

    def thread_entry(self):
        logging.info("TcpReceiver    : thread_entry")
        self._receive_loop()

    def _receive_loop(self):
        conn = self.conn
        queue = self.queue
        header_size = self.header_size

        while True:
            size_str = conn.recv(header_size)
            if not size_str:
                break

            size_int = int.from_bytes(size_str, byteorder='big')
            logging.info('Receiving : size_str = %s, size = %d', size_str, size_int)

            msg_bytes = conn.recv(size_int)
            queue.put(msg_bytes)


class TcpAcceptor:
    def __init__(self, host, port, header_size):
        self.host = host
        self.port = port
        self.header_size = header_size
        self.thread = threading.Thread(target=thread_entry, args=(self,), daemon=True)
        self.receivers = []
        self.receiver_queue = SimpleQueue()
        self.accept_callbacks = []

    def start(self):
        self.thread.start()

    def update(self):
        if not self.receiver_queue.empty():
            receiver = self.receiver_queue.get_nowait()
            self.receivers.append(receiver)
            for fn in self.accept_callbacks:
                fn(receiver)
            pass

        for receiver in self.receivers:
            receiver.update()

        return True

    def subscribe(self, accept_callback):
        self.accept_callbacks.append(accept_callback)

    def thread_entry(self):
        logging.info("TcpAcceptor    : thread_entry")
        s = socket.socket()
        s.bind((self.host, self.port))
        s.listen(5)

        while True:
            conn, addr = s.accept()
            receiver = TcpReceiver(conn, addr, self.header_size)
            receiver.start()

            self.receiver_queue.put(receiver)


if __name__ == "__main__":
    log_format = "%(asctime)s: %(message)s"
    logging.basicConfig(format=log_format, level=logging.INFO, datefmt="%H:%M:%S")

    acceptor = TcpAcceptor("localhost", 1234, 4)
    logging.info("Main    : start acceptor")
    acceptor.start()
    logging.info("Main    : wait for the thread to finish")
    logging.info("Main    : all done")
