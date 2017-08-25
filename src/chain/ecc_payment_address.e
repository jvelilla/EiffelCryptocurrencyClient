note
	description: "Summary description for {ECC_PAYMENT_ADDRESS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECC_PAYMENT_ADDRESS

inherit

	WRAPPER_BASE
		rename
			make as make_base
		end

create
	make

feature {NONE} -- Creation

	make (a_address: READABLE_STRING_GENERAL)
		local
			c_string: C_STRING
		do
			create c_string.make (a_address)
			make_base ({ECC_BITCOIN}.chain_payment_address_construct_from_string (c_string.item))
		end

feature -- Accesss

	encoded: detachable STRING_32
		local
			c_string: C_STRING
			l_ptr: POINTER
		do
			l_ptr := {ECC_BITCOIN}.chain_payment_address_encoded (item)
			if l_ptr /= default_pointer then
				create c_string.make_by_pointer (l_ptr)
				Result := c_string.string
			end
		end

	version: INTEGER_8
		do
			Result := {ECC_BITCOIN}.chain_payment_address_version (item)
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
				{ECC_BITCOIN}.chain_payment_address_destruct(item)
				l_done := True
			end
			item := default_pointer
		end

end

