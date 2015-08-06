class Piece
  BLACK_PAWN_DELTAS = [[1, 1], [1, -1]]
  BLACK_KING_DELTAS = BLACK_PAWN_DELTAS + [[-1, 1], [-1, -1]]

  def self.add_delta(pos, delta)
    [pos[0] + delta[0], pos[1] + delta[1]]
  end

  attr_reader :color, :pos

  def initialize(board, pos, color)
    @is_king = false
    @board = board
    @pos = pos
    @color = color
  end

  def perform_slide(end_pos)
    possible_jumps.include?(end_pos) ? move_to(end_pos) : false
  end

  def perform_jump(first_step, second_step)
    return false if possible_jumps.include?([first_step, second_step])
    move_to(second_step)
    board[first_step] = nil
  end

  def move_to(end_pos)
    board[pos] = nil
    board[end_pos] = self
    @pos = end_pos
  end

  def is_king?
    @is_king
  end

  def transform_into_king
    @is_king = true
  end

  def possible_slides
    slides = deltas.map { |delta| add_delta(pos, delta) }
    slides.select { |end_pos| board.empty_at?(end_pos) }
  end

  def possible_jumps
    jumps = deltas.map do |delta|
      first_step = add_delta(pos, delta)
      second_step = add_delta(first_step, delta)
      [first_step, second_step]
    end
    jumps.select do |jump|
      board.piece_at?(jump[0]) && board.color_at(jump[0]) != color &&
        board.empty_at?(jump[1])
    end
  end

  def deltas
    if color == :black
      is_king? ? BLACK_KING_DELTAS : BLACK_PAWN_DELTAS
    else
      if is_king?
        BLACK_KING_DELTAS.map { |delta| [-delta[0], delta[1]] }
      else
        BLACK_PAWN_DELTAS.map { |delta| [-delta[0], delta[1]] }
      end
    end
  end
end
