import fileinput

VERTICAL = 0
HORIZONTAL = 1

commands = list(map(lambda x: (x[0], int(x[1])),map(lambda s: s.split(' '), fileinput.input())))

def sgn(num):
    if num == 0:
        return 0
    elif num < 0:
        return -1
    else:
        return 1

def move_head(head, direc):
    match direc:
        case 'L':
            head[1] -= 1
        case 'R':
            head[1] += 1
        case 'U':
            head[0] += 1
        case 'D':
            head[0] -= 1
    return head

def neighbours(head, tail):
    return abs(head[0] - tail[0]) <= 1 and abs(head[1] - tail[1]) <= 1

def move_tail(head, tail):
    if neighbours(head, tail):
        return tail

    deltas = [sgn(h - t) for h, t in zip(head, tail)]    
    tail = [coord + delta for coord, delta in zip(tail, deltas)]
    return tail

visited = {(0,0)}
knots = [[0,0] for _ in range(10)]
# For every line in input
for command, steps in commands:
    # Simulate every step
    for _ in range(steps):
        # Move the initial knot, this is the only knot that is moved through user input
        knots[0] = move_head(knots[0], command)
        # Move all the tails
        for i in range(0, len(knots) - 1):
            knots[i + 1] = move_tail(knots[i], knots[i + 1]) 
        visited.add(tuple(knots[-1]))

print(len(visited))
