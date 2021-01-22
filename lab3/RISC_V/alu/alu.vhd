Library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity alu is 
port( data_inA : in signed (31 downto 0);
      data_inB : in signed (31 downto 0);
      alu_ctr_input : in std_logic_vector(3 downto 0);
      result : out signed (31 downto 0));
end alu;

architecture behavioural of alu is
begin
    alu_process : process(alu_ctr_input, data_inA, data_inB)
    begin
        case alu_ctr_input is
            when "0010" => result <= data_inA + data_inB;
            when "0000" => result <= data_inA AND data_inB;
            when "0011" => result <= data_inA XOR data_inB;
            when "0001" => result <= shift_right(data_inA, to_integer(data_inB)); --right_shift
            when "0100" => if data_inA < data_inB then
                                result(0) <= '1';
                                result(31 downto 1) <= (others => '0');
                            else
                                result <= (others => '0')  
                            end if ;
            when others => result <= data_inA + data_inB;
        end case;
    end process;
end behavioural;