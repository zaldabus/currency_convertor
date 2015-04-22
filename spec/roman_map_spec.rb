require 'rspec'
require 'roman_convertor'

describe RomanConvertor do
	roman_inputs = [['glob', 'I'], ['prok', 'V'], ['pish', 'X'], ['tegj', 'L']]
	subject(:roman_convertor) { RomanConvertor.new(roman_inputs) }

	describe '#value_map' do
		it 'creates a key-value map setting the unkown value to the roman numerals equivalent' do
			expect(roman_convertor.value_map('glob')).to eq('I')
		end
	end

	describe '#roman_simple_value' do
		it 'returns the direct integer value for a simple roman value' do
			expect(roman_convertor.roman_simple_value('I')).to eq(1)
		end
	end

	describe '#roman_compound_value' do
		it 'returns a combined value for multiples of the same type' do
			expect(roman_convertor.roman_compound_value('III')).to eq(3)
		end

		it 'returns a combined value for multiples where the last type is less than the previous' do
			expect(roman_convertor.roman_compound_value('XII')).to eq(12)
		end

		it 'returns a combined value for multipes where the last type is greater than the previous' do
			expect(roman_convertor.roman_compound_value('IV')).to eq(4)
		end
	end
end