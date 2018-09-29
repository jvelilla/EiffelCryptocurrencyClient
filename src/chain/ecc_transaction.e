note
	description: "Summary description for {ECC_TRANSACTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECC_TRANSACTION

inherit

	WRAPPER_BASE
		rename
			make as make_base
		end
	REFACTORING_HELPER

create
	make

feature {ECC_BITCOIN} -- Creation

	make (a_pointer: POINTER)

		do
			make_base (a_pointer)
		end

feature -- Status Report

	is_valid: BOOLEAN
		do
			Result := {ECC_BITCOIN}.chain_transaction_is_valid (item)
		end

	version: NATURAL_32
		do
			Result := {ECC_BITCOIN}.chain_transaction_version (item)
		end

	is_coin_base: BOOLEAN
		do
			Result := {ECC_BITCOIN}.chain_transaction_is_coinbase (item)
		end

feature -- Access

	hash: READABLE_STRING_8
		local
			l_response: STRING_8
		do
			l_response := hash_implementation.to_hex_string
			l_response.to_lower
			Result := l_response
		end

feature -- Disponse

	dispose
			-- <Precursor>
		do
				-- here we should call to C destructor.
			item := default_pointer
		end


feature {NONE} -- Implementation

	hash_implementation: BYTE_ARRAY_CONVERTER
		local
			l_memory: MANAGED_POINTER
			l_array: ARRAY [NATURAL_8]
			l_temp: ARRAY [NATURAL_8]
		do
			create l_memory.make_from_pointer ({ECC_BITCOIN}.chain_transaction_hash (item), 32)
			l_array := l_memory.read_array (0, 32)

			create l_temp.make_filled (0, 1, 32)
			across l_array.new_cursor.reversed as ic loop
				l_temp.force (ic.item, ic.cursor_index)
			end

			create Result.make (32)
			Result.append_bytes (l_temp)
		end
end
