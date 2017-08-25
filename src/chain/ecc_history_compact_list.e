note
	description: "Summary description for {ECC_HISTORY_COMPACT_LIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECC_HISTORY_COMPACT_LIST

inherit

	WRAPPER_BASE
		rename
			make as make_base
		end

create
	make

feature {ECC_CHAIN}-- Initialization

	make (a_history: POINTER)
		do
		 	make_base(a_history)
		end

feature -- Access

	count: INTEGER_64
		do
			Result := {ECC_BITCOIN}.chain_history_compact_list_count (item)
		end

	history_compact (a_index: INTEGER_64): detachable ECC_HISTORY_COMPACT
		require
			valid_index: a_index >= 0 and then a_index < count
		do
			create Result.make ({ECC_BITCOIN}.chain_history_compact_list_nth (item, a_index))
		end


feature {NONE}-- Disponse

	dispose
			-- <Precursor>
		do
			{ECC_BITCOIN}.chain_history_compact_list_destruct (item)
			item := default_pointer
		end


end
