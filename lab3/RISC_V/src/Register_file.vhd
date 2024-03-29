Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file is   
    port
    (
		write_data    : in signed(31 downto 0);
		RegWrite      : in std_logic;
		read_reg1     : in std_logic_vector(4 downto 0);
		read_reg2     : in std_logic_vector(4 downto 0);
		write_reg     : in std_logic_vector(4 downto 0);
		clk           : in std_logic;
		rst			  : in std_logic;
		read_data1	  : out signed(31 downto 0);
		read_data2	  : out signed(31 downto 0));
end register_file;

architecture behavioral of register_file is

type registerFile is array(0 to 31) of signed(31 downto 0);
signal registers : registerFile;

begin
    reg_bank: process(clk)
    begin
        if (clk'event and clk = '1') then

			if(rst = '1') then
				for i in 0 to 31 loop
					registers(i) <= x"00000000";
				end loop;
				
			else
				if (RegWrite = '1') then
					registers(to_integer(unsigned(write_reg))) <= write_data;
				end if;
			end if;
		end if;
	end process;

	read_data1 <= registers(to_integer(unsigned(read_reg1)));
	read_data2 <= registers(to_integer(unsigned(read_reg2)));
	
end behavioral;