require 'rspec'
require 'input_parser'

describe InputParser do
	subject(:input) { InputParser.new('test_input.txt') }

	describe '#romans' do
		it 'returns the subset of the input that represents the roman mapping' do
			expect(input.romans).to include('glob is I')
		end

		it 'does not include non roman mappings' do
			expect(input.romans).to_not include('glob glob Silver is 34 Credits')
			expect(input.romans).to_not include('how much is pish tegj glob glob ?')
		end
	end

	describe '#currencies' do
		it 'returns the subset of the input that represents the currency mapping' do
			expect(input.currencies).to include('glob glob Silver is 34 Credits')
		end

		it 'does not include any roman mappings or questions' do
			expect(input.currencies).to_not include('glob is I')
			expect(input.currencies).to_not include('how much is pish tegj glob glob ?')
		end
	end

	describe '#questions' do
		it 'returns the subset of the input that represents the questions' do
			expect(input.questions).to include('how much is pish tegj glob glob ?')
		end

		it 'does not include any roman mappings or currency mappings' do
		expect(input.questions).to_not include('glob is I')
		expect(input.questions).to_not include('glob glob Silver is 34 Credits')
		end
	end
end