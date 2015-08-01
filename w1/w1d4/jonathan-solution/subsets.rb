# -------------------
# Compact

class Array
  def subsets
    return [[]] if empty?
    subs = take(count - 1).subsets
    subs + subs.map { |sub| sub + [last] }
  end
end


# --------------------
# Expanded

class Array
  def subsets
    # We want to generate every possible subset of all items in an array.

    # Our approach is to take one element at a time and combine it with all combinations of the remainder of the array. We then add the new combinations to the combinations of the remainder. In doing so we shrink the array every recursive call, until it is an empty array. This is our basecase.

    # Base case. We need an empty array as an element in order to combine successfully.
    return [[]] if self.empty?

    # Chosen element to combine. We pick from the back.
    chosen = self.last

    # Recursive call to get the remainder of the combinations. We shrink the array from the back, as we picked the chosen element from the back.
    remainder_subsets = self.take(self.count - 1).subsets

    # We combine our chosen element with all the subsets of the remainder. This creates a new array with subsets
    new_subsets = remainder_subsets.map do |subset|
      subset + [chosen]
    end

    # Return the sum of the remainder and new subsets
    remainder_subsets + new_subsets
  end
end


# --------------------
# Walkthrough for [1].subsets

class Array
  def subsets
    # call: [1].subsets
    # arguments: self == [1]
    # desired return: [[], [1]]

    return [[]] if self.empty?
    # Not empty. Continue.

    chosen = self.last
    # chosen == 1

    remainder_subsets = self.take(self.count - 1).subsets
    # remainder_subsets == self.take(0).subsets
    # remainder_subsets == [].subsets
    # remainder_subsets == [[]]


    new_subsets = remainder_subsets.map { |subset| subset + [chosen] }
    # new_subsets == [[]].map { |subset| subset + [chosen] }
    # 1st map iteration:
    #   subset == [] && chosen == 1
    #   [] + [1]
    #   [1]
    # new_subset == [[1]]

    remainder_subsets + new_subsets
    # [[]] + [[1]]
    # [[], [1]]
  end
end


# --------------------
# Walkthrough for [1, 2].subsets

class Array
  def subsets
    # call: [1, 2].subsets
    # arguments: self == [1, 2]
    # desired return: [[], [1], [2], [1, 2]]

    return [[]] if self.empty?
    # Not empty. Continue.

    chosen = self.last
    # chosen == 2

    remainder_subsets = self.take(self.count - 1).subsets
    # remainder_subsets == self.take(1).subsets
    # remainder_subsets == [1].subsets
    # remainder_subsets == [[], [1]]


    new_subsets = remainder_subsets.map { |subset| subset + [chosen] }
    # new_subsets == [[], [1]].map { |subset| subset + [chosen] }
    # 1st map iteration:
    #   subset == [] && chosen == 2
    #   [] + [2]
    #   [2]
    # 2nd map iteration:
    #   subset == [1] && chosen == 2
    #   [1] + [2]
    #   [1, 2]
    # new_subset == [[2], [1, 2]]

    remainder_subsets + new_subsets
    # [[], [1]] + [[2], [1, 2]]
    # [[], [1], [2], [1, 2]]
  end
end







