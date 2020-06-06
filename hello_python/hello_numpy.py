import numpy as np

# l1 = [1, 2, 3, 4]
# l2 = [10, 22, 33, 44]
#
# arr1 = np.array(l1)
# arr2 = np.array(l2)
#
# x = arr1 / arr2 * 10
#
# print("x : ", x)
#
# print(x > 10)
# print(x[x >= 1])
#
#
# weight_kg = [81.65, 97.52, 95.25, 92.98, 86.18, 88.45]
#
# weight_arr = np.array(weight_kg)
#
# weight_pounds = weight_arr * 2.2
#
# print(weight_pounds)

arr1 = np.array([1, 2, 3, 4])
print(type(arr1))
print(arr1.shape)

arr2 = np.array([[1, 2, 3], [4, 5, 6]])
print(arr2)
print(arr2.shape)
print(arr2[1, 1])

a = np.zeros((2, 3))
b = np.ones((1, 2))
c = np.full((2, 1, 2), 6.6)

print(a)
print(b)
print(c)

d = np.eye(2)
print(d)

print(".............................................")
print(a[:1, 1:3])
print(a[1, 1:3])

print((2,))
print(".............................................")
print(a)
print(np.arange(3))
print(list(range(3)))
print(".............................................")

a[np.arange(2), np.arange(2)] = 5
print(a)

print(".............................................")
x = np.array([np.arange(3), np.arange(3, 6)])
print(x)

bool_idx = x > 1
print(bool_idx)
print(x[bool_idx])
print(x[x > 1])
print(".............................................")

print(x.dtype)
x = np.array([1, 2, 3])
print(x.dtype)
x = np.array([1, 2, 3], dtype=np.float)
print(x.dtype)

print(".............................................")
print(x * x)
print(np.multiply(x, x))
print(np.sqrt(x * x))

print(".............................................")
m = np.array([np.arange(3), np.arange(3, 6)])
print(m)
print(m.sum())
print(m.sum(axis=0))  # column
print(m.sum(axis=1))  # row

print(".................................................")
print(m.T)
print(type(m))

print(".................................................")
m1 = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
v = np.array([-1, 0, 1])
m3 = np.empty_like(m1)

print(m1)
for i in range(3):
    m3[i, :] = m1[i, :] + v
print(m3)
print(m3.sum(axis=0).shape)
print(".................................................")
m4 = np.tile(v, (3, 1))
print(m4)
m5 = m1 + m4
print(m5)
print(".................................................")
m6 = m1 + v
print(m6)
print(m6 == m5)
print(m6 + np.array([[[1, 2, 3]]]))
print(".................................................")
v = np.array([1, 2, 3])
w = np.array([4, 5])
print(v.reshape(3, 1) * w)  # outer product
x = np.array([[1,2,3], [4,5,6]])
print(x + v)
print(w.shape)
print(w.reshape(2, 1))
print(x + w.reshape(2, 1))