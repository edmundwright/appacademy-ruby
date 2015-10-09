require 'rspec'
require 'board'

describe Board do
  let(:board) { Board.new(true) }

  context "jump is available" do
    before(:each) do
      Piece.new(board, [4,4], :black)
      Piece.new(board, [5,5], :white)
    end

    it "does not raise error when valid move requested" do
      expect do
        board.move([[5,5], [3,3]], :white)
      end.to_not raise_error
    end

    it "implements valid jump" do
      board.move([[5,5], [3,3]], :white)
      expect(board[[5,5]].nil? && board[[3,3]].color==:white).to be true
    end

    it "implements taking of opponent's piece" do
      board.move([[5,5], [3,3]], :white)
      expect(board[[4,4]].nil?).to be true
    end

    it "raises error when try to move opponents' piece" do
      expect do
        board.move([[5,5], [3,3]], :black)
      end.to raise_error(InvalidMoveError)
    end

    it "raises error when try to slide but jump is available" do
      expect do
        board.move([[5,5], [4,6]], :black)
      end.to raise_error(InvalidMoveError)
    end
  end

  context "jump isn't available" do
    before(:each) do
      Piece.new(board, [5,6], :white)
      Piece.new(board, [1,1], :white)
    end

    it "implements valid slide" do
      board.move([[5,6], [4,7]], :white)
      expect(board[[5,6]].nil? && board[[4,7]].color==:white).to be true
    end

    it "raises error when invalid move requested" do
      expect do
        board.move([[5,6], [4,6]], :white)
      end.to raise_error(InvalidMoveError)
    end

    it "raises error when move requested from square with no piece on it" do
      expect do
        board.move([[6,6], [4,4]], :white)
      end.to raise_error(BoardError)
    end

    it "doesn't allow pawns to move backwards" do
      expect do
        board.move([[1,1], [2,2]], :white)
      end.to raise_error(InvalidMoveError)
    end

    it "pawn transforms to king and so can move backwards after reaches final row" do
      expect do
        board.move([[1,1], [0,2]], :white)
        board.move([[0,2], [1,3]], :white)
      end.to_not raise_error
    end
  end
end
