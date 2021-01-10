Library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity uROM is
  port ( address : in std_logic_vector(3 downto 0);
         data : out std_logic_vector(37 downto 0) );
end entity uROM;

architecture structural of uROM is
	
	--Creo la tabella ed inserisco i bit di controllo
	--corrispondenti ad ogni stato:
	type mem is array (0 to 12) of std_logic_vector(37 downto 0);
	constant my_rom : mem := (
    "10000000000000000001010011100101100000",
    "00000000000111000001010101100001000010",
    "00010000000111011100101010001000000000",
    "00010000000000000001010101100000000000",
    "00010100000000000001010101001000000000",
    "00010101000000000001010010100000000000",
    "00001100010000000001010001000100001001",
    "00000101111000000001010001000011000000",
    "00000011001010000010101001011100001100",
    "00000000010010000001100001011000000100",
    "00000000001010000101010001000011010100",
    "01100000000010000100101010001011000100",
    "11000000000000000001100101100001000000"
	);
	begin
		rom_execution: process (address)
		begin
			--In base al valore dell'ingresso viene
			--prelevata una diversa riga della rom:
			case address is
			   when "0000" => data <= my_rom(0);
			   when "0001" => data <= my_rom(1);
			   when "0010" => data <= my_rom(2);
			   when "0011" => data <= my_rom(3);
			   when "0100" => data <= my_rom(4);
			   when "0101" => data <= my_rom(5);
			   when "0110" => data <= my_rom(6);
			   when "0111" => data <= my_rom(7);
			   when "1000" => data <= my_rom(8);
			   when "1001" => data <= my_rom(9);
			   when "1010" => data <= my_rom(10);
			   when "1011" => data <= my_rom(11);
			   when "1100" => data <= my_rom(12);
			   when others => data <= my_rom(0);
			   end case;
  end process;
  
end structural;