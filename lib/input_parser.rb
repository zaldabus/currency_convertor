class InputParser
	attr_reader :input

	SEPERATOR = ' is '

	ROMANS = ['I', 'V', 'X', 'L', 'C', 'D', 'M']

	def initialize(text_input)
		@input =	File.readlines(text_input).map(&:chomp)
	end

	def romans
		lines = input.select do |line|
			ROMANS.any? { |roman| line.include? roman }
		end.reject do |line|
			currencies.include? line.split(SEPERATOR)
		end.reject do |line|
			questions.include? line.split(SEPERATOR)
		end

		seperate(lines)
	end

	def currencies
		lines = input.select do |line|
			line.match(/\d/)
		end

		seperate(lines)
	end

	def questions
		lines = input.select do |line|
			line.include? '?'
		end.map { |line| line.gsub(' ?', '')}

		seperate(lines)
	end

	private
	def seperate(lines)
		lines.map do |line|
			seperated_line = line.split(SEPERATOR)
		end
	end
end