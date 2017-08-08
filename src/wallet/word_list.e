note
	description: "Summary description for {WORD_LIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WORD_LIST

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
			make_base ({BITCOIN}.word_list_constructor)
		end


feature -- Change Element

	add_word (a_word: STRING_32)
			-- Add 'a_word' to the word_list.
		local
			c_string: C_STRING
		do
			create c_string.make (a_word)
			{BITCOIN}.work_list_add_word (item, c_string.item)
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
				{BITCOIN}.word_list_destuctor(item)
				l_done := True
			end
			item := default_pointer
		end

end
