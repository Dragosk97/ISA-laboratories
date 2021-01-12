library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_alu is
end entity;

architecture beh of tb_alu is

    component alu_control is
        port (
            aluop   : in std_logic_vector(1 downto 0);
            funct3  : in std_logic_vector(2 downto 0);
            alu_ctrl: out std_logic_vector(3 downto 0)
        );
    end component;

    component alu is 
    port( data_inA : in signed (31 downto 0);
          data_inB : in signed (31 downto 0);
          alu_ctr_input : in std_logic_vector(3 downto 0);
          result : out signed (31 downto 0));
    end component;

    signal aluop : std_logic_vector(1 downto 0);
    signal funct3 : std_logic_vector(2 downto 0);
    signal alu_ctrl : std_logic_vector(3 downto 0); 
    signal data_A, data_B : signed(31 downto 0);
    signal result : signed (31 downto 0);
    
begin

    alu_dut : alu port map (data_A, data_B, alu_ctrl, result);
    alu_op_dut : alu_control port map (aluop, funct3, alu_ctrl);

    data_gen : process is
    begin
        data_A <= "10101010101000000111000000010011";
        data_B <= "10101010101000000111000000010011";
        aluop <= "10";
        funct3 <= "000";
        wait for 100 ns;
        data_A <= "11111111111111111111111111111111";
        wait for 100 ns;
        funct3 <= "000";
        wait for 100 ns;
        funct3 <= "100";
        wait;
    end process;
    
end beh;