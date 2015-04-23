require 'pry'

class QuestionParser
	attr_reader :roman_convertor
	attr_reader :currency_map
	attr_reader :question_inputs

	INVALID_QUESTION_RETURN = 'I have no idea what you are talking about'

	def initialize(roman_convertor, currency_map, question_inputs)
		@roman_convertor, @currency_map, @question_inputs = roman_convertor, currency_map, question_inputs
	end

	def return_answers
		answers = []

		question_inputs.each do |question_input|
			return answers << question_input if question_input.size == 1

			question_from, question_to = question_input[0], question_input[1]

			if invalid_question_from?(question_from) || invalid_question_to?(question_to)
				answers << INVALID_QUESTION_RETURN
			else
				integer_for_foreign_value = find_integer(question_to)

				if currency_question?(question_to)
					credit_value = integer_for_foreign_value * currency_map[currency_map.currency_key(question_to)]
					answers << "#{question_to} is #{credit_value} Credits"
				else
					answers << "#{question_to} is #{integer_for_foreign_value}"
				end
			end
		end

		answers
	end

	private
	def invalid_question_from?(question_from)
		if !question_from.include?('how much') && !question_from.include?('how many')
			return true
		end

		false
	end

	def invalid_question_to?(question_to)
		question_to_ary = question_to.split

		if !currency_map.keys.include?(currency_map.currency_key(question_to)) &&
			 !question_to_ary[0..-1].all? { |word| roman_convertor.value_map.keys.include? word }
			return true
		end

		if currency_map.keys.include?(currency_map.currency_key(question_to)) &&
			 !question_to_ary[0...-1].all? { |word| roman_convertor.value_map.keys.include? word }
			return true
		end

		false
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
		question_to_ary = question_to.split

		if currency_map.keys.include?(currency_map.currency_key(question_to))
			return true
		end

		false
	end
end