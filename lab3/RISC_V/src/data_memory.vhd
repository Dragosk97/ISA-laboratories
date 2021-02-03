LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

ENTITY data_memory IS
PORT (address: IN std_logic_vector(31 downto 0);
		data: IN signed(31 downto 0);
		MemWrite, MemRead, clock, rst: IN STD_LOGIC;
		Qout: OUT signed(31 downto 0));
END data_memory;

ARCHITECTURE Behavior OF data_memory IS
constant start_index : integer := 67125248;
constant stop_index : integer:=   67125368;

type ram_array is ARRAY(start_index to stop_index) of signed (31 downto 0);
signal mem: ram_array;
BEGIN
	PROCESS (clock, rst)
	file fp_in : text open READ_MODE is "../tb/data_bin.txt";
	variable line_in : line;
	variable x : bit_vector(31 downto 0);
	BEGIN
		IF rst = '1' THEN
			for i in start_index to stop_index loop
				if not endfile(fp_in) then
					readline(fp_in, line_in);
					read(line_in, x);
					mem(i) <= signed(to_stdlogicvector(x));
--				else
--					mem(i) <= x"00000000";
				end if;
			end loop;

		ELSIF clock'event and clock='1' THEN
			
				IF MemWrite='1' then 
					mem(to_integer(unsigned(address(31 downto 2)))) <= data;
				END IF;
			
		END IF;
	END PROCESS;
	process(address, MemRead)
		begin
			if to_integer(unsigned(address(31 downto 2))) >= start_index and to_integer(unsigned(address(31 downto 2))) <= stop_index then
				if MemRead = '1' then 				
					Qout <= mem(to_integer(unsigned(address(31 downto 2))));
				else 
					Qout <= x"00000000";
				end if;
			else	  	
				Qout <= (others => '0');
			end if;
	end process;
END Behavior;
