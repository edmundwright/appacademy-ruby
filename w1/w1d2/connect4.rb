require 'colorize'
require 'byebug'

class Board
  def initialize
    @grid = Array.new(6) { Array.new(7) }
  end

  def render
    system("clear")
    grid.each do |row|
      puts "|#{row.map(&stringify_disc).join(" ")}|"
    end
    puts "+#{"-" * (width * 2 - 1)}+"
    puts " #{(0...width).to_a.join(" ")}"
  end

  def drop_disc(col_index, disc)
    pos = next_pos_on_column(col_index)

    self[pos] = disc
  end

  def winning_move?(col_index, disc)
    connected_length_from_move(col_index, disc) >= 4
  end

  def full?
    grid.all? { |row| row.none?(&:nil?) }
  end

  def column_full?(col_index)
    columns[col_index].all?
  end

  private

  attr_reader :grid

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    grid[x][y] = value
  end

  def stringify_disc
    ->(disc) { disc ? "O".colorize(disc) : " " }
  end

  def next_pos_on_column(col_index)
    pos = [-1, col_index]

    pos[0] -= 1 until self[pos].nil?

    pos[0] < 0 ? [height + pos[0], pos[1]] : pos
  end

  def connected_length_from_move(col_index, disc)
    pos = next_pos_on_column(col_index)
    self[pos] = disc

    deltas = [[1, 1], [0, 1], [1, 0], [-1, 1]]
    max_connected_length = 0

    deltas.each do |delta|
      connected_length = 0
      current_pos = pos.dup

      [delta, delta.map { |num| -num }].each do |direction|
        while in_range?(current_pos) && self[current_pos] == disc
          connected_length += 1
          current_pos[0] += direction[0]
          current_pos[1] += direction[1]
        end
        current_pos = pos.dup
      end

      if connected_length - 1 > max_connected_length
        max_connected_length = connected_length - 1
      end
    end

    self[pos] = nil
    max_connected_length
  end

  def height
    grid.length
  end

  def width
    grid.first.length
  end

  def columns
    grid.transpose
  end

  def in_range?(pos)
    pos.first.between?(0, height-1) && pos.last.between?(0, width-1)
  end
end

class Game
  def initialize(num_players = 2)
    @board = Board.new
    @players = COLORS.take(num_players)
  end

  def play
    winner = nil

    until draw? || winner
      players.each do |player|
        col_index = get_input(player)
        winner = player if board.winning_move?(col_index, player)
        board.drop_disc(col_index, player)
        break if winner
      end
    end

    end_game(winner)
  end

  private

  COLORS = [:red, :blue, :yellow, :green, :cyan, :magenta]

  def self.stringify_player(player)
    player.to_s.capitalize.colorize(player)
  end

  attr_reader :board, :players

  def end_game(winner)
    board.render

    if winner
      puts "#{Game.stringify_player(winner)} wins!"
    else
      puts "It's a tie!"
    end
  end

  def draw?
    board.full?
  end

  def get_input(player)
    board.render
    puts "\n#{Game.stringify_player(player)}'s turn."

    col_index = nil

    until col_index && !board.column_full?(col_index)
      puts "\nTry again." if col_index
      puts "\nWhich column?"
      print "> "
      col_index = $stdin.gets.chomp.to_i
    end

    col_index
  end
end
