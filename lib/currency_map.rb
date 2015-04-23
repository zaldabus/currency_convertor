class CurrencyMap
	attr_reader :roman_convertor
	attr_reader :currency_convertor

	def initialize(roman_convertor, currency_inputs)
		@roman_convertor = roman_convertor
		@currency_convertor = create_mapping(currency_inputs)
	end

	def [](key)
		currency_convertor[key]
	end

	def []=(key, value)
		currency_convertor[key] = value
	end

	def keys
		currency_convertor.keys
	end

	def currency_key(input)
		currency = currency(input)
		simple_singularize(currency).downcase.to_sym
	end

	private
	def create_mapping(currency_inputs)
		new_currencies = {}

		currency_inputs.each do |line|
			input, output = line[0], line[1]

			input_value = calculate_input_value(input)
			output_value = calculate_output_value(output)
			new_currencies = add_to_map(new_currencies, input, input_value, output_value)
		end

		new_currencies
	end

	def calculate_input_value(input)
		# Need to put in error handling here to make sure
		# value_to_determine never gets bigger than 4
		# (3 of the same type and 1 different)
		convert_to_romans = input.split(' ')[0...-1]
		roman_convertor.convert_foreign_values_to_integer(convert_to_romans)
	end

	def calculate_output_value(output)
		output.scan(/\d+/)[0].to_i
	end

	def add_to_map(currency_map, key_ref, key_value, credit_value)
		exchange_rate = (credit_value / key_value)
		currency_map[currency_key(key_ref)] = exchange_rate
		currency_map
	end

	def currency(input)
		input.split(' ').last
	end

	def simple_singularize(currency)
		currency[-1] == 's' ? currency[0...-1] : currency
	end
end