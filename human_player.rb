class HumanPlayer
  attr_reader :color

  def initialize(board, color)
    @board = board
    @color = color
  end

  def play_turn
    moves = get_moves

    if board.color(moves.first) != color
      raise InvalidMoveError.new("Can't move opponent's color!")
    end

    board.move(moves)
  rescue InvalidMoveError, BoardError, HumanInputError => e
    puts "#{e.message} Try again."
    retry
  end

  private

  attr_reader :board

  def get_moves
    puts "Please enter position of piece you wish to move, followed by"
    puts "positions you wish to move to, in order. (e.g. 'A1 C3 E4 G6')"
    print "> "
    parse_moves(gets.chomp)
  end

  def parse_moves(human_input)
    move_strings = human_input.split(" ")
    if move_strings.length < 2
      raise HumanInputError.new("Position or move not entered!")
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
