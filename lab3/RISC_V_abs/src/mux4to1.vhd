library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4to1 is
    generic (N : integer := 32);
    port (
        a, b, c, d : signed(N-1 downto 0);
        sel : std_logic_vector(1 downto 0);
        m_out : signed(N-1 downto 0)
    );
end mux4to1;

architecture behav of mux4to1 is

begin
    m_out <=    a when s = "00" else
                b when s = "01" else
                c when s = "10" else
                d;
end behav ; -- behav