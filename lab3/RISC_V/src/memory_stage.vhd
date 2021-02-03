LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY memory_stage IS
	PORT (
          clk: IN std_logic;
          rst : IN std_logic;

          --input EX/MEM
          result_exmem: IN signed(31 downto 0); 
          data_exmem: IN signed(31 downto 0);
          
          rd_address_exmem: IN std_logic_vector(4 downto 0);
          RegWrite_exmem : in std_logic; --useful fwd
          wb_mux_sel_exmem: IN std_logic;

          --use for memory
          data_mem_in: IN signed(31 downto 0); --out_of_memory
          
          --output to data memory
          data_mem_out: OUT signed(31 downto 0);
          address_mem_out: OUT std_logic_vector(31 downto 0);
          
          --output to WB
          data_memwb: OUT signed(31 downto 0); --out of memory
          result_memwb: OUT signed(31 downto 0); --out of alu
          rd_address_memwb: OUT std_logic_vector(4 downto 0);
          wb_mux_sel_memwb: OUT std_logic;
          RegWrite_memwb: out std_logic);
END memory_stage;

ARCHITECTURE structural OF memory_stage IS

begin

    data_mem_out <= data_exmem; --data written in memory
    address_mem_out <= std_logic_vector(result_exmem); --load/store indirizzi

--MEM/WB register              
PROCESS(clk)
BEGIN
    IF rst = '1' THEN
        data_memwb <= x"00000000";
        result_memwb <= x"00000000";
        rd_address_memwb <= "00000";
        wb_mux_sel_memwb <= '0';
        RegWrite_memwb <= '0';
    ELSIF RISING_EDGE(clk) THEN
        data_memwb <= data_mem_in;
        result_memwb <= result_exmem;
        rd_address_memwb <= rd_address_exmem;
        wb_mux_sel_memwb <= wb_mux_sel_exmem;
        RegWrite_memwb <= RegWrite_exmem;
    END IF;
END PROCESS;

END structural;