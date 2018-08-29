note
	description: "[Create an executor]"
	date: "$Date$"
	revision: "$Revision$"

class
	ECC_BTC_EXECUTOR

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
			create l_string.make ("C:/home/poc/EiffelCryptocurrencyClient/btc-mainnet.cfg") -- todo enable to set a cfg file.
--			make_base ({ECC_BITCOIN}.new_executor (l_string.item, io.output.file_pointer, io.error.file_pointer))

			make_base ({ECC_BITCOIN}.new_executor (l_string.item, default_pointer, default_pointer))
				-- TODO
				-- Refactor: call executor_initchain on deman, since no all the time
				-- is needed.
--			l_result := {ECC_BITCOIN}.executor_initchain (item)
		end


feature -- Execute

	execute
		local
			l_return: INTEGER
		do
			l_return := {ECC_BITCOIN}.executor_run_wait (item)
		end

feature -- Initialize

	initialize
		local
			l_result: INTEGER
		do
			l_result := {ECC_BITCOIN}.executor_initchain (item)
			-- TODO
		end

	init_and_run_wait
			-- Similar use case as
			-- call `initialize' and then `execute'
			-- but in this case we call only `initialize'
			-- iff necessary.
		local
			l_result: INTEGER
		do
			l_result := {ECC_BITCOIN}.executor_init_and_run_wait (item)
		end

feature -- Stop

	stop
		do
			{ECC_BITCOIN}.executor_stop (item)
		end

feature -- Access Chain

	chain: ECC_CHAIN
		do
			create Result.make ({ECC_BITCOIN}.executor_get_chain (item));
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
				{ECC_BITCOIN}.executor_destruct(item)
				l_done := True
			end
			item := default_pointer
		end

end
