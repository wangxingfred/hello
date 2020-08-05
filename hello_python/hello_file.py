import os

filename = "hello_file.txt"


def read_rb():
    if os.path.isfile(filename):
        f = open(filename, "rb")
        bytes_ = f.read()
        print("read 'rb' file : ", bytes_)
        f.close()


def read_append():
    if os.path.isfile(filename):
        f = open(filename, "r+b")
        bytes_ = f.read()
        print("read 'r+b' file : ", bytes_)
    else:
        f = open(filename, "ab")
        # bytes_ = None
        bytes_ = f.read()
        print("read 'ab' file : ", bytes_)
    f.write(b'abc')
    print("write b'abc' ..")
    f.close()


# def open_file(readonly):
#     mode = readonly and "rb" or "rb+"
#     print("mode = ", mode)
#
# open_file(True)
# open_file(False)
