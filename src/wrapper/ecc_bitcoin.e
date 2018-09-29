note
	description: "Summary description for {ECC_BITCOIN}."
	date: "$Date$"
	revision: "$Revision$"

class
	ECC_BITCOIN

feature -- Executor

	executor_run_wait (a_executor: POINTER): INTEGER_32
			--	BITPRIM_EXPORT int executor_run_wait(executor_t exec);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"return executor_run_wait ((executor_t)$a_executor);"
		end

	new_executor (a_path: POINTER; a_file: POINTER; a_error: POINTER): POINTER
			--BITPRIM_EXPORT executor_t executor_construct(char const*, FILE* sout, FILE* serr);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"return executor_construct((char const*) $a_path, (FILE*) $a_file, (FILE*) $a_error);"
		end

	executor_destruct (a_executor: POINTER)
			--	BITPRIM_EXPORT void executor_destruct(executor_t exec);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"executor_destruct((executor_t) $a_executor )"
		end

	executor_initchain (a_executor: POINTER): INTEGER_32
			--  BITPRIM_EXPORT int executor_initchain(executor_t exec);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"return executor_initchain((executor_t) $a_executor);"
		end

	executor_stop (a_pointer: POINTER)
			-- BITPRIM_EXPORT void executor_stop(executor_t exec);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"executor_stop((executor_t)$a_pointer)"
		end

	executor_get_chain (a_pointer: POINTER): POINTER
			--BITPRIM_EXPORT chain_t executor_get_chain(executor_t exec);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"return (chain_t) executor_get_chain((executor_t)$a_pointer)"
		end

	executor_init_and_run_wait (a_executor: POINTER): INTEGER_32
			--	BITPRIM_EXPORT int executor_init_and_run_wait(executor_t exec);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"return executor_init_and_run_wait((executor_t)$a_executor);"
		end

feature -- Wallet

	wallet_mnemonics_to_seed (a_mnemonics: POINTER): POINTER
            --BITPRIM_EXPORT
            --long_hash_t wallet_mnemonics_to_seed(word_list_t mnemonics);
        external
            "C inline use <bitprim/nodecint.h>"
        alias
            "[
             long_hash_t ret = wallet_mnemonics_to_seed((word_list_t) $a_mnemonics);
             
             for (size_t i = 0; i < 64; ++i) {
             	printf("%d\n", (int)ret.hash[i]);
             }
             
             // uint8_t 64
             uint8_t* arr = (uint8_t*)malloc(sizeof(uint8_t) * 64);
             memcpy(arr, ret.hash, 64);
             return arr;
            ]"
	    end

	wallet_free (a_pointer: POINTER)
		external
		 	"C inline use <stdlib.h>"
		alias
			"free ($a_pointer)"
		end

feature -- Word List

	wallet_word_list_constructor: POINTER
			-- BITPRIM_EXPORT word_list_t wallet_word_list_construct;
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"return wallet_word_list_construct();"
		end

	work_list_add_word (a_word_list: POINTER; a_word: POINTER)
			--BITPRIM_EXPORT
			--void wallet_word_list_add_word(word_list_t word_list, const char* word);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"wallet_word_list_add_word((word_list_t) $a_word_list, (const char*) $a_word)"
		end

	wallet_word_list_destuctor (a_word_list: POINTER)
			--BITPRIM_EXPORT void wallet_word_list_destruct(word_list_t word_list);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"wallet_word_list_destruct((word_list_t) $a_word_list)"
		end


