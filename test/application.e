class APPLICATION

create make

feature {NONE} --Initialization

	make
		local
			l_executor: BTC_EXECUTOR
			l_word_list: WORD_LIST
			l_wallet: WALLET
		do
-- shine valley unhappy
-- fce0ec51610c81feed7a4cba250d8fbead1c5e959b38f5e368d7569e5af3a26c9a2804126dccc265eb886060cfd00f36824ee12b2e1a7871e9fba15d07969406
-- 8000382041DEE6D5006F0073006F0072006300000024004E0049004E004F00438000372041D8E6D700000146A904E6C000000146A904E6C000000146A904E660

--wild net kiwi
--787cc4e28cd3f48474cd862fa8d0795d9d5f79b561f2b9a6992ce17a50cc24985a363f7ab5d95b2305da053408c90289f44ebbe1d0f7c56e0133ba2481489055
--80000873FE3EEF360053002000740066006F0073006F007200630069004D005C80000736FE38EF340000020CF1AC06500000020CF1AC06500000020CF1AC05F0
			create l_word_list.make
--			l_word_list.add_word ("shine")
--			l_word_list.add_word ("valley")
--			l_word_list.add_word ("unhappy")
			l_word_list.add_word ("wild")
			l_word_list.add_word ("net")
			l_word_list.add_word ("kiwi")

			create l_wallet.make (l_word_list)
			print ("%N")
			print (l_wallet.seed)

--			create l_executor.make
--			l_executor.execute
			io.read_line
		end
end
