def fib(n): #define a function
    #write the documentation below
    """Print a Fibonacci series up to n."""
    a, b = 0, 1
    while a < n:
        print(a)
        a, b = b, a + b
        print(b)      
fib(200)
