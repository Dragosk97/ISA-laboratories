library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity write_back_stage is
    port (
        wb_mux_sel : in std_logic;
        result_memwb : in signed(31 downto 0);
        data_memwb : in signed(31 downto 0);

        mux_out : out signed(31 downto 0));
end write_back_stage;

architecture behavioral of write_back_stage is

begin

    mux_out <= result_memwb when wb_mux_sel = '0' else data_memwb;

end behavioral ; -- struct