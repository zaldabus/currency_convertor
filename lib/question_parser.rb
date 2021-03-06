require_relative 'roman_convertor'
require_relative 'currency_map'

class QuestionParser
	attr_reader :roman_convertor
	attr_reader :currency_map
	attr_reader :question_inputs

	INVALID_QUESTION_RETURN = 'I have no idea what you are talking about'

	def initialize(roman_input, currency_input, question_input)
		@roman_convertor = RomanConvertor.new(roman_input)
		@currency_map = CurrencyMap.new(roman_input, currency_input)
		@question_inputs = question_input
	end

	def return_answers
		answers = []

		question_inputs.each do |question_input|
			if question_input.size == 1
				answers << INVALID_QUESTION_RETURN
				next
			end

			question_from, question_to = question_input[0], question_input[1]

			if invalid_question_from?(question_from) || invalid_question_to?(question_to)
				answers << INVALID_QUESTION_RETURN
			else
				integer_for_comparison_value = find_reference_integer(question_from)
				integer_for_foreign_value = find_integer(question_to)

				if currency_question?(question_to)
					currency_value = (integer_for_foreign_value * currency_map[currency_map.currency_key(question_to)] / integer_for_comparison_value).round
					currency = question_from.split[-1]
					answers << "#{question_to} is #{currency_value} #{currency}"
				else
					answers << "#{question_to} is #{integer_for_foreign_value}"
				end
			end
		end

		answers
	end

	private
	def invalid_question_from?(question_from)
		unless question_from.include?('how much') || question_from.include?('how many')
			return true
		end

		false
	end

	def invalid_question_to?(question_to)
		question_to_ary = question_to.split

		if currency_question?(question_to)
			return true if roman_convertor.invalid_foreign_combination?(question_to_ary[0...-1])
		else
			return true if roman_convertor.invalid_foreign_combination?(question_to_ary)
		end

		false
	end

	def find_reference_integer(question_from)
		question_from_ary = question_from.split

		if currency_map.keys.include?(currency_map.currency_key(question_from))
			currency_map[question_from_ary[-1].downcase.to_sym]
		else
			1
		end
	end

	def find_integer(question_to)
		question_to_ary = question_to.split

		if currency_map.keys.include?(currency_map.currency_key(question_to))
			roman_convertor.convert_foreign_values_to_integer(question_to_ary[0...-1])
		else
			roman_convertor.convert_foreign_values_to_integer(question_to_ary)
		end
	end

	def currency_question?(question_to)
		if currency_map.keys.include?(currency_map.currency_key(question_to))
			return true
		end

		false
	end
end