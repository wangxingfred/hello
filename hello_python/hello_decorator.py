def type_check_generator(type):
    def type_check_decorator(old_func):
        def new_func(arg):
            if isinstance(arg, type):
                return old_func(arg)
            else:
                print("Bad Type")

        return new_func

    return type_check_decorator


@type_check_generator(int)
def times2(num):
    print(num * 2)


times2(23)
times2("sss")


@type_check_generator(str)
def first_letter(string):
    print(string[0])


first_letter("sgew")
first_letter([1, 2])
