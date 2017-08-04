class APPLICATION

create make

feature {NONE} --Initialization

	make
		local
			l_executor: BTC_EXECUTOR
		do
			create l_executor.make
			l_executor.execute
			io.read_line
		end
end
