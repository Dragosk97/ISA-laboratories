library ieee;
use ieee.std_logic_1164.all;

entity alu_control is
    port (
        aluop   : in std_logic_vector(1 downto 0);
        funct3  : in std_logic_vector(2 downto 0);
        alu_ctrl: out std_logic_vector(3 downto 0)
    );
end alu_control;

architecture behav of alu_control is

begin
    decode_process : process(aluop, funct3)
    begin
        case alu_op is
            when "00" => alu_ctrl <= "0010";
            when "10" =>
                case funct3 is
                    when "000" => alu_ctrl <= "0010";
                    when "111" => alu_ctrl <= "0000";
                    when "110" => alu_ctrl <= "0001";
                    when others => alu_ctrl <= "0010";
                end case;
            when others => alu_ctrl <= "0010";
        end case;

end behav ; -- behav