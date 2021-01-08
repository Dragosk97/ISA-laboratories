library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder is
	generic ( n : integer := 16 );
    port ( add1 : in  signed (n-1 downto 0);
           add2 : in  signed (n-1 downto 0);
           sum : out  signed (n downto 0));
end adder;

architecture behavioral of adder is
signal add1_ext, add2_ext : signed (n downto 0);
begin

	add1_ext <= add1(n-1) & add1;
	add2_ext <= add2(n-1) & add2;
	sum <= add1_ext + add2_ext;

end behavioral;