LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Counter_nbit IS
	GENERIC (n : INTEGER := 3);
	PORT( EN : in std_logic;
			RST_n : in std_logic;
			CLK : in std_logic;
			Q: buffer std_logic_vector(n-1 downto 0)
	);
END Counter_nbit;

ARCHITECTURE Behavioural OF Counter_nbit IS

BEGIN

PROCESS (CLK, RST_n)
BEGIN
	IF RST_n = '0' THEN
		Q <= (others => '0');
	ELSIF CLK'EVENT AND CLK = '1' THEN
		IF EN = '1' THEN
			Q <= std_logic_vector( unsigned(Q) + 1);
		END IF;
	END IF;
END PROCESS;

END Behavioural;