feature -- Payment Address

	wallet_payment_address_construct_from_string (a_pointer: POINTER): POINTER
			--BITPRIM_EXPORT payment_address_t wallet_payment_address_construct_from_string(char const* address);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"[
				printf("wallet_payment_address_construct_from_string - a_pointer: %s\n", (char const*) $a_pointer);
				return wallet_payment_address_construct_from_string((char const*) $a_pointer);
			]"
		end

	wallet_payment_address_encoded (a_pointer: POINTER): POINTER
			--BITPRIM_EXPORT
			--char const* wallet_payment_address_encoded(payment_address_t payment_address);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"return (char const*) wallet_payment_address_encoded((payment_address_t) $a_pointer);"
		end

	wallet_payment_address_version (a_pointer: POINTER): INTEGER_8
			--BITPRIM_EXPORT
			--uint8_t wallet_payment_address_version(payment_address_t payment_address);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"return (uint8_t) wallet_payment_address_version((payment_address_t)$a_pointer);"
		end

	wallet_payment_address_destruct(a_pointer: POINTER)
			--BITPRIM_EXPORT void wallet_payment_address_destruct(payment_address_t payment_address);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"wallet_payment_address_destruct((payment_address_t)$a_pointer);"
		end

	wallet_payment_address_is_valid (a_pointer: POINTER): BOOLEAN
			--	BITPRIM_EXPORT
			--int /*bool*/ wallet_payment_address_is_valid(payment_address_t payment_address);	
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"return (EIF_BOOLEAN) wallet_payment_address_is_valid((payment_address_t)$a_pointer);"
		end

	wallet_payment_address_hash (a_pointer: POINTER): POINTER
			--	BITPRIM_EXPORT
			--short_hash_t wallet_payment_address_hash(payment_address_t payment_address);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"[
			 short_hash_t ret = wallet_payment_address_hash((payment_address_t) $a_pointer);
             
             // uint8_t 64
             uint8_t* arr = (uint8_t*)malloc(sizeof(uint8_t) * 20);
             memcpy(arr, ret.hash, 20);
             return arr;
			]"
		end

feature -- History compact list.


	chain_history_compact_list_destruct(a_pointer: POINTER)
			--BITPRIM_EXPORT
			--void chain_history_compact_list_destruct(history_compact_list_t list);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"chain_history_compact_list_destruct((history_compact_list_t)$a_pointer)"
		end

	chain_history_compact_list_count (a_pointer: POINTER): INTEGER_64
			--BITPRIM_EXPORT
			--uint64_t /*size_t*/ chain_history_compact_list_count(history_compact_list_t list);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"return (uint64_t) chain_history_compact_list_count((history_compact_list_t)$a_pointer);"
		end


	chain_history_compact_list_nth(a_list: POINTER; a_index: INTEGER_64): POINTER
			--BITPRIM_EXPORT
			--history_compact_t chain_history_compact_list_nth(history_compact_list_t list, uint64_t /*size_t*/ n);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"return chain_history_compact_list_nth((history_compact_list_t)$a_list, (uint64_t)$a_index);"
		end


feature -- Chain

	chain_get_history (a_chain: POINTER; a_address: POINTER; a_limit: INTEGER_64; a_height: INTEGER_64; a_history: POINTER): INTEGER
			--BITPRIM_EXPORT
			--int chain_get_history(chain_t chain, payment_address_t address, uint64_t /*size_t*/ limit, uint64_t /*size_t*/ from_height, history_compact_list_t* out_history);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"[
				int res = chain_get_history((chain_t)$a_chain,(payment_address_t)$a_address,(uint64_t)$a_limit, (uint64_t)$a_height, (history_compact_list_t*) ($a_history));
				return res;
			]"
		end

--	chain_get_history_2 (a_chain: POINTER; a_address: POINTER; a_limit: INTEGER_64; a_height: INTEGER_64): POINTER
--			--BITPRIM_EXPORT
--			--int chain_get_history(chain_t chain, payment_address_t address, uint64_t /*size_t*/ limit, uint64_t /*size_t*/ from_height, history_compact_list_t* out_history);
--		external
--			"C inline use <bitprim/nodecint.h>"
--		alias
--			"[
--				history_compact_list_t out_history;
--				int res = chain_get_history((chain_t)$a_chain,(payment_address_t)$a_address,(uint64_t)$a_limit, (uint64_t)$a_height, &out_history);
--				return out_history;
--			]"
--		end

