def sequence_length(num)
  length = 0

  until num == 1
    if num.even?
      num = num / 2
    else
      num = 3 * num + 1
    end
    length += 1
  end

  length
end



longest_chain = 0
best = nil

#(0...1_000_000).each do |num|
num = 1000000
while num > 1
  chain_length = sequence_length(num)
  if chain_length > longest_chain
    longest_chain = chain_length
    best = num
  end
  puts best
  num -= 1
end

p best
