class RomanMap
	attr_accessor :roman_converter

	SEPERATOR = 'is'

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
		@roman_converter = create_mapping(roman_inputs)
	end

	def [](key)
		roman_converter[key]
	end

	def []=(key, value)
		roman_converter[key] = value
	end

	def size
		roman_converter.size
	end

	private
	def create_mapping(roman_inputs)
		new_mapping = {}

		roman_inputs.each do |line|
			unkown, roman = line.split(SEPERATOR)
			new_mapping[unkown.strip] = ROMAN_CONVERSION[roman.strip.to_sym]
		end

		new_mapping
	end
end