--	chain_get_last_height_2 (a_chain: POINTER): INTEGER_64
--			--BITPRIM_EXPORT
--			--int chain_get_last_height(chain_t chain, uint64_t /*size_t*/* height);
--		external
--			"C inline use <bitprim/nodecint.h>"
--		alias
--			"[
--				uint64_t out_height;
--				int res = chain_get_last_height((chain_t)$a_chain, &out_height);
--				return out_height;
--			]"
--		end

	chain_get_last_height (chain: POINTER; out_height: TYPED_POINTER [NATURAL_64]): INTEGER
	    external
	       "C inline use <bitprim/nodecint.h>"
	    alias
	        "return chain_get_last_height ((chain_t) $chain, $out_height);"
	    end

	chain_get_block_height (a_chain: POINTER; a_hash: POINTER; out_height: TYPED_POINTER [NATURAL_64]): INTEGER
	    external
	       "C inline use <bitprim/nodecint.h>"
	    alias
	        "[
	        	hash_t l_val;
		    	memcpy(l_val.hash, $a_hash, sizeof(l_val.hash));
		    	
		    	
		    	return chain_get_block_height ((chain_t) $a_chain, l_val, $out_height);
	        ]"
	    end





--BITPRIM_EXPORT
--error_code_t chain_get_block_header_by_height(chain_t chain, uint64_t /*size_t*/ height, header_t* out_header, uint64_t* /*size_t*/ out_height);

	chain_get_block_header_by_hash (a_chain: POINTER; a_hash:POINTER; out_header: TYPED_POINTER [POINTER]; out_height: TYPED_POINTER [NATURAL_64]): INTEGER
			--BITPRIM_EXPORT
			--error_code_t chain_get_block_header_by_hash(chain_t chain, hash_t hash, header_t* out_header, uint64_t* /*size_t*/ out_height);
		external
	       "C inline use <bitprim/nodecint.h>"
	    alias
	        "[
	        	hash_t l_val;
		    	memcpy(l_val.hash, $a_hash, sizeof(l_val.hash));
		    	
		    	return chain_get_block_header_by_hash ((chain_t)$a_chain, l_val, (header_t*)$out_header, (uint64_t*)$out_height);
	        ]"
	    end


	chain_get_block_header_by_height (a_chain: POINTER; a_height: NATURAL_64; out_header: TYPED_POINTER [POINTER];out_height: TYPED_POINTER [NATURAL_64]): INTEGER
				--BITPRIM_EXPORT
				--error_code_t chain_get_block_header_by_height(chain_t chain, uint64_t /*size_t*/ height, header_t* out_header, uint64_t* /*size_t*/ out_height);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"[
				return chain_get_block_header_by_height ((chain_t)$a_chain, (uint64_t) $a_height, (header_t*) $out_header, (uint64_t*) $out_height);
		        ]"
		end

	chain_get_block_by_height (a_chain: POINTER; a_height: NATURAL_64; out_block: TYPED_POINTER [POINTER]; out_height: TYPED_POINTER [NATURAL_64]): INTEGER
			--BITPRIM_EXPORT
			--error_code_t chain_get_block_by_height(chain_t chain, uint64_t /*size_t*/ height, block_t* out_block, uint64_t* /*size_t*/ out_height);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"[
				return chain_get_block_by_height ((chain_t)$a_chain, (uint64_t) $a_height, (block_t*) $out_block, (uint64_t*) $out_height);
		        ]"
		end

