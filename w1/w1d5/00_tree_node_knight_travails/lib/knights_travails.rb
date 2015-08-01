require_relative "00_tree_node"

class KnightPathFinder
  DIREC_MOVES = [1, -1, 2, -2]
  BOARD_WIDTH = 8

  attr_reader :root
  attr_accessor :visited_positions, :num_nodes

  def initialize(start_pos)
    @visited_positions = [start_pos]
    @root = PolyTreeNode.new(start_pos)
    @num_nodes = 1
  end

  def self.valid_moves(pos)
    moves = []

    DIREC_MOVES.each do |horiz|
      DIREC_MOVES.each do |vert|
        move = [pos[0] + vert, pos[1] + horiz]
        moves << move if horiz.abs != vert.abs && on_board?(move)
      end
    end

    moves
  end

  def self.on_board?(pos)
    pos.all? { |el| el.between?(0, BOARD_WIDTH - 1) }
  end

  def new_move_positions(pos)
    new_moves = KnightPathFinder.valid_moves(pos)
    new_moves.delete_if { |move| visited_positions.include?(move) }
    self.visited_positions += new_moves
    new_moves
  end

  def build_move_tree
    queue = [root]

    until queue.empty?
      next_node = queue.shift
      new_move_positions(next_node.value).each do |child_pos|
        child = PolyTreeNode.new(child_pos)
        self.num_nodes += 1
        next_node.add_child(child)
        queue << child
      end
    end

    nil
  end

  def find_path(end_pos)
    end_node = root.dfs(end_pos)
    end_node.trace_path_back(root)
  end
end
