#!/usr/bin/env python
"""Locust对TCP长连接进行压力的测试脚本示例。
本脚本通过TCP长连接发送简单的数据给被测服务器(Ping)，并接收被测服务器返回的数据(Pong)。
脚本通过记录请求发送的时间，以及成功接收服务器响应数据的时间，计算请求的响应时间。
如果有任何异常抛出，则记录异常信息。
用户可以在脚本中设置一些Locust的参数，如最小等待时间、最大等待时间，以及被测的服务器地址等。
用户可以在此基础上进行扩展，编写适合实际业务场景的测试脚本。
执行脚本：
locust -f tcplocust.py
如果脚本是本地启动的话，可以访问：
http://localhost:8089
进行参数设置，执行测试任务以及查看测试结果。
关于使用Locust进行压力测试的更多信息，请访问Locust官网https://locust.io
"""

import time
import socket
from locust import User, TaskSet, task, events


class TcpSocketClient(socket.socket):
    def __init__(self, family, t):
        super(TcpSocketClient, self).__init__(family, t)

    def connect(self, addr):
        """连接服务器，并向管理器发送成功/失败事件、请求的响应时间、异常信息。"""
        start_time = time.time()
        try:
            super(TcpSocketClient, self).connect(addr)
        except Exception as e:
            total_time = int((time.time() - start_time) * 1000)
            events.request_failure.fire(
                request_type="tcpsocket",
                name="connect",
                response_time=total_time,
                exception=e)
        else:
            total_time = int((time.time() - start_time) * 1000)
            events.request_success.fire(
                request_type="tcpsocket",
                name="connect",
                response_time=total_time,
                response_length=0)

    def send(self, msg):
        start_time = time.time()
        try:
            super(TcpSocketClient, self).send(msg)
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
            recv_data = super(TcpSocketClient, self).recv(bufsize)
        except Exception as e:
            total_time = int((time.time() - start_time) * 1000)
            events.request_failure.fire(request_type="tcpsocket", name="recv", response_time=total_time, exception=e)
        else:
            total_time = int((time.time() - start_time) * 1000)
            events.request_success.fire(request_type="tcpsocket", name="recv", response_time=total_time,
                                        response_length=0)
        return recv_data


class UserBehavior(TaskSet):
    """Locust任务集类，定义每个Locust的行为。"""

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # 设置一个flag避免失败后继续发送数据导致额外的错误信息。
        self.running = True

    def on_start(self):
        """每个任务执行模拟操作前进行一次配置。这里在发送数据前先确保连接到服务器。"""
        try:
            self.user.connect(self.user.host, self.user.port)
        except Exception:
            self.running = False

    @task(1)
    def send_data(self):
        data = "7e0200003f000004021895000b00000000000400030158ccaa06cb7" \
               "9f50095000000001601051654150104000069740202000003020000" \
               "2504000000002b040000000030010031010b3201467c7e"
        if self.running:
            try:
                self.user.send_data(data)
            except Exception:
                self.running = False

    # @task(1)  # 权重为1。如果有多个任务，可以定义不同的权重。
    # def ping_pong(self):
    #     """模拟发送接收数据。"""
    #     if self.running:
    #         try:
    #             self.user.ping_pong()
    #         except Exception:
    #             self.running = False


class TcpSocketLocust(User):
    """使用TCP socket连接服务器收发数据的测试客户端。"""

    """自定义Locust类，可以设置Locust的参数。"""
    tasks = {UserBehavior: 2}
    host = "127.0.0.1"  # 被测服务器地址
    # host = "localhost"  # 被测服务器地址。仅用于调试，压测脚本不应运行在被测服务器上。
    port = 3030  # 被测服务器端口
    min_wait = 5000  # 最小等待时间，即至少等待多少秒后Locust选择执行一个任务。
    max_wait = 9000  # 最大等待时间，即至多等待多少秒后Locust选择执行一个任务。

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.client = TcpSocketClient(socket.AF_INET, socket.SOCK_STREAM)

    def connect(self, host, port):
        self.client.connect((host, port))

    # def read_bytes(self, length):
    #     """从socket读取指定数量的字节。"""
    #     data = bytes()
    #     while len(data) < length:
    #         chunk = self.socket.recv(length - len(data))
    #         if chunk:
    #             data += chunk
    #         else:
    #             raise Exception("Error reading bytes.")
    #     return data

    def send_data(self, data):
        # self.client.send(data.encode("utf-8"))
        self.client.send(bytes.fromhex(data))
        # data = self.client.recv(2048).decode("utf-8")
        print(data)

    # def ping_pong(self):
    #     """发送一个ping，接收一个pong。"""
    #     msg = "Ping"
    #     start_time = time.time()
    #     try:
    #         # 向服务器发送数据
    #         self.socket.sendall(len(msg).to_bytes(4, 'little'))
    #         self.socket.sendall(msg.encode())
    #
    #         # 接收服务器响应
    #         # header = self.read_bytes(4)
    #         # length = int.from_bytes(header, 'little')
    #         # data = self.read_bytes(length)
    #         # if data.decode("utf-8") != "Pong":
    #         #     raise Exception("Unrecognized protocol.")
    #     except Exception as e:
    #         # 记录请求失败事件及异常信息
    #         total_time = int((time.time() - start_time) * 1000)
    #         events.request_failure.fire(request_type="net",
    #                                     name="ping-pong",
    #                                     response_time=total_time,
    #                                     response_length=0,
    #                                     exception=e)
    #         self.socket.close()
    #         raise e
    #     else:
    #         # 记录请求成功事件及响应时间
    #         total_time = int((time.time() - start_time) * 1000)
    #         events.request_success.fire(request_type="net",
    #                                     name="ping-pong",
    #                                     response_time=total_time,
    #                                     response_length=1)

# class TestTcpLocust(TcpSocketLocust):
#     """自定义Locust类，可以设置Locust的参数。"""
#     tasks = {UserBehavior: 2}
#     host = "127.0.0.1"  # 被测服务器地址
#     # host = "localhost"  # 被测服务器地址。仅用于调试，压测脚本不应运行在被测服务器上。
#     port = 3030  # 被测服务器端口
#     min_wait = 5000  # 最小等待时间，即至少等待多少秒后Locust选择执行一个任务。
#     max_wait = 9000  # 最大等待时间，即至多等待多少秒后Locust选择执行一个任务。
