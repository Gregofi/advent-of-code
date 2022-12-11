import fileinput

VERTICAL = 0
HORIZONTAL = 1

commands = list(map(lambda x: (x[0], int(x[1])),map(lambda s: s.split(' '), fileinput.input())))

def neighbours(head, tail):
    return abs(head[0] - tail[0]) <= 1 and abs(head[1] - tail[1]) <= 1

def move(head, tail, direc, steps):
    # Zero means vertical index, one horizontal
    idx = HORIZONTAL
    if direc == 'U' or direc == 'D':
        idx = VERTICAL

    direction = -1 if direc == 'L' or direc == 'D' else 1
    # Update head to new position
    new_head = list(head)
    new_head[idx] += direction * steps
    new_head = tuple(new_head)

    if neighbours(new_head, tail):
        return new_head, tail
    
    # tail may need to move diagonally
    if idx == VERTICAL:
        new_tail = [tail[0], new_head[1]]
    else:
        new_tail = [new_head[0], tail[1]]
    
    # generate movements
    if direc == 'R' or direc == 'U':
        steps_range = range(new_tail[idx] + 1, new_head[idx])
    else:
        steps_range = reversed(range(new_head[idx] + 1, new_tail[idx]))

    for i in steps_range:
        new_tail[idx] = i;
        visited.add(tuple(new_tail))
    return new_head, tuple(new_tail)
    

visited = {(0,0)}
head = (0,0)
tail = (0,0)
for command, steps in commands:
    head, tail = move(head, tail, command, steps) 

print(len(visited))
