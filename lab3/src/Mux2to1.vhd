library ieee;
use ieee.std_logic_1164.all;

entity mux2to1 is
	GENERIC (n : INTEGER := 47 );
	port
	(
		a: in std_logic_vector(n-1 downto 0);
		b: in std_logic_vector(n-1 downto 0);
		s: in std_logic;
		z: out std_logic_vector(n-1 downto 0)
	);
end mux2to1;

architecture behavioral of mux2to1 is
begin

	z <= a when s = '0' else b;

end behavioral;