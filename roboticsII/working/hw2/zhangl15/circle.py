#!/usr/bin/python
import math
import cmath

#These are the constants.  Change these to modify
#the size of the finger and the number of vertices.
radius = .05
vertices = 21

#print out the number of vertices
print 2*vertices

#print out the top of the finger (with respect to the finger's frame)
#clockwise
for i in range(vertices):
    z = radius*cmath.exp(1j*((vertices-1)-i)*(math.pi/20))
    print z.real, z.imag

#print out the bottom of the finger (again, with respect to the finger's frame)
#clockwise.
for i in range(vertices):
    z =  -radius*cmath.exp(1j*((vertices-1)-i)*(math.pi/20))
    print z.real, z.imag
