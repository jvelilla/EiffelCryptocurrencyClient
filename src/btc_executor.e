note
	description: "[Create an executor]"
	date: "$Date$"
	revision: "$Revision$"

class
	BTC_EXECUTOR

inherit

	WRAPPER_BASE
		rename
			make as make_base
		end
create
	make

feature {NONE} -- Creation

	make
			-- Context creation for non in-process communication.
		local
			l_string: C_STRING
			l_result: INTEGER
		do
			create l_string.make ("c:/home/poc/file.cfg") -- todo enable to set a cfg file.
			make_base ({BITCOIN}.new_executor (l_string.item, io.output.file_pointer, io.error.file_pointer))
			l_result := {BITCOIN}.executor_initchain (item)
		end


feature -- Execute

	execute
		local
			l_return: INTEGER
		do
			l_return := {BITCOIN}.executor_run_wait (item)
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
				{BITCOIN}.executor_destruct(item)
				l_done := True
			end
			item := default_pointer
		end

end
