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

	def value_map_access(unkown_input)
		roman_inputs.to_h[unkown_input]
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
end