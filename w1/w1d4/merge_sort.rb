def merge_sort(array)
  return array if array.length == 1

  first_half = array[0..array.length/2-1]
  second_half = array[(array.length/2)..-1]

  sorted_first_half = merge_sort(first_half)
  sorted_second_half = merge_sort(second_half)

  merge(sorted_first_half, sorted_second_half)
end

def merge(array1, array2)
  output = []

 while !array1.empty? && !array2.empty?
   if array1.first > array2.first
     output << array2.first
     array2.shift
   else
     output << array1.first
     array1.shift
   end
 end

 [array1, array2].each do |arr|
   until arr.empty?
     output << arr.first
     arr.shift
   end
 end

 output
end
