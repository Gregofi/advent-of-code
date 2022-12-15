import fileinput
from collections import deque
from functools import cmp_to_key

def sgn(num):
    if num < 0:
        return -1
    elif num > 0:
        return 1
    return 0

lists = []
for line in fileinput.input():
    lists.append(line[:-1])

pairs = []
for i in range(len(lists)):
    if lists[i] == "":
        pairs.append(eval(lists[i - 2]))
        pairs.append(eval(lists[i - 1]))

def check_order(lst1, lst2):
    if len(lst1) == len(lst2) == 0:
        return 0
    elif len(lst1) == 0:
        return -1
    elif len(lst2) == 0:
        return 1

    h1, *t1 = lst1
    h2, *t2 = lst2
    if type(h1) == list and type(h2) == list:
        res = check_order(h1, h2)
    elif type(h1) == list:
        res = check_order(h1, [h2])
    elif type(h2) == list:
        res = check_order([h1], h2)
    else:
        res = sgn(h1 - h2)

    if res == 0:
        return check_order(t1, t2)
    return res

pairs.append([[2]])
pairs.append([[6]])
pairs.sort(key=cmp_to_key(check_order))
for x in pairs:
    print(x)
print((pairs.index([[2]]) + 1) * (pairs.index([[6]]) + 1))
