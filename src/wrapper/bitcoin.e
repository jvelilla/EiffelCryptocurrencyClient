note
	description: "Summary description for {BITCOIN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BITCOIN


feature -- Executor

	executor_run_wait (a_executor: POINTER): INTEGER_32
			--	BITPRIM_EXPORT int executor_run_wait(executor_t exec);
		external
			"C [macro %"bitprim/nodecint.h%"] (executor_t) : int"
		alias
			"executor_run_wait"
		end

	new_executor (a_path: POINTER; a_file: POINTER; a_error: POINTER): POINTER
			--BITPRIM_EXPORT executor_t executor_construct(char const*, FILE* sout, FILE* serr);
		external
--			"C inline use <nodecint.h>"
			"C [macro %"bitprim/nodecint.h%"] (char const*, FILE* , FILE* ) : executor_t"
		alias
--			"return executor_construct((char const*) $a_path, (FILE*) $a_file, (FILE*) $a_error)"
			"executor_construct"
		end

	executor_destruct (a_executor: POINTER)
			--	BITPRIM_EXPORT void executor_destruct(executor_t exec);
		external
--			"C inline use <nodecint.h>"
			"C [macro %"bitprim/nodecint.h%"] (executor_t)"
		alias
--			"executor_destruct((executor_t) $a_executor)"
			"executor_destruct"
		end

	executor_initchain (a_executor: POINTER): INTEGER_32
			--  BITPRIM_EXPORT int executor_initchain(executor_t exec);
		external
--			"C inline use <nodecint.h>"
			"C [macro %"bitprim/nodecint.h%"] (executor_t): int"
		alias
--			"executor_destruct((executor_t) $a_executor)"
			"executor_initchain"
		end


feature -- Wallet

--	wallet_mnemonics_to_seed (a_mnemonics: POINTER)
--BITPRIM_EXPORT
--long_hash_t wallet_mnemonics_to_seed(word_list_t mnemonics);

--BITPRIM_EXPORT
--void long_hash_destroy(long_hash_t ptr);


	work_list_constructor: POINTER
			-- BITPRIM_EXPORT word_list_t word_list_construct;
		external
			"C [macro %"bitprim/nodecint.h%"] () : word_list_t"
		alias
			"word_list_construct"
		end



--BITPRIM_EXPORT
--void word_list_add_word(word_list_t word_list, const char* word);

--BITPRIM_EXPORT
--void word_list_destruct(word_list_t word_list);
end
