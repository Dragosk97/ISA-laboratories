library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder is
	generic ( n : integer := 16 );
    port ( add1 : in  signed (n-1 downto 0);
           add2 : in  signed (n-1 downto 0);
           sum : out  signed (n-1 downto 0));
end adder;

architecture behavioral of adder is
begin

	sum <= add1 + add2;

end behavioral;