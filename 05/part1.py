# If you're looking for smart interesting solution you're
# only gonna find dissapointment here :(

import fileinput

lst = [[], 
     ['Q', 'M', 'G', 'C', 'L'], 
     ['R', 'D', 'L', 'C', 'T', 'F', 'H', 'G'],
     ['V', 'J', 'F', 'N', 'M', 'T', 'W', 'R'],
     ['J', 'F', 'D', 'V', 'Q', 'P'],
     ['N', 'F', 'M', 'S', 'L', 'B', 'T'],
     ['R', 'N', 'V', 'H', 'C', 'D', 'P'],
     ['H', 'C', 'T'],
     ['G', 'S', 'J', 'V', 'Z', 'N', 'H', 'P'],
     ['Z', 'F', 'H', 'G'],
]

for line in fileinput.input():
    _, cnt, _, where, _, to = line.split(' ')
    cnt = int(cnt)
    where = int(where)
    to = int(to)

    mov = lst[where][-cnt:]
    lst[where] = lst[where][:-cnt]
    lst[to].extend(mov)

print(''.join(map(lambda l: l[-1], lst[1:])))
