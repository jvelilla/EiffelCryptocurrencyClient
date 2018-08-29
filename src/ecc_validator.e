note
	description: "Summary description for {ECC_VALIDATOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	ECC_VALIDATOR

feature -- Hash Size Constants

		BITCOIN_SHORT_HASH_SIZE: INTEGER_8 = 20
		BITCOIN_HASH_SIZE: INTEGER_8 = 32
		BITCOIN_LONG_HASH_SIZE: INTEGER_8 = 64

feature -- Hash Validator

	is_valid_short_hash (a_value: STRING): BOOLEAN
			-- Is a valid Bitcoin short hash?
		require
			is_valid_size: a_value.count = BITCOIN_SHORT_HASH_SIZE
		do
			Result := across a_value as ic  all  {ECC_VALIDATOR}.hexa_map.has (ic.item)  end
		ensure
			class
		end

	is_valid_hash (a_value: STRING): BOOLEAN
			-- Is a valid Bitcoin hash?
		require
			is_valid_size: a_value.count = BITCOIN_HASH_SIZE
		do
			Result := across a_value as ic  all  {ECC_VALIDATOR}.hexa_map.has (ic.item)  end
		ensure
			class
		end

	is_valid_long_hash (a_value: STRING): BOOLEAN
			-- Is a valid Bitcoin long hash?
		require
			is_valid_size: a_value.count = BITCOIN_LONG_HASH_SIZE
		do
			Result := across a_value as ic  all  {ECC_VALIDATOR}.hexa_map.has (ic.item)  end
		ensure
			class
		end

feature -- Table for hexa

	hexa_map: ARRAY [CHARACTER_8]
			-- Table for Hexa encoding
		local
			l_result: SPECIAL [CHARACTER_8]
		once
			l_result := ("0123456789abcdefABCDEF").area
			Result := l_result.to_array
		ensure
			class
		end

end
