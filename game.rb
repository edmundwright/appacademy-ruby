class Game
  attr_reader :board, :current_player, :other_player
  
  def initialize
    @board = Board.new
    @current_player = HumanPlayer.new(board)
    @other_player = HumanPlayer.new(board)
  end
end
