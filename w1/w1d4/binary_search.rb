def binary_search_rec(array, search_term, min_index, max_index)
  return nil if max_index < min_index

  middle_index = ((min_index + max_index) / 2).to_i

  if array[middle_index] > search_term
    binary_search_rec(array, search_term, min_index, middle_index - 1)
  elsif array[middle_index] < search_term
    binary_search_rec(array, search_term, middle_index + 1, max_index)
  else
    middle_index
  end
end

def binary_search(array, search_term)
  binary_search_rec(array, search_term, 0, array.length - 1)
end
