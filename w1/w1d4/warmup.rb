def range(start_range, end_range)
  return [] if start_range > end_range
  return [start_range] if start_range == end_range

  previous_range = range(start_range + 1, end_range)
  [start_range] + previous_range
end

def recursive_sum(array)
  return 0 if array == []

  previous_sum = recursive_sum(array[0...array.length-1])

  previous_sum += array.last
end

def iterative_sum(array)
  sum = 0

  array.each do |element|
    sum += element
  end

  sum

end
