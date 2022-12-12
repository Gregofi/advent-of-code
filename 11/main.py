import math

# Too lazy to parse input:
class monkey:
    def __init__(self, items, operation, div, true, false):
        self.items = items
        self.operation = operation
        self.div = div
        self.true = true
        self.false = false
        self.inspected = 0

    def throw_to(self, val):
        if val % self.div == 0:
            return self.true
        else:
            return self.false

#   monkeys = [
#       monkey([79, 98], "new = old * 19", 23, 2, 3),
#       monkey([54,65,75,74], "new = old + 6", 19, 2, 0),
#       monkey([79, 60, 97], "new = old * old", 13, 1, 3),
#       monkey([74], "new = old + 3", 17, 0, 1),
#   ]

monkeys = [
    monkey([59, 65, 86, 56, 74, 57, 56], "new = old * 17", 3, 3, 6),
    monkey([63, 83, 50, 63, 56], "new = old + 2", 13, 3, 0),
    monkey([93, 79, 74, 55], "new = old + 1", 2, 0, 1),
    monkey([86, 61, 67, 88, 94, 69, 56, 91], "new = old + 7", 11, 6, 7),
    monkey([76, 50, 51], "new = old * old", 19, 2, 5),
    monkey([77, 76], "new = old + 8", 17, 2, 1),
    monkey([74], "new = old * 2", 5, 4, 7),
    monkey([ 86, 85, 52, 86, 91, 95], "new = old + 6", 7, 4, 5),
]

l = math.lcm(*list(map(lambda x: x.div, monkeys)))

for round in range(10000):
    for monkey in monkeys:
        monkey.inspected += len(monkey.items)
        for old in monkey.items:
            exec(monkey.operation)
            new %= l
            new_monkey = monkey.throw_to(new)
            monkeys[new_monkey].items.append(new)
        monkey.items = []

lst = list(sorted(map(lambda m: m.inspected, monkeys)))
print(lst[-1] * lst[-2])
