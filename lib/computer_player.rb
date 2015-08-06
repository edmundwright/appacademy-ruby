class ComputerPlayer
  attr_accessor :board, :color

  def initialize
    @board = nil
    @color = nil
  end

  def play_turn
    available_jumps = board.available_jumps_for_color(color)
    if available_jumps.empty?
      move = board.available_slides_for_color(color).sample
    else
      move = available_jumps.sample
    end
    board.move(move, color)
  end

  private

  attr_reader :board
end
