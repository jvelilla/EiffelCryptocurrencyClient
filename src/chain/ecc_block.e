note
	description: "Summary description for {ECC_BLOCK}."
	date: "$Date$"
	revision: "$Revision$"

class
	ECC_BLOCK
inherit

	WRAPPER_BASE
		rename
			make as make_base
		end
	REFACTORING_HELPER

create
	make

feature {ECC_BITCOIN} -- Creation

	make (a_pointer: POINTER)

		do
			make_base (a_pointer)
		end

feature -- Sratus Report

	is_valid: BOOLEAN
		do
			Result := {ECC_BITCOIN}.chain_block_is_valid (item)
		end

	height: NATURAL_64

feature -- Change status

	set_height (a_val: NATURAL_64)
			-- Set the block height.
		do
			height := a_val
		ensure
			height_set: height = a_val
		end


feature -- Status Report

	is_extra_coinbases: BOOLEAN
			-- True if and only if there is more than one coinbase transaction in the block.
		do
			Result := {ECC_BITCOIN}.chain_block_is_extra_coinbases (item)
		end

--BITPRIM_EXPORT
--bool_t chain_block_is_final(block_t block, uint64_t /*size_t*/ height, uint32_t block_time);



	is_distinct_transaction_set: BOOLEAN
			-- True iff all transactions in the block have a unique hash (i.e. no duplicates).
		do
			Result := {ECC_BITCOIN}.chain_block_is_distinct_transaction_set (item)
		end

	is_valid_coinbase_claim (a_height: NATURAL_64): BOOLEAN
			-- Given a block height `a_height' return true if and only if its coinbase claim is not higher than the deserved reward.
		do
			Result := {ECC_BITCOIN}.chain_block_is_valid_coinbase_claim (item, a_height);
		end


	is_valid_coinbase_script (a_height: NATURAL_64): BOOLEAN
			-- True if and only if the block's coinbase script is valid.
		do
			Result := {ECC_BITCOIN}.chain_block_is_valid_coinbase_script (item, height)
		end

	is_internal_double_spend: BOOLEAN
			-- True if and only if there is at least one double-spent transaction in this block.
		do
			Result := {ECC_BITCOIN}.chain_block_is_internal_double_spend (item)
		end

	is_valid_merkle_root: BOOLEAN
			-- True if and only if the generated Merkle root equals the header's Merkle root
		do
			Result := {ECC_BITCOIN}.chain_block_is_valid_merkle_root (item)
		end

feature -- Access

	header: ECC_BLOCK_HEADER
			--  The block's header.
		do
			create Result.make ({ECC_BITCOIN}.chain_block_header (item))
		end

	hash: STRING_8
		do
			Result := block_hash_implementation.to_hex_string
		end

	transaction_count: NATURAL_64
			-- The total amount of transactions that the block contains.
		do
			Result := {ECC_BITCOIN}.chain_block_transaction_count (item)
		end

	reward: NATURAL_64
			-- Reward = Subsidy + Fees, for the block at the given height.
		do
			Result := {ECC_BITCOIN}.chain_block_reward (item, height)
		ensure
			check_sanity: Result = subsidy + fees
		end

	size: NATURAL_64
			-- Block size in bytes.
		do
			Result := {ECC_BITCOIN}.chain_block_serialized_size (item, header.version)
		end

	proof_string: READABLE_STRING_8
			-- Amount of work done to mine the block.
		local
			l_result: C_STRING
		do
			create l_result.make_by_pointer ({ECC_BITCOIN}.chain_block_proof_str (item))
			Result := l_result.string
		end

	subsidy: NATURAL_64
			--  The block subsidy. It's the same value for all blocks.
		do
			Result := {ECC_BITCOIN}.chain_block_subsidy (height)
		end

	fees: NATURAL_64
			-- Miner fees included in the block's coinbase transaction.
		do
			Result := {ECC_BITCOIN}.chain_block_fees (item)
		end

	claim: NATURAL_64
			-- Sum of coinbase outputs.
		do
			Result := {ECC_BITCOIN}.chain_block_claim (item)
		end

	generate_merkle_root: READABLE_STRING_8
			-- The block's Merkle root, as a STRING.
		do
			Result := block_generate_merkle_root_hash_implementation.to_hex_string
		end

	signature_operations: NATURAL_64
			-- Amount of signature operations in the block.
		do
			Result := {ECC_BITCOIN}.chain_block_signature_operations (item)
		end

	signature_operations_bip16_active (a_bip16_active: BOOLEAN): NATURAL_64
			-- Amount of signature operations in the block.
		do
			Result := {ECC_BITCOIN}.chain_block_signature_operations_bip16_active (item, a_bip16_active)
		end

	total_inputs (a_with_coinbase: BOOLEAN): NATURAL_64
			-- The sum of all inputs of all transactions in the block.
		do
			Result := {ECC_BITCOIN}.chain_block_total_inputs (item, a_with_coinbase)
		end

	to_data (a_wire: BOOLEAN): detachable ARRAY [NATURAL_8]
			-- Raw block data.
			-- `a_wire' if and only if true, include data size at the beginning.
		local
			l_size: NATURAL_64
			l_pointer: POINTER
			l_md_pointer: MANAGED_POINTER
		do
			l_pointer := {ECC_BITCOIN}.chain_block_to_data(item, a_wire, $l_size)
			create l_md_pointer.make_from_pointer (l_pointer, l_size.to_integer_32)
			Result := l_md_pointer.read_array (0, l_md_pointer.count)
		end

	transaction_nth (a_n: NATURAL_64): ECC_TRANSACTION
			-- Given a position in the block, returns the corresponding transaction.	
			--todo add precondition a_n <= transaction_count.
		do
			create Result.make ({ECC_BITCOIN}.chain_block_transaction_nth (item, a_n))
		end

feature -- Disponse

	dispose
			-- <Precursor>
		do
			item := default_pointer
		end


feature {NONE} --Implemantation

	block_hash_implementation: BYTE_ARRAY_CONVERTER
		local
			l_memory: MANAGED_POINTER
			l_array: ARRAY [NATURAL_8]
			l_temp: ARRAY [NATURAL_8]
		do
			create l_memory.make_from_pointer ({ECC_BITCOIN}.chain_block_hash (item), 32)
			l_array := l_memory.read_array (0, 32)

			create l_temp.make_filled (0, 1, 32)
			across l_array.new_cursor.reversed as ic loop
				l_temp.force (ic.item, ic.cursor_index)
			end

			create Result.make (32)
			Result.append_bytes (l_temp)
		end

	block_generate_merkle_root_hash_implementation: BYTE_ARRAY_CONVERTER
		local
			l_memory: MANAGED_POINTER
			l_array: ARRAY [NATURAL_8]
			l_temp: ARRAY [NATURAL_8]
		do
			create l_memory.make_from_pointer ({ECC_BITCOIN}.chain_block_generate_merkle_root (item), 32)
			l_array := l_memory.read_array (0, 32)

			create l_temp.make_filled (0, 1, 32)
			across l_array.new_cursor.reversed as ic loop
				l_temp.force (ic.item, ic.cursor_index)
			end

			create Result.make (32)
			Result.append_bytes (l_temp)
		end

end
