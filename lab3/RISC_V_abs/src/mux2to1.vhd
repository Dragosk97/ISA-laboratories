library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity mux2to1 is
	GENERIC (n : INTEGER := 47 );
	port
	(	a: in signed(n-1 downto 0);
		b: in signed(n-1 downto 0);
		s: in std_logic;
		z: out signed(n-1 downto 0)
	);
end mux2to1;

architecture behavioral of mux2to1 is
begin

	z <= a when s = '0' else b;

end behavioral;