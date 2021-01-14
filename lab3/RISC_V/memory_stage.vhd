LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY memory_stage IS
	PORT (
          --input EX/MEM
          rd_address_exmem: IN std_logic_vector(4 downto 0);
          mux2_fwd_out: IN signed(31 downto 0);
          result_exmem: IN signed(31 downto 0);
          exmem_fwd_en: IN std_logic;
       
    );
END memory_stage;

ARCHITECTURE structural OF memory_stage IS

END structural;