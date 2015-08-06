require_relative 'piece'
require 'byebug'

class Board
  SIZE = 8

  attr_accessor :grid

  def initialize(skip_setup = false)
    @grid = Array.new(SIZE) { Array.new(SIZE) }
    setup unless skip_setup
  end

  def setup
     # temporary
  end

  def [](pos)
    raise "Not on board!" unless on_board?(pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    raise "Not on board!" unless on_board?(pos)
    row, col = pos
    grid[row][col] = value
  end

  def remove_piece(pos)
    raise "Nothing there!" unless piece?(pos)
    self[pos] = nil
  end

  def dup
    dup_board = self.class.new(true)
    pieces.each { |piece| dup_board[piece.pos] = piece.dup(dup_board) }
    dup_board
  end

  def pieces
    grid.flatten.compact
  end

  def on_board?(pos)
    pos.all? { |coord| coord.between?(0, SIZE - 1) }
  end

  def empty_square?(pos)
    on_board?(pos) && self[pos].nil?
  end

  def piece?(pos)
    on_board?(pos) && !self[pos].nil?
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
