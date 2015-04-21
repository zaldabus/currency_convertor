class InputParser
	attr_reader :input

	ROMANS = ['I', 'V', 'X', 'L', 'C', 'D', 'M']

	def initialize(text_input)
		@input =	File.readlines(text_input).map(&:chomp)
	end

	# Will need to add error handling to check if there
	# are any additional lines remaining if not caught
	# by one of the following three methods

	def romans
		@input.select do |line|
			ROMANS.any? { |roman| line.include? roman }
		end.reject do |line|
			currencies.include? line
		end.reject do |line|
			questions.include? line
		end
	end

	def currencies
		@input.select do |line|
			line.match(/\d/)
		end
	end

	def questions
		@input.select do |line|
			line.include? '?'
		end
	end
end