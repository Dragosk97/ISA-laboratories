library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Immediate_Generator is 
port(
    instr_input: in std_logic_vector(31 downto 0);
    immediate_out: out signed(31 downto 0)
    );
end entity;

architecture behavioural of Immediate_Generator is
    signal imm: std_logic_vector(31 downto 0);

    begin
        immediate_generation: process(instr_input)
        begin
            --The cases are done using opcode field
            imm <= (others => '0');
            case instr_input(6 downto 0) is 
            --I-type instruction immediate decode
                --Instruction ADDI, ANDI and SRAI using also funct3, which is instr_input(14 downto 12)
                when "0010011" => if instr_input(14 downto 12) = "101" then --SRAI
                                    imm(4 downto 0) <= instr_input(24 downto 20);
                                  else --ADDI and ANDI
                                    imm(11 downto 0) <= instr_input(31 downto 20);
                                    imm(31 downto 12) <= (31 downto 12 => instr_input(31)); --sign extension
                                  end if;
                --Instruction LW
                when "0000011" => imm(11 downto 0) <= instr_input(31 downto 20); 
                                  imm(31 downto 12) <= (31 downto 12 => instr_input(31)); --sign extension
            --S-type
                --Instruction SW
                when "0100011" => imm(11 downto 5) <= instr_input(31 downto 25);
                                  imm(4 downto 0) <= instr_input(11 downto 7);
                                  imm(31 downto 12) <= (31 downto 12 => instr_input(31)); --sign extension
            --B-type
                --Instruction BEQ
                when"1100011" => imm(12) <= instr_input(31);
                                 imm(11) <= instr_input(7);
                                 imm(10 downto 5) <= instr_input(30 downto 25);
                                 imm(4 downto 1) <= instr_input(11 downto 8);
                                 imm(31 downto 13) <= (31 downto 13 => instr_input(31)); --sign extension
            --U-type
                --Instruction AUIPC
                when "0010111" => imm(31 downto 12) <= instr_input(31 downto 12);
                --Instruction LUI
                when "0110111" => imm(31 downto 12) <= instr_input(31 downto 12);

            --J-type
                --Instruction JAL
                when "1101111" => imm(20) <= instr_input(31);
                                  imm(11) <= instr_input(20);
                                  imm(19 downto 12) <= instr_input(19 downto 12);
                                  imm(10 downto 1) <= instr_input(30 downto 21);
                                  imm(31 downto 21) <= (31 downto 21 => instr_input(31)); --sign extension
                when others => 
            end case;
        end process;
        immediate_out <= signed(imm);
        end behavioural;