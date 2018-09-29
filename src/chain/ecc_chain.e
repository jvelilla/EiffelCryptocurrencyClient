note
	description: "Summary description for {ECC_CHAIN}."
	date: "$Date$"
	revision: "$Revision$"

class
	ECC_CHAIN

inherit

	WRAPPER_BASE
		rename
			make as make_base
		end
	REFACTORING_HELPER

	ECC_ERROR

create
	make

feature {ECC_BITCOIN} -- Creation

	make (a_pointer: POINTER)

		do
			make_base (a_pointer)
		end

feature -- Access

	get_history (a_address: ECC_PAYMENT_ADDRESS):detachable  ECC_HISTORY_COMPACT_LIST
		local
			l_pointer: POINTER
		do
			create l_pointer
				-- TODO check the value of the response of chain_get_history.
			error_code := {ECC_BITCOIN}.chain_get_history (item, a_address.item, 0, 0, $l_pointer)
			create Result.make(l_pointer)
		end

	heigth: NATURAL_64
		local
			l_res: INTEGER
			l_out: NATURAL_64
		do
			error_code := {ECC_BITCOIN}.chain_get_last_height (item, $l_out)
			Result := l_out
		ensure
			valid_height: Result >= 0
		end

	block_height (a_hash: READABLE_STRING_8): NATURAL_64
			-- Get the block height given the hash `a_hash'.
		require
			is_valid_hash: {ECC_VALIDATOR}.is_valid_hash (a_hash)
		local
			l_res: INTEGER
			l_out: NATURAL_64
			l_managed_pointer: MANAGED_POINTER
			l_byte_array: BYTE_ARRAY_CONVERTER
			l_array: ARRAY [NATURAL_8]
			l_cstring: C_STRING
			l_index: INTEGER
		do
			create l_byte_array.make_from_hex_string (a_hash)
			create l_managed_pointer.make_from_array (l_byte_array.to_natural_8_array)

			error_code := {ECC_BITCOIN}.chain_get_block_height (item, l_managed_pointer.item, $l_out)
			Result := l_out
		end

feature -- Access: Block Header

	block_header_by_hash (a_hash: READABLE_STRING_8): ECC_BLOCK_HEADER
		require
			is_valid_hash: {ECC_VALIDATOR}.is_valid_hash (a_hash)
		local
			l_out: NATURAL_64
			l_managed_pointer: MANAGED_POINTER
			l_byte_array: BYTE_ARRAY_CONVERTER
			l_ptr: POINTER
		do
			create l_byte_array.make_from_hex_string (a_hash)
			create l_managed_pointer.make_from_array (l_byte_array.to_natural_8_array)

			error_code := {ECC_BITCOIN}.chain_get_block_header_by_hash (item, l_managed_pointer.item, $l_ptr, $l_out)

			create Result.make (l_ptr)
		end

	block_header_by_height (a_height: NATURAL_64): ECC_BLOCK_HEADER
		local
			l_out: NATURAL_64
			l_ptr: POINTER
		do
			error_code := {ECC_BITCOIN}.chain_get_block_header_by_height (item, a_height, $l_ptr, $l_out)
			create Result.make (l_ptr)
		end

feature -- Access Block

	block_by_height (a_height: NATURAL_64): ECC_BLOCK
		local
			l_out: NATURAL_64
			l_ptr: POINTER
		do
			error_code := {ECC_BITCOIN}.chain_get_block_by_height (item, a_height, $l_ptr, $l_out)
			create Result.make (l_ptr)
			Result.set_height (l_out)
		ensure
			same_height: a_height = Result.height
		end

feature -- Disponse

	dispose
			-- <Precursor>
		do
			item := default_pointer
		end

end
