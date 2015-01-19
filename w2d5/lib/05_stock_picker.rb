def stock_picker(prices)

  max_profit = 0
  best_days = []

  prices.each_with_index do |price1, day1|
    next if day1 == prices.count - 1
    prices.each_with_index do |price2, day2|
      next if day2 <= day1
      if price2 - price1 > max_profit
        max_profit = price2 - price1
        best_days = [day1, day2]
      end
    end
  end

  best_days
end
