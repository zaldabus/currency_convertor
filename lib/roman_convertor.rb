require 'pry'

class RomanConvertor
	attr_accessor :roman_inputs

	ROMAN_CONVERSION = {
		I: 1,
		V: 5,
		X: 10,
		L: 50,
		C: 100,
		D: 500,
		M: 1_000
	}

	def initialize(roman_inputs)
		@roman_inputs = roman_inputs
	end

	def value_map
		roman_inputs.to_h
	end

	def value_map_access(foreign_input)
		roman_inputs.to_h[foreign_input]
	end

	def invalid_foreign_combination?(foreign_input_array)
		return true unless foreign_input_array.all? { |word| value_map.keys.include? word }

		roman_combination = foreign_input_array.map do |foreign_word|
			value_map_access(foreign_word)
		end.join

		return true if four_or_more_repeating_values?(roman_combination)
		return true if repetition_of_dlv?(roman_combination)
		return true if invalid_order?(roman_combination)

		false
	end

	def convert_foreign_values_to_integer(foreign_input)
		value_to_determine = ''
		total = 0

		foreign_input.each_with_index do |foreign_value, i|
			value_to_determine << value_map_access(foreign_value)

			next if foreign_input.size > 1 && i == 0

			if i > 0 && i < (foreign_input.size - 1) && foreign_input[i - 1] == foreign_value
				next
			elsif i < (foreign_input.size - 1) && value_to_determine.size == 1
				next
			else
				total += roman_compound_value(value_to_determine)
				value_to_determine = ''
			end
		end

		total
	end

	private
	def create_mapping(roman_inputs)
		new_mapping = {}

		roman_inputs.each do |line|
			unknown, roman = line.split(INPUT_OUTPUT_SEPERATOR).map(&:strip)
			new_mapping[unknown] = ROMAN_CONVERSION[roman.to_sym]
		end

		new_mapping
	end

	def roman_simple_value(roman_input)
		ROMAN_CONVERSION[roman_input.to_sym]
	end

	def roman_compound_value(roman_input)
		individual_inputs = roman_input.split('')

		if individual_inputs.size == 1
			roman_simple_value(individual_inputs[-1])
		elsif roman_simple_value(individual_inputs[-2]) < roman_simple_value(individual_inputs[-1])
			roman_simple_value(individual_inputs[-1]) - roman_simple_value(individual_inputs[-2])
		else
			individual_inputs.inject(0) { |sum, roman| sum + roman_simple_value(roman) }
		end
	end

	def four_or_more_repeating_values?(roman_combination)
		roman_combination.scan(/(.)\1{3,}/).size > 0
	end

	def repetition_of_dlv?(roman_combination)
		roman_combination
			.gsub('I', '')
			.gsub('X', '')
			.gsub('C', '')
			.gsub('M', '')
			.scan(/(.)\1{1,}/).size > 0
	end

	def invalid_order?(roman_combination)
		allowable_successors = {
			'I' => { 'can_subtract_from' => ['V', 'X'], 'can_follow' => ['I'] },
			'V' => { 'can_subtract_from' => [], 'can_follow' => ['I'] },
			'X' => { 'can_subtract_from' => ['L', 'C'], 'can_follow' => ['V', 'I'] },
			'L' => { 'can_subtract_from' => [], 'can_follow' => ['X', 'V', 'I'] },
			'C' => { 'can_subtract_from' => ['D', 'M'], 'can_follow' => ['L', 'X', 'V', 'I'] },
			'D' => { 'can_subtract_from' => [], 'can_follow' => ['C', 'L', 'X', 'V', 'I'] },
			'M' => { 'can_subtract_from' => [], 'can_follow' => ['D', 'C', 'L', 'X', 'V', 'I'] }
		}

		i = 0
		while i < (roman_combination.length - 1)
			return false if i == (roman_combination.length - 1)

			current_roman = roman_combination[i]
			next_roman = roman_combination[i + 1]

			if allowable_successors[current_roman]['can_subtract_from'].include? next_roman
				return false if (i + 2) > (roman_combination.length - 1)
				next_next_roman = roman_combination[i + 2]

				if (next_next_roman == current_roman) || (next_next_roman == next_roman) ||
					 (!(allowable_successors[current_roman]['can_follow'] - [current_roman]).include? next_next_roman)
					return true
				end

				i += 2
			elsif allowable_successors[current_roman]['can_follow'].include? next_roman
				i += 1
			else
				return true
			end
		end
	end
end