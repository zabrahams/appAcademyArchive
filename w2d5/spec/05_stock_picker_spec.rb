require 'rspec'
require '05_stock_picker'

describe "#stock_picker" do

  it "returns [] when given []" do
    expect(stock_picker([])).to eq([])
  end

  it "picks days with highest profit" do
    prices = [1, 2, 9, 13, 1, 2, 8, 10]
    expect(stock_picker(prices)).to eq([0, 3])
  end


end
