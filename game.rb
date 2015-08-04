require_relative 'board'
require_relative 'keypress'
require 'yaml'

class Game
  ACTION_KEYS = {"s" => :save, "u" => :unflag, "f" => :flag, "r" => :reveal,
                 "q" => :quit}
  ARROW_KEYS = {"\e[A" => :up, "\e[B" => :down, "\e[C" => :right,
                "\e[D" => :left}

  attr_reader :board

  def initialize(board)
    @board = board
  end

  def self.start_game
    puts "Press l to load game. Otherwise press enter."
    print "> "
    input = gets.chomp.downcase
    if input == "l"
      game = Game.new(YAML.load(File.read("saved_game.txt")))
    else
      game = Game.new(Board.new)
    end
    game.play
  end

  def play
    take_turn until over?

    if won?
      board.render
      puts "You won!"
    else
      board.reveal_all_bombs
      board.render
      puts "BOOM! You lost!"
    end
  end

  def take_turn
    key_entered = nil

    until ACTION_KEYS.include?(key_entered)
      board.render
      puts "Use arrow keys to move cursor, or type f/u/r/s/q"
      puts "to flag/unflag/reveal/save/quit."

      key_entered = read_char

      if ARROW_KEYS.include?(key_entered)
        board.move_curs(ARROW_KEYS[key_entered])
      end
    end

    tile_to_alter = board[board.cursor_pos]

    case ACTION_KEYS[key_entered]
    when :save
      save_game
    when :quit
      abort
    when :flag
      tile_to_alter.flag
    when :unflag
      tile_to_alter.unflag
    when :reveal
      tile_to_alter.reveal_until_fringe
    end
  end

  def over?
    won? || lost?
  end

  def won?
    board.swept?
  end

  def lost?
    board.exploded_bomb?
  end

  def save_game
    File.open("saved_game.txt", "w") do |f|
      f.puts board.to_yaml
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.start_game
end
