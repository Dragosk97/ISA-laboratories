library ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity MBE_n is
generic(nbit : integer);
    port(
        a : in std_logic_vector(nbit-1 downto 0);
        b0 : in std_logic; 
        b1 : in std_logic;
        b2 : in std_logic;
        pp : out std_logic_vector(nbit downto 0)
    );
end entity;

architecture behavioural of MBE_n is

  signal pp_i : std_logic_vector(nbit downto 0);
  
begin

    process(a,b0,b1,b2)
    begin
        if (NOT(b1 XOR b0) AND (NOT(b2 XOR b1))) = '1' then
            pp_i <= (others => '0');
        elsif (b1 XOR b0) = '1' then 
            pp_i <= '0' & a;
        else
            pp_i <= a & '0';
        end if;
    end process;

    pp <= pp_i XOR ""&b2;
    
end architecture;