feature -- Block

	chain_block_is_valid (a_block: POINTER): BOOLEAN
			--BITPRIM_EXPORT
			--int chain_block_is_valid(block_t block);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return (EIF_BOOLEAN) chain_block_is_valid((block_t) $a_block);"
		end

	chain_block_header (a_block: POINTER): POINTER
			--BITPRIM_EXPORT
			--int chain_block_is_valid(block_t block);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_header((block_t) $a_block);"
		end

	chain_block_hash (a_block: POINTER): POINTER
			--BITPRIM_EXPORT
			--hash_t chain_block_hash(block_t block);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"[
			 hash_t ret = chain_block_hash((block_t) $a_block);
             
             uint8_t* arr = (uint8_t*)malloc(sizeof(uint8_t) * 32);
             memcpy(arr, ret.hash, 32);
             return arr;

			]"
		end

	chain_block_transaction_count (a_block: POINTER): NATURAL_64
			--	BITPRIM_EXPORT
			--uint64_t /*size_t*/ chain_block_transaction_count(block_t block);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_transaction_count((block_t) $a_block);"
		end

	chain_block_reward (a_block: POINTER; a_height: NATURAL_64): NATURAL_64
			--BITPRIM_EXPORT
			--uint64_t chain_block_reward(block_t block, uint64_t /*size_t*/ height);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_reward((block_t) $a_block, $a_height);"
		end


	chain_block_serialized_size (a_block: POINTER; a_version: NATURAL_32): NATURAL_64
			-- BITPRIM_EXPORT
			-- uint64_t /*size_t*/ chain_block_serialized_size(block_t block, uint32_t version);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_serialized_size((block_t) $a_block, $a_version);"
		end


	chain_block_proof_str (a_block: POINTER): POINTER
			-- BITPRIM_EXPORT
			-- char const* chain_block_proof_str(block_t block);	
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_proof_str((block_t)$a_block);"
		end

	chain_block_subsidy (a_height: NATURAL_64): NATURAL_64
			--BITPRIM_EXPORT
			--/*static*/
			--uint64_t chain_block_subsidy(uint64_t /*size_t*/ height);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_subsidy((uint64_t)$a_height);"
		end

	chain_block_fees (a_block: POINTER): NATURAL_64
			--BITPRIM_EXPORT
			--uint64_t chain_block_fees(block_t block);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_fees((block_t)$a_block);"
		end


	chain_block_claim (a_block: POINTER): NATURAL_64
			--BITPRIM_EXPORT
			--uint64_t chain_block_claim(block_t block);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_claim((block_t)$a_block);"
		end

	chain_block_generate_merkle_root (a_block: POINTER): POINTER
			--BITPRIM_EXPORT
			--hash_t chain_block_generate_merkle_root(block_t block);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"[
			 hash_t ret = chain_block_generate_merkle_root((block_t) $a_block);
             
             uint8_t* arr = (uint8_t*)malloc(sizeof(uint8_t) * 32);
             memcpy(arr, ret.hash, 32);
             return arr;

			]"
		end

	chain_block_signature_operations (a_block: POINTER): NATURAL_64
			--BITPRIM_EXPORT
			--uint64_t chain_block_signature_operations(block_t block);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_signature_operations((block_t)$a_block);"
		end

	chain_block_signature_operations_bip16_active (a_block: POINTER; a_bip16_active: BOOLEAN ): NATURAL_64
			--BITPRIM_EXPORT
			--uint64_t /*size_t*/ chain_block_signature_operations_bip16_active(block_t block, bool_t bip16_active);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_signature_operations_bip16_active((block_t)$a_block, (bool_t)$a_bip16_active);"
		end

	chain_block_total_inputs (a_block: POINTER; a_with_coinbase: BOOLEAN ): NATURAL_64
			--BITPRIM_EXPORT
			--uint64_t /*size_t*/ chain_block_total_inputs(block_t block, bool_t with_coinbase /*= true*/);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_total_inputs((block_t)$a_block, (bool_t)$a_with_coinbase);"
		end

	chain_block_is_extra_coinbases (a_block: POINTER): BOOLEAN
			--BITPRIM_EXPORT
			--bool_t chain_block_is_extra_coinbases(block_t block);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_is_extra_coinbases((block_t)$a_block);"
		end

	chain_block_is_final (a_block: POINTER; a_height: NATURAL_64; a_block_time: NATURAL_32): BOOLEAN
			--BITPRIM_EXPORT
			--bool_t chain_block_is_final(block_t block, uint64_t /*size_t*/ height, uint32_t block_time);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_is_final((block_t)$a_block, (uint64_t)$a_height, (uint32_t)$a_block_time);"
		end

	chain_block_is_distinct_transaction_set (a_block: POINTER): BOOLEAN
			--BITPRIM_EXPORT
			--bool_t chain_block_is_distinct_transaction_set(block_t block);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_is_distinct_transaction_set((block_t)$a_block);"
		end

	chain_block_is_valid_coinbase_claim (a_block: POINTER; a_height: NATURAL_64): BOOLEAN
			--BITPRIM_EXPORT
			--bool_t chain_block_is_valid_coinbase_claim(block_t block, uint64_t /*size_t*/ height);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_is_valid_coinbase_claim((block_t)$a_block, (uint64_t)$a_height);"
		end

	chain_block_is_valid_coinbase_script (a_block: POINTER; a_height: NATURAL_64): BOOLEAN
			--BITPRIM_EXPORT
			--bool_t chain_block_is_valid_coinbase_script(block_t block, uint64_t /*size_t*/ height);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_is_valid_coinbase_script((block_t)$a_block, (uint64_t)$a_height);"
		end

	chain_block_is_internal_double_spend (a_block: POINTER): BOOLEAN
			--BITPRIM_EXPORT
			--bool_t chain_block_is_internal_double_spend(block_t block);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_is_internal_double_spend((block_t)$a_block);"
		end


	chain_block_is_valid_merkle_root (a_block: POINTER): BOOLEAN
			--BITPRIM_EXPORT
			--bool_t chain_block_is_valid_merkle_root(block_t block);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_is_valid_merkle_root((block_t)$a_block);"
		end

	chain_block_to_data (a_block: POINTER; a_wire: BOOLEAN; a_out_size: TYPED_POINTER [NATURAL_64]): POINTER
			--BITPRIM_EXPORT
			--uint8_t const* chain_block_to_data(block_t block, bool_t wire, uint64_t* /*size_t*/ out_size);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_to_data((block_t)$a_block, (bool_t)$a_wire, (uint64_t*)$a_out_size);"
		end

	chain_block_transaction_nth (a_block: POINTER; a_n: NATURAL_64): POINTER
			--BITPRIM_EXPORT
			--transaction_t chain_block_transaction_nth(block_t block, uint64_t /*size_t*/ n);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return chain_block_transaction_nth((block_t) $a_block, (uint64_t)$a_n);"
		end


