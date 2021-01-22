LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY prediction_table IS
PORT (  prediction: IN std_logic_vector(32 downto 0);
        data: IN signed(32 downto 0);
        MemWrite, MemRead, clock, rst: IN STD_LOGIC;
        Qout: OUT signed(32 downto 0));
END prediction_table;

ARCHITECTURE behavioural of prediction_table is

type ram_array is ARRAY(0 to 32) of STD_LOGIC_VECTOR(32 downto 0);
signal mem: ram_array;

BEGIN
	PROCESS (clock)
    BEGIN
        IF clock'event and clock='1' THEN
            if (rst='1') then
                mem <= (others => (others =>'0'));
            ELSIF MemWrite='1' then 
                mem(to_integer(unsigned(prediction(32 downto 0)))) <= data;
            END IF;
            END IF;
        END IF;
    END PROCESS;

Qout <= mem(to_integer(unsigned(prediction(32 downto 0)))) when (MemRead='1');

END behavioural;