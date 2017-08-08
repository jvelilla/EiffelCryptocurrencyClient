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
			l_val: INTEGER_64
		do
		 	make_base( ({BITCOIN}.wallet_mnemonics_to_seed (a_word.item)))
		end

feature -- Access

	seed: STRING_32
			--
		local
			l_str: STRING
			l_index: INTEGER
			l_memory: MANAGED_POINTER
		do
				-- TODO check how to read the array of bytes.
			create l_memory.make_from_pointer (item, 64)
			from
				create l_str.make_empty
				l_index := 1
			until
				l_index > l_memory.count
			loop
				l_str.append_character (l_memory.read_character (l_index - 1))
				l_index := l_index + 1
			end
			Result := l_str
		end

feature -- Disponse

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
				{BITCOIN}.wallet_long_hash_destroy(item)
				l_done := True
			end
			item := default_pointer
		end



end
