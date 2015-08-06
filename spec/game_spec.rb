require 'rspec'
require 'game'

describe Game do
  let(:player1) 
  describe "#play" do
    it "doesn't crash" do
      game = Game.new
      expect(game.play).to_not raise_error
    end
  end
end
