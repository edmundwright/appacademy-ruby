sum = 0

File.foreach("sumthis.txt") do |line|
  sum += line.chomp.to_i
end

p sum.to_s[0...10]
