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
			l_res: INTEGER
		do
			create l_pointer
				-- TODO check the value of the response of chain_get_history.
			l_res := {ECC_BITCOIN}.chain_get_history (item, a_address.item, 0, 0, $l_pointer)
			create Result.make(l_pointer)
			to_implement ("Error Handling")
		end

	heigth: NATURAL_64
		local
			l_res: INTEGER
			l_out: NATURAL_64
		do
			l_res := {ECC_BITCOIN}.chain_get_last_height (item, $l_out)
			Result := l_out
			to_implement ("Error Handling")
		ensure
			valid_height: Result >= 0
		end

	block_height (a_hash: READABLE_STRING_8): NATURAL_64
			-- Get the block heigh given the hash `a_hash'.
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

			l_res := {ECC_BITCOIN}.chain_get_block_height (item, l_managed_pointer.item, $l_out)

			print ("%N l_res:" + l_res.out + "%N" )
			print ("%N l_out:" + l_out.out + "%N" )

			Result := l_out
			to_implement ("Error Handling")
		end

--	BITPRIM_EXPORT
--error_code_t chain_get_block_height(chain_t chain, hash_t hash, uint64_t* /*size_t*/ out_height);


feature -- Disponse

	dispose
			-- <Precursor>
		do
			item := default_pointer
		end

end
