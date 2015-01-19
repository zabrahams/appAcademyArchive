require 'rspec'
require '00_remove_dups.rb'

describe "Array#my_uniq" do

  it "gets rid of duplicates" do
    expect([1, 2, 1, 3, 3].my_uniq).to eq([1, 2, 3])
  end

  it "should return [] when given []" do
    expect([].my_uniq).to eq([])
  end

  it "returns caller if there are no duplicates" do
    expect([3, 5, 43, 6].my_uniq).to eq([3, 5, 43, 6])
  end
end
