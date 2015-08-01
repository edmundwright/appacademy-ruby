class PolyTreeNode
  attr_reader :value, :children, :parent

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(parent_node)
    old_parent = parent
    old_parent.children.delete(self) if old_parent
    if parent_node
      @parent = parent_node
      parent_node.children << self
    else
      @parent = nil
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "The kid is not my son!" if !children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value

    children.each do |child|
      child_result = child.dfs(target_value)
      return child_result if child_result
    end

    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      next_node = queue.shift
      if next_node.value == target_value
        return next_node
      else
        queue += next_node.children
      end
    end
    nil
  end

  def trace_path_back(root)
    current_node = self
    path = [current_node.value]
    
    until current_node == root
      current_node = current_node.parent
      path.unshift(current_node.value)
    end

    path
  end
end
