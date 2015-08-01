# # recursion 1
# exp(b, 0) = 1
# exp(b, n) = b * exp(b, n - 1)

def exponent1(base, power)
  return 1 if power == 0
  base * exponent1(base, power-1)
end


# # recursion 2
# exp(b, 0) = 1
# exp(b, 1) = b
# exp(b, n) = exp(b, n / 2) ** 2             [for even n]
# exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]

def exponent2(base,power)
  return 1 if power == 0
  return base if power == 1

  if(power.even?)
    prior = exponent2(base, power / 2)
    prior * prior
  else
    prior = exponent2(base, (power-1) / 2)
    base * prior * prior
  end

end
