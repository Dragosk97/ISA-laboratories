library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity write_back_stage is
    port (
        wb_mux_sel : in std_logic;
        result_memwb : in signed(31 downto 0);
        result_exmem_out : in signed(31 downto 0)
    );
end write_back_stage;

architecture structural of write_back_stage is

    signal 

begin

end structural ; -- struct