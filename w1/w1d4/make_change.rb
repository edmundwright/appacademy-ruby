# We'll refactor this at weekend! But it works!

def make_change(total, denominations)
  best_result = nil

  (0...denominations.length).each do |first_index_to_use|
    denominations_to_use = denominations[first_index_to_use..-1]
    biggest_coin = denominations_to_use.first

    if denominations_to_use.length == 1 && total % biggest_coin == 0
      this_result = [biggest_coin] * ( total / biggest_coin )
    else
      if total >= biggest_coin
        remaining_total = total - biggest_coin
      else
        next
      end

      if remaining_total == 0
        this_result = [biggest_coin]
      elsif make_change(remaining_total, denominations_to_use).nil?
        this_result = nil
      else
        this_result = [biggest_coin] + make_change(remaining_total, denominations_to_use)
      end

    end

    if !this_result.nil? &&
      (best_result == nil || this_result.length < best_result.length)
        best_result = this_result
    end

  end

  best_result
end
