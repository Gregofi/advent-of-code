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

crt = [['.' for _ in range(40)] for _ in range(6)]
for i in range(6):
    for j in range(40):
        begin = prefix_sum[i * 40 + j - 2]
        end = begin + 2
        if begin <= j <= end:
            crt[i][j] = '#'

for i in range(6):
    for j in range(40):
        print(crt[i][j], end="")
    print("")
