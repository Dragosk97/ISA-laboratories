library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity abs_unit is
    port (
        a : in signed (31 downto 0);
        abs_a : out signed(31 downto 0)
    );
end abs_unit;

architecture behav of abs_unit is

begin
    abs_a <= abs(a);
end behav; -- behav