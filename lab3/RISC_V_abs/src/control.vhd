LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY control IS
PORT (opcode: IN std_logic_vector(6 downto 0); --Last 7 bits of the instruction
	  RegWrite: out std_logic; --Write signal for the Register File
      is_rs1_valid: out std_logic; --The actual instruction use the filed as rs1?  
      is_rs2_valid:out std_logic; --The actual instruction use the filed as rs2?
      mux1_PC_sel: out std_logic; --Signal for the multiplexer in the EX stage in order to choose as operand 1 the PC or not
      mux2_imm_sel: out std_logic; --Signal for the multiplexer in the EX stage in order to choose as operand 2 the immediate value or not
      mux_result_sel: out std_logic_vector(1 downto 0); -- Signal for the multiplexer in the EX stage at the output of the ALU among ALU_result immediate and PC+4
      aluop: out std_logic_vector(1 downto 0);--control signals for the alu control in order to choose the correct operation inside the ALU
      wb_mux_sel: out std_logic;
      MemRead: out std_logic;
      MemWrite: out std_logic;
      is_jump: out std_logic;
      is_branch: out std_logic
);
END control;

ARCHITECTURE Behavior OF control IS

BEGIN

    PROCESS (opcode(6 downto 0))
    begin
        --The control signal are generated based of specific cases of the opcode, instead of observing all the 7 bits, this method could be disanvatageous if
        -- new instruction will be added in future, so another solution with 'when' is used. Therefore whenever a new instruction will be added, only a new case is needed
 
        --if(opcode(5 downto 2) = "1000") then    --the signal RegWrite should be high for all the instructions except for BEQ and SW
        --    RegWrite <= '0';                      --Observing the opcode of the instructions, only this two instruction is in the format x1000xxx, so it's enought to control this 4 bits
        --else
        --    RegWrite <= '1';
        --end if;                                    
        --
        --if(opcode(4 downto 0) = "10111") then --the signal is_rs1_valid should be asserted for all the instructions except for AUIPC,LUI and JAL
        --is_rs1_valid = '0'                    --AUIPC and LUI has opcode in the format xx10111 JAL has xxx1111
        --elsif opcode(3 downto 0)= "1111" then 
        --    is_rs1_valid = '0'
        --else
        --    is_rs1_valid = '1'
        --end if;
        RegWrite <= '0';
        is_rs1_valid <= '0';
        is_rs2_valid <= '0';
        mux1_PC_sel <= '0';
        mux2_imm_sel <= '0';
        mux_result_sel <= "00";
        aluop <= "00";
        wb_mux_sel <= '1';
        MemRead <= '0';
        MemWrite <= '0';
        is_jump <= '0';
        is_branch <= '0';
        case opcode(6 downto 0) is
                --Instructions ADD XOR SLT
                when "0110011" => RegWrite <= '1';
                                  is_rs1_valid <= '1';
                                  is_rs2_valid <= '1';
                                  mux1_PC_sel <= '0';
                                  mux2_imm_sel <= '0';
                                  mux_result_sel <= "00";
                                  aluop <= "10";
                                  wb_mux_sel <= '1';   
                --Instruction ADDI SRAI ANDI
                when "0010011" => RegWrite <= '1';
                                  is_rs1_valid <= '1';
                                  is_rs2_valid <= '0';
                                  mux1_PC_sel <= '0';
                                  mux2_imm_sel <= '1';
                                  mux_result_sel <= "00";
                                  aluop <= "00";
                                  wb_mux_sel <= '1';
                                  MemRead <= '0';
                                  MemWrite <= '0';
                                        
                --Instruction AUIPC
                when "0010111" =>   RegWrite <= '1';
                                    is_rs1_valid <= '0';
                                    is_rs2_valid <= '0';
                                    mux1_PC_sel <= '1';
                                    mux2_imm_sel <= '1';
                                    mux_result_sel <= "00";
                                    aluop <= "11"; --if the aluop is 11, in the alu control the add operation will be assigned 
                                    wb_mux_sel <= '1';
                --Instruction LUI
                when "0110111" =>   RegWrite <= '1';
                                    is_rs1_valid <= '0';
                                    is_rs2_valid <= '0';
                                    --mux1_PC_sel <= '0'; --it does not use the ALU, so this signal could be not defined
                                    --mux2_imm_sel <= '1'; -- it does not use the ALU, so this signal could be not defined
                                    mux_result_sel <= "01";
                                    --aluop <= "00";  --it does not use the ALU, so the aluop could be not defined
                                    wb_mux_sel <= '1';                            
                --Instruction BEQ
                when "1100011" =>   RegWrite <= '0';
                                    is_rs1_valid <= '1';
                                    is_rs2_valid <= '1';
                                    --mux1_PC_sel <= '0';
                                    --mux2_imm_sel <= '1';
                                    --mux_result_sel <= "00";
                                    --aluop <= "00"; 
                                    is_branch <= '1';               
                --Instruction LW
                when "0000011" =>   RegWrite <= '1';
                                    is_rs1_valid <= '1';
                                    is_rs2_valid <= '0';
                                    mux1_PC_sel <= '0';
                                    mux2_imm_sel <= '1';
                                    mux_result_sel <= "00";
                                    aluop <= "11"; 
                                    wb_mux_sel <= '0';
                                    MemRead <= '1';
                                    MemWrite <= '0';
                --Instruction JAL
                when "1101111" =>   RegWrite <= '1';
                                    is_rs1_valid <= '0';
                                    is_rs2_valid <= '0';
                                    --mux1_PC_sel <= '0';  --The ALU is not used here
                                    --mux2_imm_sel <= '1';
                                    mux_result_sel <= "10";
                                    --aluop <= "00";
                                    wb_mux_sel <= '1';
                                    MemRead <= '0';
                                    MemWrite <= '0'; 
                                    is_jump <= '1';
                --Instruction SW
                when "0100011" =>   RegWrite <= '0';
                                    is_rs1_valid <= '1';
                                    is_rs2_valid <= '1';
                                    mux1_PC_sel <= '0';
                                    mux2_imm_sel <= '1';
                                    mux_result_sel <= "00";
                                    aluop <= "11";
                                    --wb_mux_sel <= "1";
                                    MemRead <= '0';
                                    MemWrite <= '1'; 
            
                when others => 
            end case;
    

    END PROCESS;
    


END Behavior;