library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.all;

entity GenericReg is
generic(regwidth : integer);
port(d : in std_logic_vector (regwidth -1 downto 0);
	  clk : in std_logic;
	  rst: in std_logic;
	  en : in std_logic;
	  q : out std_logic_vector(regwidth -1 downto 0));
end entity;

architecture Behavioral of GenericReg is
BEGIN
--sincronous
	PROCESS (clk)
		BEGIN
		IF Clk'EVENT AND Clk = '1' THEN
			IF rst = '1' THEN
				q <= (others => '0');
			ELSIF en = '1' THEN
				q <= d;
			END IF;
		END IF;
	END PROCESS;
	
END Behavioral;