feature -- Block Header

	chain_header_is_valid (a_header: POINTER): BOOLEAN
			--BITPRIM_EXPORT
			--int chain_header_is_valid(header_t header);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
			"return (EIF_BOOLEAN) chain_header_is_valid((header_t)$a_header);"
		end

	chain_header_nonce (a_header: POINTER): NATURAL_32
			--BITPRIM_EXPORT
			--uint32_t chain_header_nonce(header_t header);		
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
				"return chain_header_nonce((header_t)$a_header);"
		end

	chain_header_version (a_header: POINTER): NATURAL_32
			--BITPRIM_EXPORT
			--uint32_t chain_header_version(header_t header);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
				"return chain_header_version((header_t)$a_header);"
		end

	chain_header_bits (a_header: POINTER): NATURAL_32
			--BITPRIM_EXPORT
			--uint32_t chain_header_bits(header_t header);	
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
				"return chain_header_bits((header_t)$a_header);"
		end

	chain_header_merkle (a_header: POINTER): POINTER
			--BITPRIM_EXPORT
			--hash_t chain_header_merkle(header_t header);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
				"[
	 				hash_t ret = chain_header_merkle((header_t)$a_header);
             
		             uint8_t* arr = (uint8_t*)malloc(sizeof(uint8_t) * 32);
		             memcpy(arr, ret.hash, 32);
		             return arr;
				]"
		end

	chain_header_previous_block_hash (a_header: POINTER): POINTER
			--BITPRIM_EXPORT
			--hash_t chain_header_previous_block_hash(header_t header);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
				"[
	 				hash_t ret = chain_header_previous_block_hash((header_t)$a_header);
             
		             uint8_t* arr = (uint8_t*)malloc(sizeof(uint8_t) * 32);
		             memcpy(arr, ret.hash, 32);
		             return arr;
				]"
		end

	chain_header_timestamp (a_header: POINTER): NATURAL_32
			--BITPRIM_EXPORT
			--uint32_t chain_header_timestamp(header_t header);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
				"return chain_header_timestamp((header_t)$a_header);"
		end


	chain_header_serialized_size (a_header: POINTER; a_version: NATURAL_32): NATURAL_64
			--BITPRIM_EXPORT
			--uint64_t /*size_t*/ chain_header_serialized_size(header_t header, uint32_t version);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
				"return chain_header_serialized_size((header_t)$a_header, (uint32_t)$a_version);"
		end

	chain_header_satoshi_fixed_size (a_version: NATURAL_32): NATURAL_64
			--BITPRIM_EXPORT
			--uint64_t /*size_t*/ chain_header_satoshi_fixed_size(uint32_t version);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
				"return chain_header_satoshi_fixed_size((uint32_t)$a_version);"
		end

