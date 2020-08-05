# tcp_client.py
# coding:utf-8
import socket  # 客户端 发送一个数据，再接收一个数据
import time

# client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  # 声明socket类型，同时生成链接对象
# client.connect(('localhost', 3030))  # 建立一个链接，连接到本地的6969端口
# # while True:
# #     # addr = client.accept()
# #     # print '连接地址：', addr
# #     msg = '欢迎访问菜鸟教程！'  # strip默认取出字符串的头尾空格
# #     client.send(msg.encode('utf-8'))  # 发送一条信息 python3 只接收btye流
# #     data = client.recv(1024)  # 接收一个信息，并指定接收的大小 为1024字节
# #     print('recv:', data.deco de())  # 输出我接收的信息
# msg = '欢迎访问菜鸟教程！'  # strip默认取出字符串的头尾空格
# client.send(msg.encode('utf-8'))  # 发送一条信息 python3 只接收btye流
# data = client.recv(1024)  # 接收一个信息，并指定接收的大小 为1024字节
# print('recv:', data.decode())  # 输出我接收的信息
# client.close()  # 关闭这个链接

s = socket.socket()

host = socket.gethostname()
# host = "localhost"
port = 1234

HEADER_SIZE = 4

print("(host, port) = ", (host, port))

s.connect((host, port))

msg = "Hello!! This is client talking"
data = msg.encode()
size = len(data)
header = size.to_bytes(HEADER_SIZE, byteorder='big')
s.sendall(header)
s.sendall(data)
print("sendall : header:{}, data:{}, msg:{}".format(len(header), len(data), msg))
# print(s.recv(1024))

time.sleep(1)

msg = "This is the last message.(Send normal and ancillary data to the socket, gathering the non-ancillary data from a series of buffers and concatenating it into a single message. The buffers argument specifies the non-ancillary data as an iterable of bytes-like objects (e.g. bytes objects); the operating system may set a limit (sysconf() value SC_IOV_MAX) on the number of buffers that can be used. The ancdata argument specifies the ancillary data (control messages) as an iterable of zero or more tuples (cmsg_level, cmsg_type, cmsg_data), where cmsg_level and cmsg_type are integers specifying the protocol level and protocol-specific type respectively, and cmsg_data is a bytes-like object holding the associated data. Note that some systems (in particular, systems without CMSG_SPACE()) might support sending only one control message per call. The flags argument defaults to 0 and has the same meaning as for send(). If address is supplied and not None, it sets a destination address for the message. The return value is the number of bytes of non-ancillary data sent.)"
data = msg.encode()
size = len(data)
header = size.to_bytes(HEADER_SIZE, byteorder='big')
s.sendall(header)
s.sendall(data[0:len(data) // 2])
s.sendall(data[len(data) // 2:])
print("sendall : header:{}, data:{}, msg:{}".format(len(header), len(data), msg))
