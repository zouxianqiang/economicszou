squares = [1, 4, 9, 16, 25]
print(squares[0],squares[-1],squares[-3:])
cubes = [1, 8, 27, 65, 125]
cubes[3] = 64
print(cubes)
cubes.append(216)
cubes.append(7 ** 3)
print(cubes)

squares = []
squares = [x**2 for x in range(10)]

cat = [(x, y) for x in [1,2,3] for y in [3,1,4] if x != y]
matrix = [
     [1, 2, 3, 4],
     [5, 6, 7, 8],
     [9, 10, 11, 12],
]
print(matrix)

t = 12345, 54321, 'hello!'
t[0]
u = t, (1, 2, 3, 4, 5)
print(t)
print(u)