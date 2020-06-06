import json
import pickle

jstring = '["a", 2]'

print(json.loads(jstring))

jstring = json.dumps([1, 2, 3, "a", "b", "c"])
print(jstring)

pickled_string = pickle.dumps([1, 2, 3, "a", "a", "a"])
print(pickled_string)
print(pickle.loads(pickled_string))


def add_kv(json_string, key, value):
    obj = json.loads(json_string)
    obj[key] = value
    return json.dumps(obj)


salaries = '{"Alfred": 300, "Jane": 400}'
new_salaries = add_kv(salaries, "John", 200)
print(new_salaries)
