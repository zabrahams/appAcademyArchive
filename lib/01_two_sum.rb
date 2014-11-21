class Array

  def two_sum
    res = []

    self.each_index do |num1|
      next if num1 == self.count - 1
      (num1 + 1...self.count).each do |num2|
        res << [num1, num2] if self[num1] + self[num2] == 0
      end
    end

    res
  end

end
