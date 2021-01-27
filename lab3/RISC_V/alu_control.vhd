library ieee;
use ieee.std_logic_1164.all;

entity alu_control is
    port (
        aluop   : in std_logic_vector(1 downto 0);
        funct3  : in std_logic_vector(2 downto 0);
        alu_ctrl: out std_logic_vector(3 downto 0));
end alu_control;

architecture behav of alu_control is

begin
    alu_ctrl_gen : process(aluop, funct3)
    begin
        case aluop is
            when "00" =>                              -- I-Type
                case funct3 is
                    when "010" => alu_ctrl <= "0010"; -- LOAD (add)
                    when "111" => alu_ctrl <= "0000"; -- ANDI
                    when "101" => alu_ctrl <= "0001"; -- Shift
                    when "000" => alu_ctrl <= "0010"; -- ADDI
                end case; 
            when "10" =>                              -- R-Type
                case funct3 is
                    when "000" => alu_ctrl <= "0010"; -- ADD
                    when "100" => alu_ctrl <= "0011"; -- XOR
                    when "010" => alu_ctrl <= "0100"; -- SLT, comparison
                    when others => alu_ctrl <= "0010";
                end case;
            when "11" => alu_ctrl <= "0010";
            when others => alu_ctrl <= "0010";
        end case;
    end process;

end behav ; -- behav