class HumanPlayer
  attr_reader :board, :color

  def initialize(board, color)
    @board = board
    @color = color
  end

  def play_turn
    piece_pos, move_sequence = get_moves
    if board.color(piece_pos) != color
      raise InvalidMoveError.new("Can't move opponent's color!")
    end
    board.move(piece_pos, move_sequence)
  rescue InvalidMoveError, BoardError, HumanInputError => e
    puts "#{e.message} Try again."
    retry
  end

  def get_moves
    puts "Position of piece you wish to move? (e.g. 'A1')"
    print "> "
    piece_pos = translate_pos(gets.chomp)
    puts "Sequence of moves? (e.g. 'C3 E4 G6')"
    print "> "
    move_sequence = parse_move_sequence(gets.chomp)
    [piece_pos, move_sequence]
  end

  def parse_move_sequence(sequence_string)
    move_strings = sequence_string.split(" ")
    if move_strings.empty?
      raise HumanInputError.new("Unrecognised move sequence!")
    else
      move_strings.map { |move_string| translate_pos(move_string) }
    end
  end

  def translate_pos(pos_string)
    col_string, row_string = pos_string.split("")
    pos = [row_string.to_i, col_string.ord - "A".ord]
    if board.on_board?(pos)
      pos
    else
      raise HumanInputError.new("Unrecognised position!")
    end
  end
end
