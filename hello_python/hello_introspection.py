# help(dir)
# help(hasattr)
# help(id)


# Define the Vehicle class.
class Vehicle:
    name = ""
    kind = "car"
    color = ""
    value = 100.00

    def description(self):
        desc_str = "%s is a %s %s worth $%.2f." % (self.name, self.color, self.kind, self.value)
        return desc_str


# Print a list of all attributes of the Vehicle class.
# Your code goes here
attrs = dir(Vehicle)


class O:
    pass


self_attrs = [attr for attr in attrs if hasattr(O, attr) is False]
print(self_attrs)
