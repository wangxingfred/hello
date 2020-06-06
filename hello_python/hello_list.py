l = [1, "2", 3, 4.0]
print(l, l[0])
print(l[-1])

l[2] = 3.3
print(l[-2])

l.append("end")
print(l)

print(l.pop())
print("....................................................")

nums = list(range(5))
print(nums)

print(nums[2:4])
print(nums[:4])
print(nums[2:])
print(nums[:])
print(nums[:-1])
print(nums[-1:-3])
print(nums[0:1])
print(nums[0:0])
print(nums[3:1])
print("............................................")

nums[:1] = ["a", "b", "c"]
print(nums)

for n in nums:
    print(n)

for index, n in enumerate(nums):
    print("#%d : %s" % (index, n))

print(nums)

print([x ** 2 for x in nums if isinstance(x, int)])

print(type(2) == int)

a = [1, 2, 3]
b = [4, 5, 6]
print([(x, y) for y in b if y < 6 for x in a if x > 1])
