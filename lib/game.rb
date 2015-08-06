require_relative 'errors'
require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'
require 'byebug'

class Game
  def initialize
    @board = Board.new
    @current_player = HumanPlayer.new(board, :white)
    @other_player = ComputerPlayer.new(board, :black)
    @turns_played = 0
  end

  def play
    play_turn until winner
    board.render
    puts "#{winner.to_s.capitalize} wins!"
  end

  private

  attr_reader :board, :current_player, :other_player

  def play_turn
    @turns_played += 1
    board.render
    puts "Turn #{@turns_played}. #{current_player.color.capitalize}'s turn."
    current_player.play_turn
    switch_players
  end

  def switch_players
    @current_player, @other_player = other_player, current_player
  end

  def winner
    return :white if board.pieces_of_color(:black).length == 0 ||
                     board.available_moves_for_color(:black).length == 0
    return :black if board.pieces_of_color(:white).length == 0 ||
                     board.available_moves_for_color(:white).length == 0
    nil
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
