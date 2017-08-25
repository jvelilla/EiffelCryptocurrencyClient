note
	description: "Summary description for {ECC_CHAIN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECC_CHAIN

inherit

	WRAPPER_BASE
		rename
			make as make_base
		end

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
		end


	heigth_2: INTEGER_64
		local
		do
--			Result := {ECC_BITCOIN}.chain_get_last_height (item)
		ensure
			valid_height: Result >= 0
		end


	heigth: NATURAL_64
		local
			l_res: INTEGER
			l_out: NATURAL_64
		do
			l_res := {ECC_BITCOIN}.chain_get_last_height (item, $l_out)
			Result := l_out
		ensure
			valid_height: Result >= 0
		end

feature -- Disponse

	dispose
			-- <Precursor>
		do
			item := default_pointer
		end

end
