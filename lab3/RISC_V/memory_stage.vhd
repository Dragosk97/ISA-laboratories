LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY memory_stage IS
	PORT (
          --input EX/MEM
          data_exmem: IN signed(31 downto 0);
          data_in_mem: IN signed(31 downto 0);
          
          --address_exmem: IN signed(31 downto 0);
          rd_address_exmem: IN std_logic_vector(4 downto 0);
          exmem_fwd_en: IN std_logic;
          wb_mux_sel: IN std_logic;

          --output
          exmem_fwd_en_out: OUT std_logic;
          data_memwb: OUT signed(31 downto 0);
          rd_address_memwb_out: OUT std_logic_vector(4 downto 0);
          wb_mux_sel_out: OUT std_logic
    );
END memory_stage;

ARCHITECTURE structural OF memory_stage IS

SIGNAL

begin

--MEM/WB register              
PROCESS(clk)
BEGIN
    IF RISING_EDGE(clk) THEN
        data_memwb <= data_in_mem;
        
    END IF;
END PROCESS;

END structural;