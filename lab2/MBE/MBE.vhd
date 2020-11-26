library ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity MBE_n is
generic(nbit : integer)
    port(
        a : in std_logic_vector(nbit-1 downto 0);
        b0 : in std_logic_vector; 
        b1 : in std_logic_vector;
        b2 : in std_logic_vector;
        pp : out std_logic_vector(nbit downto 0)
    );
end entity;

architecture behavioural of MBE_n is 
begin
    process(b0,b1,b2)
        begin
            if NOT(b1 XOR b0) AND NOT(b2 xOR b1) = '1' then
                pp <= (others => '0');
            elsif b1 XOR b0 = '1' then 
                pp <= '0' & a;
            elsif NOT(b1 XOR b0) AND (b2 xOR b1) = '1' then 
                pp <= a & '0';
            end if;
        end process;
            
end architecture;




