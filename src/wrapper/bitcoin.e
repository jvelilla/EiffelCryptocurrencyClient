note
	description: "Summary description for {BITCOIN}."
	date: "$Date$"
	revision: "$Revision$"

class
	BITCOIN

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
			"executor_destruct((executor_t) $a_executor );"
		end

	executor_initchain (a_executor: POINTER): INTEGER_32
			--  BITPRIM_EXPORT int executor_initchain(executor_t exec);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"return executor_initchain((executor_t) $a_executor);"
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

	word_list_constructor: POINTER
			-- BITPRIM_EXPORT word_list_t word_list_construct;
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"return word_list_construct();"
		end

	work_list_add_word (a_word_list: POINTER; a_word: POINTER)
			--BITPRIM_EXPORT
			--void word_list_add_word(word_list_t word_list, const char* word);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"word_list_add_word((word_list_t) $a_word_list, (const char*) $a_word)"
		end

	word_list_destuctor (a_word_list: POINTER)
			--BITPRIM_EXPORT void word_list_destruct(word_list_t word_list);
		external
			"C inline use <bitprim/nodecint.h>"
		alias
			"word_list_destruct((word_list_t) $a_word_list)"
		end

end
