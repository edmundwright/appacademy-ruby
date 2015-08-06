require_relative 'board'

class Game
  attr_reader :board, :current_player, :other_player

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

  def take_turn
    begin
      piece_pos, move_sequence = current_player.get_moves
      board.move(piece_pos, move_sequence)
    rescue InvalidMoveError, BoardError => e
      puts "#{e.message} Try again."
      retry
    end
  end

  def winner
    if board.num_pieces_of_color(:black) == 0 ||
       board.num_moves_for_color(:black) == 0
      :white
    elsif board.num_pieces_of_color(:white) == 0 ||
          board.num_moves_for_color(:white) == 0
      :black
    else
      nil
    end
  end
end
