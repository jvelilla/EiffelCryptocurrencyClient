note
	description: "Summary description for {ECC_PAYMENT_ADDRESS}."
	date: "$Date$"
	revision: "$Revision$"

class
	ECC_PAYMENT_ADDRESS

inherit

	WRAPPER_BASE
		rename
			make as make_base
		end

create
	make

feature {NONE} -- Creation

	make (a_address: READABLE_STRING_GENERAL)
		local
			c_string: C_STRING
		do
			create c_string.make (a_address)
			make_base ({ECC_BITCOIN}.wallet_payment_address_construct_from_string (c_string.item))
		end

feature -- Accesss

	encoded: detachable STRING_32
		local
			c_string: C_STRING
			l_ptr: POINTER
		do
			l_ptr := {ECC_BITCOIN}.wallet_payment_address_encoded (item)
			if l_ptr /= default_pointer then
				create c_string.make_by_pointer (l_ptr)
				Result := c_string.string
			end
		end

	version: INTEGER_8
		do
			Result := {ECC_BITCOIN}.wallet_payment_address_version (item)
		end


	is_valid: BOOLEAN
			-- Is the current payment address valid?
		do
			Result := {ECC_BITCOIN}.wallet_payment_address_is_valid (item)
		end

	hash: STRING_32
		do
			Result := hash_implementation.to_hex_string
			Result.to_lower
		end

	hash_as_natural_64: NATURAL_64
		do
			Result := hash_implementation.to_natural_64
		end

feature {NONE} -- Implementation

	hash_implementation: BYTE_ARRAY_CONVERTER
		local
			l_memory: MANAGED_POINTER
			l_array: ARRAY [NATURAL_8]
		do
			create l_memory.make_from_pointer ({ECC_BITCOIN}.wallet_payment_address_hash (item), 20)
			l_array:=l_memory.read_array (0, 20)
			create Result.make (20)
			Result.append_bytes (l_array)
		end

	dispose
			-- <Precursor>
		local
			l_done: BOOLEAN
		do
			from
				l_done := item = default_pointer
			until
				l_done
			loop
				{ECC_BITCOIN}.wallet_payment_address_destruct(item)
				l_done := True
			end
			item := default_pointer
		end

end

