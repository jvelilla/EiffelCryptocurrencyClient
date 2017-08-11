note
	description: "Summary description for {WALLET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WALLET
inherit

	WRAPPER_BASE
		rename
			make as make_base
		end

create
	make

feature -- Initialization

	make (a_word: WORD_LIST)
		local
			l_array: ARRAY [INTEGER_8]
		do
			create l_array.make_empty
		 	make_base( ({BITCOIN}.wallet_mnemonics_to_seed (a_word.item)))
		 	integer_8_array_from_external (l_array, item, 64)
		 	across l_array as ic  loop
		 		print (ic.item.to_hex_string)
		 	end
		end

	integer_8_array_from_external (a_array: ARRAY [INTEGER_8]; a_memory: POINTER; a_size: INTEGER)
			-- size given array to [1..a_size] and fills it with content from 'a_memory'
			-- NOTE: no way to detect if 'a_memory' really references a block of size 'a_size'
		require
			non_void_array: a_array /= Void
			non_null_memory: a_memory /= default_pointer
			positive_size: a_size > 0
		local
			arr: ANY
			ptr: POINTER
		do
			a_array.conservative_resize_with_default (create {INTEGER_8}, 1, a_size)
			arr := a_array.to_c
			ptr := $arr
			ptr.memory_copy (a_memory, a_size)
		end


feature -- Access

	seed: STRING_32
			--
		local
			l_str: STRING
			l_index: INTEGER
			l_memory: MANAGED_POINTER
			l_integer: INTEGER_8
			l_char: CHARACTER
			l_array, l_array2: ARRAY [NATURAL_8]
			l_conv: BYTE_ARRAY_CONVERTER
		do
				-- TODO check how to read the array of bytes.
			create l_memory.make_from_pointer (item, 64)
			l_array:=l_memory.read_array (0, 64)
			create l_array2.make_filled (0, 1, 64)
			l_index := 64
			across l_array as ic loop
				print (ic.item.to_character)
				l_array2.put (ic.item, l_index)
				l_index := l_index -1
			end
			create l_conv.make (64)
			l_conv.append_bytes (l_array2)
--			print (l_conv.to_hex_string)
			print ("%N")
			Result := l_conv.to_hex_string
		end

feature -- Disponse

	dispose
			-- <Precursor>
		do
			item := default_pointer
		end



end
