
# This is a ready rough and ready, and unfinished solution!

def passes(arrangement)
  all_regions = columns(arrangement) + check_diagonal(true, arrangement) + check_diagonal(false, arrangement)

  all_regions.all? do |region|
    one_queen?(region)
  end
end

def check_diagonal(back, grid) # We copied this from Connect 4 solution for speed
  start_col = back ? 0 : (8 - 1)
  diagonals = []
  start_spots = (0...8).map { |col| [0, col] }
  start_spots += (1...8).map { |row| [row, start_col] }

  start_spots.each do |row, col|
    diagonal = []
    while on_board?(row, col)
      diagonal << grid[row][col]
      row += 1
      col += back ? 1 : -1
    end
    diagonals << diagonal
  end

  return diagonals
end

def on_board?(row, col) # We copied this from Connect 4 solution for speed
  (row < 8 && row >= 0) &&
  (col < 8 && col >= 0)
end

def columns(grid)
  grid.transpose
end

def rows(grid)
  grid
end

def one_queen?(array)
  array.count(true) <= 1
end

def solve
  (0...8).each do |queen0| # Yes, we went there.
    (0...8).each do |queen1|
      (0...8).each do |queen2|
        (0...8).each do |queen3|
          (0...8).each do |queen4|
            (0...8).each do |queen5|
              (0...8).each do |queen6|
                (0...8).each do |queen7|
                  arrangement = Array.new(8) { Array.new(8) }
                  arrangement[0][queen0] = true
                  arrangement[1][queen1] = true
                  arrangement[2][queen2] = true
                  arrangement[3][queen3] = true
                  arrangement[4][queen4] = true
                  arrangement[5][queen5] = true
                  arrangement[6][queen6] = true
                  arrangement[7][queen7] = true

                  if passes(arrangement)
                    print_grid(arrangement)
                    return
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

def print_grid(grid)
  grid.each do |row|
    print row.map { |el| el ? "X" : "0" }.join("")
    print "\n"
  end
end

if __FILE__ == $PROGRAM_NAME
  solve
end
