def fibonacci(n)
  return [] if n == 0
  return [0] if n == 1
  return [0, 1] if n == 2

  previous_fib = fibonacci(n - 1)

  previous_fib << previous_fib[-1] + previous_fib[-2]
end
