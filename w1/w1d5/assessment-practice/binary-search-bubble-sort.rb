class Array
  def binary_search(target)
    return nil if empty?

    probe_index = count / 2

    left = self.take(probe_index)
    right = self.drop(probe_index+1)

    case target <=> self[probe_index]
      when -1
        left.binary_search(target)
      when 0
        return probe_index
      when 1
        right_result = right.binary_search(target)
        right_result.nil? ? nil : probe_index + 1 + right_result
    end
  end

  def bubble_sort!
    self = self.bubble_sort
  end

  def bubble_sort(&prc)
    prc ||= Proc.new { |num1, num2| num1 <=> num2 }

    new_array = self.dup

    made_swap = true

    while made_swap
      made_swap = false
      self.length.times do |i|
        if prc.call(new_array[i], new_array[i + 1]) == 1
          new_array[i+1], new_array[i] = new_array[i], new_array[i+1]
          made_swap = true
        end
      end
    end

    return new_array
  end
end
