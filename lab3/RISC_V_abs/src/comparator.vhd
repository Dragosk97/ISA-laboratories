library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator is
    generic (n : integer := 32);
    port (
        x : in signed(n-1 downto 0);
        y : in signed(n-1 downto 0);
        eq : out std_logic
    );
end comparator;

architecture behav of comparator is
begin
    eq <= '1' when x = y else '0';
end behav;