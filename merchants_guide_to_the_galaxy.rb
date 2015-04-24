require_relative 'lib/input_parser'
require_relative 'lib/roman_convertor'
require_relative 'lib/currency_map'
require_relative 'lib/question_parser'

if __FILE__ == $PROGRAM_NAME
	if ARGV.empty?
		puts 'Please select an input text file for conversion.'
	else
		input = InputParser.new(ARGV[0])
		qp = QuestionParser.new(input.romans, input.currencies, input.questions)
		qp.return_answers.each { |answer| puts answer }
	end
end