feature -- History Compact		

	chain_history_compact_get_point_kind (a_history: POINTER): INTEGER
			-- BITPRIM_EXPORT
			-- point_kind_t chain_history_compact_get_point_kind(history_compact_t history);
			-- typedef enum point_kind {output = 0, spend = 1} point_kind_t;
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"[
				point_kind_t val;
				val = chain_history_compact_get_point_kind((history_compact_t)$a_history);
				printf("(int)val: %d\n", (int)val);
				printf("(unsigned long long)val: %ull\n", (unsigned long long)val);
				switch(val){
				    case output:  
				    			return 0;
				    			break;
				    case spend :  
				    			return 1;
				    			break;
    				default:      
    							return -1;
    							break;
				}
			]"
		end



--BITPRIM_EXPORT
--point_t chain_history_compact_get_point(history_compact_t history);


	chain_history_compact_get_height (a_history: POINTER): INTEGER_32
			--BITPRIM_EXPORT
			--uint32_t chain_history_compact_get_height(history_compact_t history);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"return chain_history_compact_get_height((history_compact_t)$a_history)"
		end


	chain_history_compact_get_value_or_previous_checksum (a_history:POINTER): INTEGER_64
			--BITPRIM_EXPORT
			--uint64_t chain_history_compact_get_value_or_previous_checksum(history_compact_t history);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"return chain_history_compact_get_value_or_previous_checksum((history_compact_t)$a_history)"
		end

feature -- Transaction

	chain_transaction_is_valid (a_transaction: POINTER): BOOLEAN
			--BITPRIM_EXPORT
			--int chain_transaction_is_valid(transaction_t transaction);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"return chain_transaction_is_valid ((transaction_t)$a_transaction);"
		end

	chain_transaction_version (a_transaction: POINTER): NATURAL_32
			--BITPRIM_EXPORT
			--uint32_t chain_transaction_version(transaction_t transaction);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"return chain_transaction_version ((transaction_t)$a_transaction);"
		end

	chain_transaction_hash (a_transaction: POINTER): POINTER
			--BITPRIM_EXPORT
			--hash_t chain_transaction_hash(transaction_t transaction);
		external
		       "C inline use <bitprim/nodecint.h>"
		alias
				"[
	 				hash_t ret = chain_transaction_hash((transaction_t) $a_transaction);
             
		             uint8_t* arr = (uint8_t*)malloc(sizeof(uint8_t) * 32);
		             memcpy(arr, ret.hash, 32);
		             return arr;
				]"
		end

	chain_transaction_is_coinbase (a_transaction: POINTER): BOOLEAN
			--BITPRIM_EXPORT
			--bool_t chain_transaction_is_coinbase(transaction_t transaction);	
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"return chain_transaction_is_coinbase ((transaction_t)$a_transaction);"
		end

end
