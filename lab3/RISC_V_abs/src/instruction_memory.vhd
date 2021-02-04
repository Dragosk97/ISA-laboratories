Library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity instruction_memory is
  port ( address : in std_logic_vector(31 downto 0);
         data : out std_logic_vector(31 downto 0) );
end instruction_memory;

architecture structural of instruction_memory is
	
	constant start_index :integer := 1048576;
	constant stop_index :integer := 1048594;
	
	type mem is array ( start_index to stop_index) of std_logic_vector(31 downto 0);
	constant rom_content : mem := (
		"00000000011100000000100000010011",
		"00001111110000010000001000010111",
		"11111111110000100000001000010011",
		"00001111110000010000001010010111",
		"00000001000000101000001010010011",
		"01000000000000000000011010110111",
		"11111111111101101000011010010011",
		"00000010000010000000001001100011",
		"00000000000000100010010000000011",
		"00000000000001000000010100000111",
		"00000000010000100000001000010011",
		"11111111111110000000100000010011",
		"00000000110101010010010110110011",
		"11111110000001011000010011100011",
		"00000000000001010000011010110011",
		"11111110000111111111000011101111",
		"00000000110100101010000000100011",
		"00000000000000000000000011101111",
		"00000000000000000000000000010011"
	);
	begin
	process(address)
		begin
			if to_integer(unsigned(address(31 downto 2))) >= start_index and to_integer(unsigned(address(31 downto 2))) <= stop_index then
				data <= rom_content(to_integer(unsigned(address(31 downto 2))));
			else	  	
				data <= (others => '0');
			end if;
	end process;
end structural;
