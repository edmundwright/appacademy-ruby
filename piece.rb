require 'byebug'

class Piece
  BLACK_PAWN_DELTAS = [[1, 1], [1, -1]]
  WHITE_PAWN_DELTAS = [[-1, 1], [-1, -1]]

  def self.add_delta(pos, delta)
    [pos[0] + delta[0], pos[1] + delta[1]]
  end

  attr_reader :color

  def initialize(board, pos, color)
    @is_king = false
    @board = board
    @pos = pos
    @color = color
  end

  def to_s
    is_king? ? "K" : "P"
  end

  def dup(new_board)
    self.class.new(new_board, pos.dup, color)
  end

  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
    else
      raise InvalidMoveError
    end
  end

  protected

  def perform_moves!(move_sequence)
    if move_sequence.length == 1
      move = move_sequence.first
      perform_slide(move) || perform_jump(move) || raise(InvalidMoveError)
    else
      move_sequence.each do |move|
        perform_jump(move) || raise(InvalidMoveError)
      end
    end
  end

  private

  attr_reader :pos, :board

  def is_king?
    @is_king
  end

  def valid_move_seq?(move_sequence)
    begin
      dup_board = board.dup
      dup_board[pos].perform_moves!(move_sequence)
    rescue InvalidMoveError
      false
    else
      true
    end
  end

  def perform_slide(end_pos)
    return false unless possible_slides.include?(end_pos)
    move_to(end_pos)
    true
  end

  def perform_jump(end_pos)
    jump_that_ends_there = possible_jumps.select do |_, second_step|
      second_step == end_pos
    end.first

    return false unless jump_that_ends_there

    first_step, second_step = jump_that_ends_there
    board.remove_piece(first_step)
    move_to(second_step)
    true
  end

  def move_to(end_pos)
    board.remove_piece(pos)
    board[end_pos] = self
    @pos = end_pos
    maybe_promote
  end

  def maybe_promote
    transform_into_king if pos[0] == board.class::SIZE - 1 || pos[0] == 0
  end

  def transform_into_king
    @is_king = true
  end

  def possible_slides
    slides = deltas.map { |delta| self.class.add_delta(pos, delta) }
    slides.select { |end_pos| board.empty_square?(end_pos) }
  end

  def possible_jumps
    deltas.map do |delta|
      first_step = self.class.add_delta(pos, delta)
      second_step = self.class.add_delta(first_step, delta)
      [first_step, second_step]
    end.select do |first_step, second_step|
      board.piece?(first_step) && board.color(first_step) != color &&
        board.empty_square?(second_step)
    end
  end

  def deltas
    if is_king?
      BLACK_PAWN_DELTAS + WHITE_PAWN_DELTAS
    elsif color ==:black
      BLACK_PAWN_DELTAS
    else
      WHITE_PAWN_DELTAS
    end
  end
end

class InvalidMoveError < StandardError
end
