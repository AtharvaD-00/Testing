#!/bin/python
# Python script to implement a basic calculator

# Imports the necessary modules
import sys
from decimal import Decimal

# Calculates the result of an operation
def calculate (a, b, o) :
	if o == '+' :
		r = a + b								# Addition
	elif o == '-' :
		r = a - b								# Subtraction
	elif o == '*' :
		r = a * b								# Multiplication
	elif o == '/' :
		r = a / b								# Division
	elif o == '%' :
		r = a % b								# Modulus
	else :
		r = "Invalid"
	return r

# Main method
if __name__ == "__main__" :
	# Takes arguments from the command line
	try:
		num1 = Decimal(sys.argv[1])
		op = sys.argv[2]
		num2 = Decimal(sys.argv[3])
	# Exits if an exception is raised
	except :
		print("Invalid")
		sys.exit()
	# Performs the calculation
	res = calculate(num1, num2, op)
	# Prints the result
	print(res)
