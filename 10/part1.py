import fileinput

commands = list(map(lambda x: (x[0].split('\n')[0], int(x[1]) if len(x) > 1 else 0),map(lambda s: s.split(' '), fileinput.input())))
incs = []
for command, num in commands:
    incs.append(0)
    if command.split(' ')[0] == 'addx':
        incs.append(num)

acc = 1
prefix_sum = [acc := acc + x for x in incs]
print(prefix_sum)

idxs = [20,60,100,140,180,220]
res = 0
for i in idxs:
    res += prefix_sum[i - 2] * i
print(res)
