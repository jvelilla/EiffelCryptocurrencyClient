note
	description: "Summary description for {ECC_BLOCK_HEADER}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=block_header", "src=http://learnmeabitcoin.com/glossary/block-header", "protocol=uri"
class
	ECC_BLOCK_HEADER

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
			-- Is the Current Block header valid?
		do
			Result := {ECC_BITCOIN}.chain_header_is_valid (item)
		end

feature -- Access

	nonce: NATURAL_32
		do
			Result := {ECC_BITCOIN}.chain_header_nonce (item)
		end

	version: NATURAL_32
			-- The version of the block.
		do
			Result := {ECC_BITCOIN}.chain_header_version (item)
		end

	merkle: READABLE_STRING_8
		do
			Result := hash_implementation.to_hex_string
		end

	timestamp: DATE_TIME
		do
			create Result.make_from_epoch ({ECC_BITCOIN}.chain_header_timestamp (item).as_integer_32)
		end

	bits: READABLE_STRING_8
		local
			l_conv: BYTE_ARRAY_CONVERTER
		do
			create l_conv.make_from_natural_32 (32, {ECC_BITCOIN}.chain_header_bits (item))
			Result := l_conv.to_hex_string
		end

	previous_block_hash: READABLE_STRING_8
		do
			Result := previous_hash_implementation.to_hex_string
		end

	serialized_size: NATURAL_64
		do
			Result := {ECC_BITCOIN}.chain_header_serialized_size (item, version)
		end


	size: NATURAL_64
		do
			Result := {ECC_BITCOIN}.chain_header_satoshi_fixed_size (version)
		end

feature -- Disponse

	dispose
			-- <Precursor>
		do
			item := default_pointer
		end

feature -- Implementation

	hash_implementation: BYTE_ARRAY_CONVERTER
		local
			l_memory: MANAGED_POINTER
			l_array: ARRAY [NATURAL_8]
			l_temp: ARRAY [NATURAL_8]
		do
			create l_memory.make_from_pointer ({ECC_BITCOIN}.chain_header_merkle (item), 32)
			l_array := l_memory.read_array (0, 32)

			create l_temp.make_filled (0, 1, 32)
			across l_array.new_cursor.reversed as ic loop
				l_temp.force (ic.item, ic.cursor_index)
			end

			create Result.make (32)
			Result.append_bytes (l_temp)
		end

	previous_hash_implementation: BYTE_ARRAY_CONVERTER
		local
			l_memory: MANAGED_POINTER
			l_array: ARRAY [NATURAL_8]
			l_temp: ARRAY [NATURAL_8]
		do
			create l_memory.make_from_pointer ({ECC_BITCOIN}.chain_header_previous_block_hash (item), 32)
			l_array := l_memory.read_array (0, 32)

			create l_temp.make_filled (0, 1, 32)
			across l_array.new_cursor.reversed as ic loop
				l_temp.force (ic.item, ic.cursor_index)
			end

			create Result.make (32)
			Result.append_bytes (l_temp)
		end

end
