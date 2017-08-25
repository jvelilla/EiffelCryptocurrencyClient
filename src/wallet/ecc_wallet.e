note
	description: "Summary description for {ECC_WALLET}."
	date: "$Date$"
	revision: "$Revision$"

class
	ECC_WALLET

inherit

	WRAPPER_BASE
		rename
			make as make_base
		end

create
	make

feature -- Initialization

	make (a_word: ECC_WORD_LIST)
		do
		 	make_base( ({ECC_BITCOIN}.wallet_mnemonics_to_seed (a_word.item)))
		end

feature -- Access

	seed: STRING_32
			-- BIP 39. (Bitcoin improvement proposal).
		local
			l_memory: MANAGED_POINTER
			l_array: ARRAY [NATURAL_8]
			l_conv: BYTE_ARRAY_CONVERTER
		do
			create l_memory.make_from_pointer (item, 64)
			l_array:=l_memory.read_array (0, 64)
			create l_conv.make (64)
			l_conv.append_bytes (l_array)
			Result := l_conv.to_hex_string
			Result.to_lower
		end

feature -- Disponse

	dispose
			-- <Precursor>
		do
			{ECC_BITCOIN}.wallet_free (item)
			item := default_pointer
		end

end
