class Array

  def my_transpose
    res = self.dup

    self.each_with_index do |row, i|
      row.each_with_index do |el, j|
        res[i][j], res[j][i] = self[j][i], self[i][j] if j < i
      end
    end

    res
  end

end
