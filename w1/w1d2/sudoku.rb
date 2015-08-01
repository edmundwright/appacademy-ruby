require 'byebug'
require 'colorize'

class Tile
  COLORS = {1 => :red, 2 => :green, 3 => :yellow, 4 => :blue, 5 => :magenta,
            6 => :cyan, 7 => :light_red, 8 => :light_green, 9 => :light_blue}

  attr_reader :value

  def initialize(value)
    @given = !value.nil?
    @value = value
  end

  def value=(new_value)
    @value = new_value unless given?
  end

  def given?
    @given
  end

  def to_s
    if value.nil?
      " "
    else
      given? ? value.to_s : value.to_s.colorize(COLORS[value])
    end
  end
end

class Board
  def self.from_file(file_name)
    grid = []

    File.readlines(file_name).each do |line|
      grid << parse_line(line)
    end

    Board.new(grid)
  end

  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def render
    system("clear")
    print "+#{"-" * (grid.length * 2 - 1)}+"
    grid.each do |row|
      print "\n|#{row.join(" ")}|"
    end
    print "\n+#{"-" * (grid.length * 2 - 1)}+"
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    grid[x][y].value = value
  end

  def solved?
    rows_solved? && columns_solved? && squares_solved?
  end

  def in_range?(pos)
    pos.all? { |coord| coord.between?(0, 8) }
  end

  private

  def self.parse_line(line)
    line.chomp.split("").map { |value_str| parse_value(value_str) }
  end

  def self.parse_value(value_str)
    value = value_str == "0" ? nil : value_str.to_i
    Tile.new(value)
  end

  def self.complete?(regions)
    regions.all? do |region|
      (1..9).all? { |num| region.map(&:value).include?(num) }
    end
  end

  def rows_solved?
    self.class.complete?(grid)
  end

  def columns_solved?
    self.class.complete?(columns)
  end

  def squares_solved?
    self.class.complete?(squares)
  end

  def columns
    grid.transpose
  end

  def squares
    squares = []

    grid.each_slice(3) do |row_of_squares|
      row_of_squares.transpose.each_slice(3) do |square|
        squares << square.flatten
      end
    end

    squares
  end
end

class Game
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def play
    until board.solved?
      board.render
      pos, value = prompt
      board[pos] = value
    end

    board.render
    puts "\nYou won!"
  end

  private

  def prompt
    [get_pos, get_value]
  end

  def get_pos
    pos = nil

    until pos && valid_pos?(pos)
      puts "\nTry again." if pos
      puts "\nWhich position?"
      print "> "
      pos = $stdin.gets.chomp.split(",").map(&:to_i)
    end

    pos
  end

  def get_value
    value = nil

    until value && valid_value?(value)
      puts "\nTry again." if value
      puts "\nWhich number?"
      print "> "
      value = $stdin.gets.chomp.to_i
    end

    value
  end

  def valid_pos?(pos)
    board.in_range?(pos) && !board[pos].given?
  end

  def valid_value?(value)
    value.between?(1, 9)
  end
end

if __FILE__ == $PROGRAM_NAME
  file_name = (ARGV[0] ? ARGV[0] : "puzzles/sudoku#{rand(1..3)}.txt")
  board = Board.from_file(file_name)
  Game.new(board).play
end
