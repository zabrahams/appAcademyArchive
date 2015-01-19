class Array

  def my_uniq
    result = []
    self.each do |el|
      result << el unless result.include?(el)
    end

    result
  end

end
