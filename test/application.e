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

-- previo humilde actuar jarabe tabique ahorro tope pulpo anís señal lavar bahía
-- 9cc236d5fa28c39e835bd6f7d66b51056c3a2f56208da1c1c2997a3741fe60bb0645d849ecacff0a29f2e26977ae42b12b97a5a3a8cc78d7113b536ff069352e
-- 2E40EBB6768881FD85EDE7A597944FE4CCB9AA13454DFF4073EDF5F991A3D51DE29711B6F17602BD41D386CA25F772D4B5872F159F55F1A1EADD9876B1D4D84E

-- rival hurdle address inspire tenant almost turkey safe asset step lab boy
-- 020b67fd929e0eb9f963443138057ceec0d62601d69b4b2327c00d74f0fd1862d164c53d49227d9dadedbbec305236bc2149d9a5267aa7c5aa004235c3c66c29
-- 020b67fd929e0eb9f963443138057ceec0d62601d69b4b2327c00d74f0fd1862d164c53d49227d9dadedbbec305236bc2149d9a5267aa7c5aa004235c3c66c29

			create l_word_list.make
			l_word_list.add_word ("rival")
			l_word_list.add_word ("hurdle")
			l_word_list.add_word ("address")
			l_word_list.add_word ("inspire")
			l_word_list.add_word ("tenant")
			l_word_list.add_word ("almost")
			l_word_list.add_word ("turkey")
			l_word_list.add_word ("safe")
			l_word_list.add_word ("asset")
			l_word_list.add_word ("step")
			l_word_list.add_word ("lab")
			l_word_list.add_word ("boy")

			create l_wallet.make (l_word_list)
			print ("%N")
			print (l_wallet.seed)

--			create l_executor.make
--			l_executor.execute
			io.read_line
		end
end
