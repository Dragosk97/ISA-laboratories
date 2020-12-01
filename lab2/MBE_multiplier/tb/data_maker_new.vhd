library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_maker is  
  port (
    CLK     : in  std_logic;
    RST_n   : in  std_logic;
    a : out std_logic_vector (23 downto 0);
    b : out std_logic_vector (23 downto 0);
    END_SIM : out std_logic);
end data_maker;

architecture beh of data_maker is

  constant tco : time := 1 ns;
  signal sEndSim : std_logic;
  signal END_SIM_i : std_logic_vector(0 to 10);  


begin  -- beh

  process (CLK, RST_n)
    file fp_in : text open READ_MODE is "../matlab/input_file.txt";
    variable line_in : line;
    variable read_a : bit_vector(23 downto 0);
    variable read_b : bit_vector(23 downto 0);
    variable space : character;

  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      a <= (others => '0') after tco;
      b <= (others => '0') after tco;      
      sEndSim <= '0' after tco;
    elsif CLK'event and CLK = '1' then --rising clock edge
	    if not endfile(fp_in) then
        readline(fp_in, line_in);
        read(line_in, read_a);
        read(line_in, space);
        read(line_in, read_b);
        a <= to_stdlogicvector(read_a) after tco;
        b <= to_stdlogicvector(read_b) after tco;

        sEndSim <= '0' after tco;
      else        
        sEndSim <= '1' after tco;
      end if;
    end if;
  end process;

  process (CLK, RST_n)
  begin  -- process
    if RST_n = '0' then                 -- asynchronous reset (active low)
      END_SIM_i <= (others => '0') after tco;
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      END_SIM_i(0) <= sEndSim after tco;
      END_SIM_i(1 to 10) <= END_SIM_i(0 to 9) after tco;
    end if;
  end process;

  END_SIM <= END_SIM_i(0);  

end beh;
