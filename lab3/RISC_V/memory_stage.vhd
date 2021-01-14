LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY memory_stage IS
	PORT (
          --input EX/MEM
          data_exmem: IN signed(31 downto 0);
          data_in_mem: IN signed(31 downto 0);
          
          rd_address_exmem: IN std_logic_vector(4 downto 0);
          exmem_fwd_en: IN std_logic;
          wb_mux_sel: IN std_logic;

          --output to WB
          data1_memwb: OUT signed(31 downto 0);
          data1_memwb: OUT signed(31 downto 0);
          rd_address_memwb: OUT std_logic_vector(4 downto 0);
          wb_mux_sel_out: OUT std_logic

          --output to EXECUTE
          data_mux_out: OUT igned(31 downto 0);
          rd_address_out: OUT std_logic_vector(4 downto 0);
          wb_fwd_en: OUT std_logic
    );
END memory_stage;

ARCHITECTURE structural OF memory_stage IS

begin

data_mux_out <= data_exmem;
rd_address_out <= rd_address_exmem;
wb_fwd_en <= wb_mux_sel;

--MEM/WB register              
PROCESS(clk)
BEGIN
    IF RISING_EDGE(clk) THEN
        data1_memwb <= data_in_mem;
        data2_memwb <= data_exmem;
        rd_address_memwb <= rd_address_exmem;
        wb_mux_sel_out <= wb_mux_sel;
    END IF;
END PROCESS;

END structural;