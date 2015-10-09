require 'rspec'
require 'game'

describe Game do
  it "can be created without any arguments" do
    expect do
      Game.new
    end.to_not raise_error
  end

  it "can be created with arguments" do
    expect do
      Game.new(board: Board.new, player1: ComputerPlayer.new(:white), player2: HumanPlayer.new(:black))
    end.to_not raise_error
  end
end
