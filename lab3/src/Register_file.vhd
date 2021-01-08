--SQUADRA B5
Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file is   
    port
    (
		outA          : out std_logic_vector(23 downto 0);
		outB          : out std_logic_vector(23 downto 0);
		outC          : out std_logic_vector(23 downto 0);
		inA           : in  std_logic_vector(23 downto 0);
		inB           : in  std_logic_vector(23 downto 0);
		inC           : in  std_logic_vector(23 downto 0);
		WE_inA        : in std_logic;
		WE_inB        : in std_logic;
		WE_inC        : in std_logic;
		inA_ADDR      : in std_logic_vector(2 downto 0);
		inB_ADDR      : in std_logic_vector(2 downto 0);
		inC_ADDR      : in std_logic_vector(2 downto 0);
		outA_ADDR     : in std_logic_vector(2 downto 0);
		outB_ADDR     : in std_logic_vector(2 downto 0);
		outC_ADDR     : in std_logic_vector(2 downto 0);
		clk           : in std_logic;
		rst			  : in std_logic
    );
end register_file;

architecture behavioral of register_file is

type registerFile is array(0 to 5) of std_logic_vector(23 downto 0);
signal registers : registerFile;

begin
    reg_bank: process(clk)
    begin
        if (clk'event and clk = '1') then
        
			--Se il rst è attivo tutti i registri sono a 0:
			if(rst = '1') then
				for i in 0 to 5 loop
					registers(i) <= x"000000";
				end loop;
				
			--Altrimenti vengono scritti i registri abilitati dal WE:
			else
				if (WE_inA = '1') then
					registers(to_integer(unsigned(inA_ADDR))) <= inA;
				end if;
				if (WE_inB = '1') then
					registers(to_integer(unsigned(inB_ADDR))) <= inB;
				end if;
				if (WE_inC = '1') then
					registers(to_integer(unsigned(inC_ADDR))) <= inC;
				end if;
			end if;
		end if;
	end process;
	
	--Le uscite del register file vengono fornite sempre.
	outA <= registers(to_integer(unsigned(outA_ADDR)));
	outB <= registers(to_integer(unsigned(outB_ADDR)));
	outC <= registers(to_integer(unsigned(outC_ADDR)));
            
end behavioral;