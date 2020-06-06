import numpy as np
import matplotlib.pyplot as plt

x = np.arange(0, 3*np.pi, 0.2)
x2 = np.linspace(0, 3*np.pi, 60)

y_sin = np.sin(x)
y_cos = np.cos(x2)


# plt.plot(x, y_sin)
# plt.plot(x, y_cos)
# plt.xlabel('x axis')
# plt.ylabel('y axis')
# plt.title('Sin and Cos')
# plt.legend(['Sin', 'Cos'])


# plt.subplot(2, 2, 1)
# plt.plot(x, y_sin, 'y:', x2, y_cos, 'b-.')
# plt.title("Sine & Cosine")
#
# plt.subplot(2, 2, 4)
# plt.plot(y_cos, 'k--')
# plt.title("Cosine")


# plt.scatter(x, y_sin)
# plt.scatter(x2, y_cos)

# x = np.random.rand(10)
# y = np.random.rand(10)
# size = np.random.rand(10) * 50
# color = np.random.rand(10)
#
# plt.scatter(x, y, size, color)
# plt.colorbar()


x = np.random.randn(1000)
plt.hist(x, 20)
plt.legend()

plt.show()


