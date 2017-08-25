note
	description: "Summary description for {ECC_HISTORY_COMPACT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECC_HISTORY_COMPACT

inherit

	WRAPPER_BASE
		rename
			make as make_base
		end

create
	make

feature {ECC_HISTORY_COMPACT_LIST}-- Initialization

	make (a_item: POINTER)
		do
		 	make_base(a_item)
		end

feature -- Access

	point_kind: INTEGER
		do
			Result := {ECC_BITCOIN}.chain_history_compact_get_point_kind (item)
		end

	get_height: INTEGER_32
		do
			Result := {ECC_BITCOIN}.chain_history_compact_get_height (item)
		end

	value_or_previous_checksum: INTEGER_64
		do
			Result := {ECC_BITCOIN}.chain_history_compact_get_value_or_previous_checksum (item)
		end

feature {NONE}-- Disponse

	dispose
			-- <Precursor>
		do
			item := default_pointer
		end



end
