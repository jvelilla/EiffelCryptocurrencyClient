class APPLICATION

create make

feature {NONE} --Initialization

	make
		local
		do
--			test_height
--			test_word_list
--			test_payment_address
--			test_bitcoin_hash
--			test_block_height
--			test_block_header_by_hash
--			test_block_header_by_height
			test_block_by_height
		end


	test_height
		local
			executor: ECC_BTC_EXECUTOR
			l_chain: ECC_CHAIN
		do
			create executor.make
			executor.init_and_run_wait
			executor.execute
			l_chain := executor.chain
			print ("%NHeight: " + l_chain.heigth.out)
			executor.stop
			io.read_line
		end


	test_word_list
		local
			l_executor: ECC_BTC_EXECUTOR
			l_word_list: ECC_WORD_LIST
			l_wallet: ECC_WALLET
		do
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
			print ("%N Wallter Seed:")
			print (l_wallet.seed)
			check
				expected_value: l_wallet.seed.same_string ("020b67fd929e0eb9f963443138057ceec0d62601d69b4b2327c00d74f0fd1862d164c53d49227d9dadedbbec305236bc2149d9a5267aa7c5aa004235c3c66c29")
			end
			io.read_line
 		end


 	test_payment_address
 		local
 			l_address: ECC_PAYMENT_ADDRESS
 		do
 			create l_address.make ("abcd")
 			check
 				is_false: not l_address.is_valid
 			end
 			create l_address.make ("my2dxGb5jz43ktwGxg2doUaEb9WhZ9PQ")
 			check
 				is_false: not l_address.is_valid
 			end
 			create l_address.make ("my2dxGb5jz43ktwGxg2doUaEb9WhZ9PQ7K")
 			check
 				is_true: l_address.is_valid
 			end

			create l_address.make ("bitcoincash:qz7cgzl5mavucstffsr8qf8mp2v60zncqv7tn3nler")
			check
 				is_true: l_address.is_valid
 			end

 			print ("%N" + l_address.hash)

 			io.read_line
 		end


 	test_bitcoin_hash
 		local
 			l_string:  STRING_32
 			l_nat : NATURAL_64
 		do
 				-- Short Hash
 			check
 				is_false: not {ECC_VALIDATOR}.is_valid_short_hash ("abcdefghijklmnopqrst")
 			end

 				-- Long Hash
 			check
 				is_true: {ECC_VALIDATOR}.is_valid_long_hash ("0000000014e6ae5aef5b7b660b160b7572fe14b95609fefb6f87c2d2e33a5fdd")
 			end
 		end

 	test_block_height
 		local
 			executor: ECC_BTC_EXECUTOR
			l_chain: ECC_CHAIN
			l_ret: NATURAL_64
		do
 			create executor.make
			executor.init_and_run_wait
			l_chain := executor.chain

			from until l_chain.heigth > 50 loop end


			-- Genesis Mainnet
			--l_ret := l_chain.block_height ("000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f")

			-- Genesis Testnet
			--l_ret := l_chain.block_height ("000000000933ea01ad0ee984209779baaec3ced90fa3f408719526f8d77f4943")



			print ("%N Heigth:" + l_chain.heigth.out + "%N" )

			-- Block #7 Mainnet
			-- l_ret := l_chain.block_height ("0000000071966c2b1d065fd446b1e485b2c9d9594acd2007ccbd5441cfc89444")

			-- Block #7 Testnet
			l_ret := l_chain.block_height ("00000000e29e3aa65f3d12440eac9081844c464aeba7c6e6121dfc8ac0c02ba6")



			executor.stop
			io.read_line
		end

	test_block_header_by_hash
		local
			executor: ECC_BTC_EXECUTOR
			l_chain: ECC_CHAIN
			l_ret: NATURAL_64
			l_block_header: ECC_BLOCK_HEADER
		do
 			create executor.make
			executor.init_and_run_wait
			l_chain := executor.chain

			from until l_chain.heigth > 50 loop end

			print ("%N Heigth:" + l_chain.heigth.out + "%N" )

				-- Block #7 Testnet
			l_ret := l_chain.block_height ("000000000933ea01ad0ee984209779baaec3ced90fa3f408719526f8d77f4943")

			l_block_header := l_chain.block_header_by_hash ("000000000933ea01ad0ee984209779baaec3ced90fa3f408719526f8d77f4943")
			print ("%NIs Valid Block Header:" + l_block_header.is_valid.out)
			print ("%NHeader Nonce:" + l_block_header.nonce.out)
			print ("%NVersion:" + l_block_header.version.out)
			print ("%NTimeStamp:" + l_block_header.timestamp.out)
			print ("%NBits:" + l_block_header.bits)
			print ("%NMerkle:" + l_block_header.merkle)
			print ("%NPREV block hash:" + l_block_header.previous_block_hash)

			executor.stop
			io.read_line
		end

	test_block_header_by_height
		local
			executor: ECC_BTC_EXECUTOR
			l_chain: ECC_CHAIN
			l_ret: NATURAL_64
			l_block_header: ECC_BLOCK_HEADER
		do
 			create executor.make
			executor.init_and_run_wait
			l_chain := executor.chain

			from until l_chain.heigth > 50 loop end

			print ("%N Heigth:" + l_chain.heigth.out + "%N" )

			l_block_header := l_chain.block_header_by_height (7)
			print ("%NIs Valid Block Header:" + l_block_header.is_valid.out)
			print ("%NHeader Nonce:" + l_block_header.nonce.out)
			print ("%NVersion:" + l_block_header.version.out)
			print ("%NTimeStamp:" + l_block_header.timestamp.out)
			print ("%NBits:" + l_block_header.bits)
			print ("%NMerkle:" + l_block_header.merkle)
			print ("%NPREV block hash:" + l_block_header.previous_block_hash)

			executor.stop
			io.read_line
		end

	test_block_by_height
		local
			executor: ECC_BTC_EXECUTOR
			l_chain: ECC_CHAIN
			l_ret: NATURAL_64
			l_block_header: ECC_BLOCK_HEADER
			l_block: ECC_BLOCK
			l_transaction: ECC_TRANSACTION
		do
 			create executor.make
			executor.init_and_run_wait
			l_chain := executor.chain

			from until l_chain.heigth > 50 loop end

			print ("%N Heigth:" + l_chain.heigth.out + "%N" )

			l_block := l_chain.block_by_height (7)
			l_block.set_height (7)

			print ("%NBlock_Hash:" + l_block.hash)
			print ("%NBlock_is_valid:" + l_block.is_valid.out)
			print ("%NBlock_transaction_count:" + l_block.transaction_count.out)
			print ("%NBlock_reward:" + l_block.reward.out)
			print ("%NBlock_size:" + l_block.size.out)
			print ("%NBlock_proof_string:" + l_block.proof_string)
			print ("%NBlock_fees:" + l_block.fees.out)
			print ("%NBlock_claim:" + l_block.claim.out)
			print ("%NBlock_subsidy:" + l_block.subsidy.out)
			print ("%NBlock_generate_merkle_root:" + l_block.generate_merkle_root)

			l_block_header := l_block.header
			print ("%NHeader_is_valid:" + l_block_header.is_valid.out)
			print ("%NHeader_Nonce:" + l_block_header.nonce.out)
			print ("%NHeader_Version:" + l_block_header.version.out)
			print ("%NHeader_TimeStamp:" + l_block_header.timestamp.out)
			print ("%NHeader_Bits:" + l_block_header.bits)
			print ("%NHeader_Merkle:" + l_block_header.merkle)
			print ("%NHeader_prev_block hash:" + l_block_header.previous_block_hash)
			print ("%NHeader_Serialized_Size:" + l_block_header.serialized_size.out)
			print ("%NHeader_Size:" + l_block_header.size.out)


			l_transaction := l_block.transaction_nth (0)
			print ("%NBlock_transaction_is_valid:" + l_transaction.is_valid.out)
			print ("%NBlock_transaction_version:" + l_transaction.version.out)
			print ("%NBlock_transaction_hash:" + l_transaction.hash)
			print ("%NBlock_transaction_is_coin_base:" + l_transaction.is_coin_base.out)



			executor.stop
			io.read_line
		end

end
