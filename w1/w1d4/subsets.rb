def subsets(input_array)
  return [ [] ] if input_array.length == 0

  subsets_excluding_last = subsets(input_array[0...-1])

  subsets_including_last = subsets_excluding_last.map do |element|
    element + [input_array.last]
  end

  subsets_including_last + subsets_excluding_last
end
