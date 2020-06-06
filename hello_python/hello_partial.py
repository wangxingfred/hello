from functools import partial


# def multily(x, y):
#     return x * y
#
#
# dbl = partial(multily, 2)
#
# print(dbl(4))


def func(u, v, w, x):
    return u * 4 + v * 3 + w * 2 + x * 1


pf = partial(func, 10, 3, 2)
print(pf(7))
