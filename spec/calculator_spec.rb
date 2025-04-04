require_relative '../lib/calculator'
require 'rspec'


RSpec.describe Calculator do
  let(:calculator) {Calculator.new}

  it 'add two number correctly' do
    expect(calculator.add(2, 3)).to eq(5)
  end

  it 'subtract two number correctly' do
    expect(calculator.subtract(5,3)).to eq(2)
  end
end