library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity clk_gen is
  port (
    END_SIM : in  std_logic;
    CLK     : out std_logic;
    start_address: out std_logic_vector(31 downto 0);
    RST_n   : out std_logic);
end clk_gen;

architecture beh of clk_gen is

  constant Ts : time := 7.52 ns;
  
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

  CLK <= CLK_i and not(END_SIM);

  process
  begin  -- process
    RST_n <= '0';
    wait for 3*Ts/2;
    RST_n <= '1';
    wait;
  end process;

  process
  begin  -- process
    start_address <= (others => '0');
    wait for 3*Ts/2;
    start_address <= "00000000011100000000100000010011";
    wait;
  end process;

end beh;
