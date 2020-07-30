# locust_tcp.py
# coding:utf-8
# from socket import socket, AF_INET, SOCK_STREAM
import socket
import time

from locust import User, TaskSet, events, task


class TcpSocketClient:
    # locust net client
    # author: ShenDu
    def __init__(self, af_inet, socket_type):
        self.socket = socket.socket(af_inet, socket_type)
        # super(TcpSocketClient, self).__init__(af_inet, socket_type)

    def connect(self, addr):
        start_time = time.time()
        try:
            self.socket.connect(addr)
        except Exception as e:
            total_time = int((time.time() - start_time) * 1000)
            events.request_failure.fire(request_type="tcpsocket", name="connect", response_time=total_time, exception=e)
        else:
            total_time = int((time.time() - start_time) * 1000)
            events.request_success.fire(request_type="tcpsocket", name="connect", response_time=total_time,
                                        response_length=0)

    def send(self, msg):
        start_time = time.time()
        try:
            length = len(msg)
            header = length.to_bytes(2, 'big')
            ret = self.socket.sendall(header + msg)
            print(ret)
        except Exception as e:
            total_time = int((time.time() - start_time) * 1000)
            events.request_failure.fire(request_type="tcpsocket", name="send", response_time=total_time, exception=e)
        else:
            total_time = int((time.time() - start_time) * 1000)
            events.request_success.fire(request_type="tcpsocket", name="send", response_time=total_time,
                                        response_length=0)

    def recv(self, bufsize):
        recv_data = ''
        start_time = time.time()
        try:
            recv_data = self.socket.recv(bufsize)
        except Exception as e:
            total_time = int((time.time() - start_time) * 1000)
            events.request_failure.fire(request_type="tcpsocket", name="recv", response_time=total_time, exception=e)
        else:
            total_time = int((time.time() - start_time) * 1000)
            events.request_success.fire(request_type="tcpsocket", name="recv", response_time=total_time,
                                        response_length=0)
        return recv_data


# class TcpSocketLocust(User):
#     """
#     This is the abstract User class which should be subclassed. It provides an TCP socket client
#     that can be used to make TCP socket requests that will be tracked in User's statistics.
#     """
#
#     def __init__(self, *args, **kwargs):
#         super(TcpSocketLocust, self).__init__(*args, **kwargs)
#         self.client = TcpSocketClient(socket.AF_INET, socket.SOCK_STREAM)


class TcpTestUser(User):
    host = "localhost"
    port = 3030
    min_wait = 100
    max_wait = 1000

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.client = TcpSocketClient(socket.AF_INET, socket.SOCK_STREAM)

    def on_start(self):
        self.client.connect((self.host, self.port))

    @task(1)
    def send_data(self):
        msg = "hello, this is locust_tcp.py"
        self.client.send(msg.encode("utf-8"))
        # data = "7e0200003f000004021895000b00000000000400030158ccaa06cb7" \
        #        "9f50095000000001601051654150104000069740202000003020000" \
        #        "2504000000002b040000000030010031010b3201467c7e"
        # self.client.send(bytes.fromhex(data))
        # data = self.client.recv(2048).decode("utf-8")



# if __name__ == "__main__":
#     import os
#
#     os.system("locust -f sendTcp.py")
