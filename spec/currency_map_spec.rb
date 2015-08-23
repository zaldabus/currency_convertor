require 'rspec'
require 'currency_map'

describe CurrencyMap do
	roman_inputs = [['glob', 'I'], ['prok', 'V'], ['pish', 'X'], ['tegj', 'L']]

	currency_inputs = [
		['glob glob Silver', '34 Credits'],
		['glob prok Gold', '57800 Credits'],
		['pish pish Iron', '3910 Credits']
	]

	subject(:currency_map) { CurrencyMap.new(roman_inputs, currency_inputs) }

	describe '#initialize' do
		it 'creates a key-value map giving the conversion of each currency to all other given amounts' do
			expect(currency_map[:silver]).to eq(17)
			expect(currency_map[:gold]).to eq(14450)
		end
	end
end