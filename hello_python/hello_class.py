
class Dog:
    """
        类名首字母大写
    """

    def __init__(self, name, age):
        """init attributes"""
        self.name = name
        self.age = age

    def sit(self):
        """simulate sit"""
        print(self.name.title() + " is now sitting.")

    def roll_over(self):
        """simulate roll over"""
        print(self.name.title() + " rolled over!")


my_dog = Dog("willie", 5)
print(my_dog.name)
print(my_dog.name.title())


class SamoyedDog(Dog):
    """雪橇三傻之萨摩耶"""

    def __init__(self, name, age):
        super().__init__(name, age)
        self.__color = "white"

    def roll_over(self):
        print("Samoyed doesn't known how to roll over.")

    def which_color(self):
        return self.__color


silly_dog = SamoyedDog("William", 2)
silly_dog.roll_over()
print(silly_dog.name + " is " + silly_dog.which_color())

