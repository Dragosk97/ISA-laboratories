library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity clk_gen is
  port (
    CLK: out std_logic;
    start_address: out std_logic_vector(31 downto 0);
    RST  : out std_logic);
end clk_gen;

architecture beh of clk_gen is

  constant Ts : time := 13.28 ns;
  
  signal CLK_i : std_logic;
  
begin  -- beh

  process
  begin  -- process
    if (CLK_i = 'U') then
      CLK_i <= '0';
    else
      CLK_i <= not(CLK_i);
    end if;
    wait for Ts/2;
  end process;

  CLK <= CLK_i;

  process
  begin  -- process
    RST <= '1';
    wait for 3*Ts/2;
    RST <= '0';
    wait;
  end process;

start_address <= "00000000010000000000000000000000";

end beh;
