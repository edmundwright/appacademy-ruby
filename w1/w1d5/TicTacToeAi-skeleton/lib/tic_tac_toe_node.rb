require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos, :other_mover_mark

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    result = []

    3.times do |row|
      3.times do |col|
        pos = [row, col]
        if board.empty?(pos)
          new_board = board.dup
          new_board[pos] = next_mover_mark
          child = TicTacToeNode.new(new_board, opponent(next_mover_mark), pos)
          result << child
        end
      end
    end

    result
  end

  def opponent(evaluator)
    evaluator == :x ? :o : :x
  end

  def losing_node?(evaluator)
    return board.winner == opponent(evaluator) if board.over?

    if next_mover_mark == evaluator
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    return board.winner == evaluator if board.over?

    if next_mover_mark == evaluator
      children.any? { |child| child.winning_node?(evaluator) }
    else
      children.all? { |child| child.winning_node?(evaluator) }
    end
  end

end
