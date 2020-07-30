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

# host = socket.gethostname()
host = "localhost"

port = 7777

print("host = ", host)

s.connect((host, port))

print("Sending data ... ")
msg = "Hello!! This is client talking"
data = msg.encode('utf-8')
size = len(data)
header = size.to_bytes(4, byteorder='big')
s.sendall(header + data)
# print(s.recv(1024))

time.sleep(2)

msg = "This is the last message."
data = msg.encode('utf-8')
size = len(data)
header = size.to_bytes(4, byteorder='big')
s.sendall(header + data)
