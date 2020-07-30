import socket

s = socket.socket()

host = socket.gethostname()
# host = 'localhost'

port = 1234

s.bind((host, port))

s.listen(5)

while True:
    c, addr = s.accept()
    print('Got connection from', addr)
    data = c.recv(50)
    print('Received message == ', data)
    c.send(data)
    c.close()
