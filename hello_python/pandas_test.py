import pandas as pd
import numpy as np

d = pd.DataFrame({'int': [1, 2, 3, 4, 5], 'str': ['a', 'b', 'c', 'd', 'e']})
# print(d['int'] / d['int'])

na = d.values   # ndarray
# print(type(na))   ->  <class 'numpy.ndarray'>
# print(na.shape)   ->  (5, 2)
# print(na.dtype)   -> object

# na2 = np.array([[1, 'a'], [2, 'b'], [3, 'c'], [4, 'd'], [5, 'e']])
# print(na2)

print(na)
