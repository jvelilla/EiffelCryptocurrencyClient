note
	description: "Object Representing an Error"
	date: "$Date$"
	revision: "$Revision$"

class
	ECC_ERROR


feature -- Status Report

	was_error: BOOLEAN
			-- Indicates that there was an error during the last operation.
		do
			Result := error_code /= 0
		end

	error_code: INTEGER
			-- Error code of the last operation.
end
