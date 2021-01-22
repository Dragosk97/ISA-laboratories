LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY prediction_table IS
PORT (  PT_read_address: IN std_logic_vector(3 downto 0);
        PT_write_address: IN std_logic_vector(3 downto 0);
        PT_data: IN std_logic_vector(32 downto 0);
        MemWrite, MemRead, clock, rst: IN STD_LOGIC;
        Qout: OUT std_logic_vector(32 downto 0));
END prediction_table;

ARCHITECTURE behavioural of prediction_table is

type ram_array is ARRAY(0 to 15) of STD_LOGIC_VECTOR(32 downto 0);
signal mem: ram_array;

BEGIN
	PROCESS (clock)
    BEGIN
        IF clock'event and clock='1' THEN
            if (rst='1') then
                mem <= (others => (others =>'0')); --array initialize to 0
            ELSIF MemWrite='1' then 
                mem(to_integer(unsigned(PT_write_address)) <= PT_data;
            END IF;
        END IF;
    END PROCESS;

Qout <= mem(to_integer(unsigned(PT_read_address))) when (MemRead='1') else (others => '0');

END behavioural;