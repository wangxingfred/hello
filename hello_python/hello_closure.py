# def print_msg(number):
#     def change_num():
#         nonlocal number
#         number = 3
#         print("nested func : number=%d" % number)
#
#     change_num()
#     print(number)
#
#
# print_msg(55)


# def transmit_to_space(message):
#     def data_transmitter():
#         print(message)
#
#     return data_transmitter
#
#
# transmitter = transmit_to_space("test")
# transmitter()


def multiplier_of(num):
    def multiplier_of_num(rhs):
        return num * rhs

    return multiplier_of_num


multiplier_of_5 = multiplier_of(5)
print(multiplier_of_5(4))

