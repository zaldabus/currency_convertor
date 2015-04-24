require 'rspec'
require 'roman_convertor'

describe RomanConvertor do
	roman_inputs = [['glob', 'I'], ['prok', 'V'], ['pish', 'X'], ['tegj', 'L']]
	subject(:roman_convertor) { RomanConvertor.new(roman_inputs) }

	describe '#value_map_access' do
		it 'creates a key-value map setting the unkown value to the roman numerals equivalent' do
			expect(roman_convertor.value_map_access('glob')).to eq('I')
		end
	end

	describe '#convert_foreign_values_to_integer' do
		context 'converts foreign values representing roman numerals to their combined integer value' do
			it 'for singular values' do
				expect(roman_convertor.convert_foreign_values_to_integer(['glob'])).to eq(1)
			end

			it 'for multiple values' do
				expect(roman_convertor.convert_foreign_values_to_integer(['glob', 'glob', 'glob'])).to eq(3)
			end

			it 'for multiple values where the last type is less than the previous type' do
				expect(roman_convertor.convert_foreign_values_to_integer(['pish', 'glob', 'glob'])).to eq(12)
			end

			it 'for multiple values where the last type is greater than the previous type' do
				expect(roman_convertor.convert_foreign_values_to_integer(['glob', 'prok'])).to eq(4)
			end

			it 'for complex multiple values' do
				expect(roman_convertor.convert_foreign_values_to_integer(['pish', 'tegj', 'prok', 'glob', 'glob', 'glob'])).to eq(48)
			end
		end
	end

	describe '#invalid_foreign_combination?' do
		it 'returns false for valid combinations' do
			expect(roman_convertor.invalid_foreign_combination?(['glob'])).to be_falsey
			expect(roman_convertor.invalid_foreign_combination?(['glob', 'glob'])).to be_falsey
			expect(roman_convertor.invalid_foreign_combination?(['prok', 'glob', 'glob'])).to be_falsey
			expect(roman_convertor.invalid_foreign_combination?(['glob', 'prok'])).to be_falsey
		end

		it 'returns true for invalid combinations' do
			expect(roman_convertor.invalid_foreign_combination?(['blarg'])).to be_truthy
			expect(roman_convertor.invalid_foreign_combination?(['glob', 'glob', 'glob', 'glob'])).to be_truthy
			expect(roman_convertor.invalid_foreign_combination?(['prok', 'prok'])).to be_truthy
			expect(roman_convertor.invalid_foreign_combination?(['glob', 'prok', 'glob'])).to be_truthy
			expect(roman_convertor.invalid_foreign_combination?(['glob', 'prok', 'glob'])).to be_truthy
			expect(roman_convertor.invalid_foreign_combination?(['prok', 'tegj'])).to be_truthy
		end
	end
end