require 'rspec'
require 'game'

describe Game do
  let(:board) { Board.new }
  let(:white) { double("white") }
  let(:black) { double("black") }

  it "doesn't crash when created" do
    allow(white).to receive(:color=)
    allow(black).to receive(:color=)
    allow(white).to receive(:board=)
    allow(black).to receive(:board=)

    expect do
      Game.new(board: board, player1: white, player2: black)
    end.to_not raise_error
  end
end
