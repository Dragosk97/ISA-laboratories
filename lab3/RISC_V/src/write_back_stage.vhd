library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity write_back_stage is
    port (
        wb_mux_sel_memwb : in std_logic;
        data_memwb : in signed(31 downto 0);
        result_memwb : in signed(31 downto 0);

        rd_data : out signed(31 downto 0));
end write_back_stage;

architecture behavioral of write_back_stage is

begin

    rd_data <= data_memwb when wb_mux_sel_memwb = '0' else result_memwb;

end behavioral ;