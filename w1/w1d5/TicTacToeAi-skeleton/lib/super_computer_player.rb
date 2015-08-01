require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)

    winning_move = nil
    non_losing_move = nil

    node.children.each do |child|
      winning_move = child.prev_move_pos if child.winning_node?(mark)
      non_losing_move = child.prev_move_pos unless child.losing_node?(mark)
    end

    winning_move || non_losing_move || raise("Computer sucks.")
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Edmund & Derek")
  cp = SuperComputerPlayer.new

  TicTacToe.new(cp, hp).run
end
