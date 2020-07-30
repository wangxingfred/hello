from protobuf.betterproto.lib.hello import Greeting

test = Greeting()

serialized = bytes(test)

another = Greeting().parse(serialized)

print(another.to_dict())
print(another.to_json(indent=2))
