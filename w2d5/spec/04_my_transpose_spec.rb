require 'rspec'
require '04_my_transpose'

describe "#my_transpose" do

  it "should return [] if given []" do
    expect([].my_transpose).to eq([])
  end

  it "should transpose a matrix" do
    input = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    output = [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
    expect(input.my_transpose).to eq(output)    
  end

end
