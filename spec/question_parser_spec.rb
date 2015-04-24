require 'rspec'
require 'question_parser'

describe QuestionParser do
	roman_inputs = [['glob', 'I'], ['prok', 'V'], ['pish', 'X'], ['tegj', 'L']]

	currency_inputs = [
		['glob glob Silver', '34 Credits'],
		['glob prok Gold', '57800 Credits'],
		['pish pish Iron', '3910 Credits']
	]

	question_inputs = [
		['how much', 'pish tegj glob glob'],
		['how many Credits', 'glob prok Silver'],
		['how many Credits', 'glob prok Gold'],
		['how many Credits', 'glob prok Iron'],
		['I have no idea what you are talking about']
	]

	subject(:question_parser) { QuestionParser.new(roman_inputs, currency_inputs, question_inputs) }

	describe '#return_answers' do
		it 'returns an answer without currency for questions not asking for currency' do
			expect(question_parser.return_answers).to include('pish tegj glob glob is 42')
		end

		it 'returns an answer with currency for questions asking for currency' do
			expect(question_parser.return_answers).to include('glob prok Silver is 68 Credits')
		end
	end
end

