library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_sink is
  port (
    CLK   : in std_logic;
   -- RST_n : in std_logic;
    DIN   : in std_logic_vector(24 downto 0));
end data_sink;

architecture beh of data_sink is
	
begin  -- beh
	
  process (CLK) --, RST_n)
    file res_fp : text open WRITE_MODE is "./mbe_out.txt";
    variable line_out : line;
	  variable count : integer := 0;
    constant N_samples : integer := 10;
    begin  -- process
   -- if RST_n = '0' then                 -- asynchronous reset (active low)
   --  null;
    if CLK'event and CLK = '1' then  -- rising clock edge
      count := count + 1;
    	if count < (N_samples + 1)) then
        hwrite(line_out, DIN);
        writeline(res_fp, line_out);
    	end if;
    end if;
  end process;

end beh;
