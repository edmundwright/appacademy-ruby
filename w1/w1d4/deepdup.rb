class Array

  def deep_dup
    copy = self.map do |element|
      if element.is_a?(Array)
        element.deep_dup
      else
        element
      end
    end
    copy
  end
end
