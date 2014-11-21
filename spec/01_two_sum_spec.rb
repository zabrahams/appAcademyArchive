require 'rspec'
require '01_two_sum'

describe 'Array#two_sum' do

  it "should return the empty array if there are not two-sums" do
    expect([1, 2, 3, 4].two_sum).to eq([])
  end

  it "should return two sums" do
    expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
  end

  it "should return sorted dictionary wise" do
    expect([-1, 0, 2, -2, 1].two_sum).to_not eq([[2, 3], [0, 4]])
  end

  it "should return pairs with a common element" do
    expect([-5, 5, 5].two_sum).to eq([[0, 1], [0, 2]])
  end

end
