d = {'name': "fred", 'age': 28, 'sex': "male", 'job': "coding"}

print({k: k for k in d})

for key in d:
    print("%s = %s" % (key, d[key]))

for key, value in d.items():
    print(key, "=", value)

print({k : v for k, v in d.items()})
