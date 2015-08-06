class Piece
  BLACK_PAWN_DELTAS = [[1, 1], [1, -1]]
  WHITE_PAWN_DELTAS = [[-1, 1], [-1, -1]]

  def self.add_delta(pos, delta)
    [pos[0] + delta[0], pos[1] + delta[1]]
  end

  attr_reader :color, :pos, :board

  def initialize(board, pos, color)
    @is_king = false
    @board = board
    @pos = pos
    @color = color
  end

  def perform_slide(end_pos)
    possible_slides.include?(end_pos) ? move_to(end_pos) : false
  end

  def perform_jump(first_step, second_step)
    return false unless possible_jumps.include?([first_step, second_step])
    move_to(second_step)
    board[first_step] = nil
  end

  def move_to(end_pos)
    board[pos] = nil
    board[end_pos] = self
    @pos = end_pos
    maybe_promote
  end

  def maybe_promote
    transform_into_king if pos[0] == board.class::SIZE - 1 || pos[0] == 0
  end

  def is_king?
    @is_king
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

  def to_s
    is_king? ? "K" : "P"
  end
end
