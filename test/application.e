class APPLICATION

create make

feature {NONE} --Initialization

	make
		local
			l_executor: BTC_EXECUTOR
			l_word_list: WORD_LIST
			l_wallet: WALLET
		do
			create l_word_list.make
			l_word_list.add_word ("demand")
			l_word_list.add_word ("survey")
			l_word_list.add_word ("loyal")
			l_word_list.add_word ("thing")
			l_word_list.add_word ("oven")
			l_word_list.add_word ("uniform")
			l_word_list.add_word ("milk")
			l_word_list.add_word ("ask")
			l_word_list.add_word ("agent")
			l_word_list.add_word ("insane")
			l_word_list.add_word ("together")
			l_word_list.add_word ("service")

			create l_wallet.make (l_word_list)
			print (l_wallet.seed)

--			create l_executor.make
--			l_executor.execute
			io.read_line
		end
end
