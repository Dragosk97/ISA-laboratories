LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY memoria IS
PORT (address: IN STD_LOGIC_VECTOR(9 downto 0);
		data: IN STD_LOGIC_VECTOR(7 downto 0);
		WR_n, RD, clock, cs: IN STD_LOGIC;
		Qout: OUT STD_LOGIC_VECTOR(7 downto 0));
END memoria;

ARCHITECTURE Behavior OF memoria IS
type ram_array is ARRAY(0 to 1023) of STD_LOGIC_VECTOR(7 downto 0);
signal mem: ram_array;
BEGIN
	PROCESS (clock)
	BEGIN
		IF clock'event and clock='1' THEN
			IF	cs='1' THEN
				IF WR_n='0' then 
					mem(to_integer(unsigned(address))) <= data;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	Qout <= mem(to_integer(unsigned(address))) when (RD='1' and cs='1');
END Behavior;