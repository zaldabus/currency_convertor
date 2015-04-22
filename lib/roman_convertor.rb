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

	def value_map(unkown_input)
		roman_inputs.to_h[unkown_input]
	end

	def roman_simple_value(roman_input)
		ROMAN_CONVERSION[roman_input.to_sym]
	end

	def roman_compound_value(roman_input)
		individual_inputs = roman_input.split('')

		if roman_simple_value(individual_inputs[-2]) < roman_simple_value(individual_inputs[-1])
			roman_simple_value(individual_inputs[-1]) - roman_simple_value(individual_inputs[-2])
		else
			individual_inputs.inject(0) { |sum, roman| sum + roman_simple_value(roman) }
		end
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
end