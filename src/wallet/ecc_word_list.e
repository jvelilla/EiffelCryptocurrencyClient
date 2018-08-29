note
	description: "Summary description for {ECC_WORD_LIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECC_WORD_LIST

inherit

	WRAPPER_BASE
		rename
			make as make_base
		end

create
	make

feature {NONE} -- Creation

	make
		do
			make_base ({ECC_BITCOIN}.wallet_word_list_constructor)
		end

feature -- Change Element

	add_word_list (a_string: STRING_32)
			-- A string representing a list of word separated by an space.
		do
			across a_string.split (' ') as ic loop
				add_word (ic.item)
			end
		end

	add_word (a_word: STRING_32)
			-- Add 'a_word' to the word_list.
		local
			c_string: C_STRING
		do
			create c_string.make (a_word)
			{ECC_BITCOIN}.work_list_add_word (item, c_string.item)
		end

feature {NONE} -- Implementation

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
				{ECC_BITCOIN}.wallet_word_list_destuctor(item)
				l_done := True
			end
			item := default_pointer
		end

end
