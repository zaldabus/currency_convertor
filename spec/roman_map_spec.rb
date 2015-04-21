require 'rspec'
require 'roman_map'

describe RomanMap do
	romanInputs = ['glob is I', 'prok is V', 'pish is X', 'tegj is L']
	subject(:romans) { RomanMap.new(romanInputs) }

	describe '#initialize' do
		it 'creates a key-value map of setting the unkown value to the roman numerals integer equivalent' do
			expect(romans['glob']).to eq(1)
			expect(romans.size).to eq(4)
		end
	end
end