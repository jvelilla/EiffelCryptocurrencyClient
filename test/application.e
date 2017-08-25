class APPLICATION

create make

feature {NONE} --Initialization

	make
		local
		do
			test_height
		end


	test_height
		local
			executor: ECC_BTC_EXECUTOR
			l_chain: ECC_CHAIN
		do
			create executor.make
			executor.execute
			l_chain := executor.chain
			print ("%NHeight: " + l_chain.heigth.out)
			executor.stop
			io.read_line
		end
end
