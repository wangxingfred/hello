import pandas as pd

s = pd.Series([100, "pandas", 0.1])
print(s)

print(s.values)

print(s.index)

print("----------------------------------------------------------")

s2 = pd.Series([100, "pandas", 0.1], index=["a", "b", "c"])
print(s2)

print("----------------------------------------------------------")
sd = {"e": 100, "f": "pandas", "g": 0.1}
s3 = pd.Series(sd)
print(s3)

print("----------------------------------------------------------")
s4 = pd.Series(sd, index=["a", "b", "e", "f"])
print(s4)

print(pd.isnull(s4))
print(pd.notnull(s4))

print("----------------------------------------------------------")
s5 = pd.Series([1, 2, 3, 4, 5])
print(s5[s5 > 1])
print(s5 * 10)

print("----------------------------------------------------------")
data = {"name": ["yahoo", "google", "facebook"], "marks": [222, 444, 555], "price": [9, 3, 7]}
f1 = pd.DataFrame(data)
print(f1)

print("----------------------------------------------------------")
f2 = pd.DataFrame(data, columns=["name", "price", "marks"])
print(f2)

print("----------------------------------------------------------")
f3 = pd.DataFrame(data, columns=["name", "price", "marks"], index=["a", "b", "c"])
print(f3)

print("----------------------------------------------------------")
f4 = pd.DataFrame(data, columns=["name", "price", "marks", "debt"], index=["a", "b", "c"])
print(f4)

print("----------------------------------------------------------")
f5 = pd.DataFrame({"name": {"first": "Alice", "second": "Bill"}, "age": {"first": 10}}, index=["first", "second", "3"])
print(f5)

print("----------------------------------------------------------")
print(f5.columns)
print(f5["age"])


print("----------------------------------------------------------")
f5["age"] *= 10
print(f5)


print("----------------------------------------------------------")
print(f5[:2])
print(f5[2:])
print(f5["name"][1])


print("----------------------------------------------------------")
print(f5[1:]["name"])


# print("----------------------------------------------------------")
# print(f5.sort())

print("----------------------------------------------------------")
print(f5.isnull())
print("----------------------------------------------------------")
print(f5.isnull().any(axis=0))
print("----------------------------------------------------------")
print(f5.isnull().any(axis=1))


print("----------------------------------------------------------")
print(f5['age'])











