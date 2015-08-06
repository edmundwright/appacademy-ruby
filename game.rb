require_relative 'errors'
require_relative 'board'
require_relative 'human_player'

class Game
  def initialize
    @board = Board.new
    @current_player = HumanPlayer.new(board, :white)
    @other_player = HumanPlayer.new(board, :black)
  end

  def play
    play_turn until winner
    puts "#{winner.to_s.capitalize} wins!"
  end

  private

  attr_reader :board, :current_player, :other_player

  def play_turn
    board.render
    puts "#{current_player.color.capitalize}'s turn."
    current_player.play_turn
    switch_players
  end

  def switch_players
    @current_player, @other_player = other_player, current_player
  end

  def winner
    return :white if board.pieces_of_color(:black).length == 0 ||
                     board.num_moves_for_color(:black) == 0
    return :black if board.pieces_of_color(:white).length == 0 ||
                     board.num_moves_for_color(:white) == 0
    nil
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
