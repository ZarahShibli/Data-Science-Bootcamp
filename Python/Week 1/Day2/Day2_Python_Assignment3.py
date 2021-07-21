#1
def a():
    return 5
print(a())

print('----------------')

#2
def a():
    return 5
print(a()+a())

print('----------------')

#3
def a():
    return 5
    return 10
print(a())

print('----------------')

#4
def a():
    return 5
    print(10)
print(a())


print('----------------')

#5
def a():
    print(5)
x = a()
print(x)

print('----------------')

#6
def a(b,c):
    print(b+c)
#print((a(1,2) + a(2,3)))

print('----------------')

#7
def a(b,c):
    return str(b)+str(c)
print(a(2,5))

print('----------------')

#8
def a():
    b = 100
    print(b)
    if b < 10:
        return 5
    else:
        return 10
    return 7
print(a())

print('----------------')

#9
def a(b,c):
    if b<c:
        return 7
    else:
        return 14
    return 3
print(a(2,3))
print(a(5,3))
print(a(2,3) + a(5,3))

print('----------------')

#10
def a(b,c):
    return b+c
    return 10
print(a(3,5))

print('----------------')

#11
b = 500
print(b)
def a():
    b = 300
    print(b)
print(b)
a()
print(b)

print('----------------')

#12
b = 500
print(b)
def a():
    b = 300
    print(b)
    return b
print(b)
a()
print(b)

print('----------------')


#13
b = 500
print(b)
def a():
    b = 300
    print(b)
    return b
print(b)
b=a()
print


print('----------------')

#14
def a():
    print(1)
    b()
    print(2)
def b():
    print(3)
a()

print('----------------')
#15
def a():
    print(1)
    x = b()
    print(x)
    return 10
def b():
    print(3)
    return 5
y = a()
print(y)