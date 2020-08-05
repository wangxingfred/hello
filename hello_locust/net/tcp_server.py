import socket

s = socket.socket()

host = socket.gethostname()
# host = 'localhost'

port = 1234

HEADER_SIZE = 4

s.bind((host, port))

s.listen(5)

print('listen to : ', (host, port))

recv_buffer = memoryview(bytearray(64 * 1024))

# while True:
c, addr = s.accept()
print('Got connection from', addr)


# data = c.recv(50)
# print('Received message == ', data)
# c.send(data)

def receive(conn, size, buffer):
    # print("len(recv_buffer) : ", len(recv_buffer))
    received = 0
    while received < size:
        n = conn.recv_into(buffer[received:], size - received)
        if n == 0:
            return None
        received += n
    return bytes(buffer[0:size])


while True:
    size_bytes = receive(c, HEADER_SIZE, recv_buffer)
    if size_bytes is None:
        break

    size_int = int.from_bytes(size_bytes, byteorder='big')
    print("## size : {}.".format(size_int))
    msg_bytes = receive(c, size_int, recv_buffer)
    print("## msg : {}".format(msg_bytes))

c.close()
