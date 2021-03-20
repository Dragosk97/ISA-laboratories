library IEEE;
use IEEE.std_logic_1164.all;

entity FA is
port (a, b, cin : in std_logic;
		s, cout : out std_logic);
end entity;

architecture struct of FA is
begin
process (a,b,cin)
begin
if cin = '0' then
	s <= a XOR b;
	cout <= a AND b;
else s <= a XNOR b;
	  cout <= a OR b;
end if;
end process;
end architecture;