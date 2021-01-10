LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY data_memory IS
PORT (address: IN std_logic_vector(31 downto 0);
		data: IN signed(31 downto 0);
		MemWrite, MemRead, clock, cs: IN STD_LOGIC;
		Qout: OUT signed(31 downto 0));
END data_memory;

ARCHITECTURE Behavior OF data_memory IS
type ram_array is ARRAY(67125248 to 67125368) of signed (31 downto 0);
signal mem: ram_array;
BEGIN
	PROCESS (clock)
	BEGIN
		IF clock'event and clock='1' THEN
			IF	cs='1' THEN
				IF MemWrite='1' then 
					mem(to_integer(unsigned(address(31 downto 2)))) <= data;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	Qout <= mem(to_integer(unsigned(address(31 downto 2)))) when (MemRead='1' and cs='1');
END Behavior;