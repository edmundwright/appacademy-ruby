require_relative 'piece'

class Board
  SIZE = 8

  attr_accessor :grid

  def initialize(skip_setup = false)
    setup unless skip_setup
  end

  def setup
    @grid = Array.new(8) { Array.new(8) } # temporary
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    grid[row][col] = value
  end

  def on_board?(pos)
    pos.all? { |coord| coord.between?(0, SIZE - 1) }
  end

  def empty_square?(pos)
    on_board?(pos) && self[pos] == nil
  end

  def piece?(pos)
    on_board?(pos) && self[pos] != nil
  end

  def color(pos)
    self[pos].color
  end

  def rows
    grid
  end

  def render
    rows.each do |row|
      mapped_row = row.map do |square|
        square.nil? ? "[ ]" : "[#{square}]"
      end
      print mapped_row.join("")
      print "\n"
    end
  end
end
