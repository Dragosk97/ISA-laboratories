library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fetch_unit is
    port (
        -- Input
        clk : in std_logic;
        rst : in std_logic;
        start_address : in std_logic_vector(31 downto 0);
        
        -- Input from Decode stage for Branch correction
        wrong_prediction : in std_logic;
        branch_decision : in std_logic;
        target_address : in std_logic_vector(31 downto 0);

        -- Input from Decode stage for stall as Branch Hazards
        pc_en : in std_logic;

        -- Input from Instruction Memory
        instruction_in : in std_logic_vector(31 downto 0);

        -- Output to Instruction Memory
        instruction_address : out std_logic_vector(31 downto 0);
        
        -- IF/ID
        pc_ifid : out std_logic_vector(31 downto 0);
        prediction_ifid : out std_logic;
        prediction_ta_ifid : out std_logic_vector(31 downto 0);
        instruction_ifid : out std_logic_vector(31 downto 0)
    );
end fetch_unit;

architecture structure of fetch_unit is

    component GenericReg is
        generic(regwidth : integer);
        port(d : in signed (regwidth -1 downto 0);
              clk : in std_logic;
              rst: in std_logic;
              en : in std_logic;
              q : out signed (regwidth -1 downto 0));
    end component;

    component prediction_table IS
    PORT (  PT_read_address: IN std_logic_vector(3 downto 0);
            PT_write_address: IN std_logic_vector(3 downto 0);
            PT_data: IN std_logic_vector(32 downto 0);
            MemWrite, MemRead, clock, rst: IN STD_LOGIC;
            Qout: OUT std_logic_vector(32 downto 0));
    END component;
    
    PT : prediction_table port map (
        PT_read_address <= pc(3 downto 0),
        PT_write_address <= pc_ifid_buffer,
        PT_data <= target_address,
        MemWrite <= wrong_prediction,
        MemRead <= is_branch,
        clock <= clk,
        rst <= rst,
        Qout <= PT_out
    );

    signal PT_out : std_logic_vector(32 downto 0);
    signal prediction : std_logic;
    signal prediction_ta : std_logic_vector(31 downto 0);

    -- Program Counter's signals
    signal pc_in, pc : std_logic_vector(31 downto 0);
    signal pc_rst : std_logic_vector(31 downto 0);
        
    signal pc_4 : std_logic_vector(31 downto 0);
    -- signal fixed to '1'
    signal one : std_logic;
begin

    IFID_regs : process(clk, ifid_en)
    begin
        if clk'event and clk = '1' then
            if ifid_clear = '1' then
                pc_ifid_buffer <= (others => '0');
                prediction_ifid <= (others => '0');
                prediction_ta_ifid <= (others => '0');
                -- NOP as ADDI x0, x0, 0
                instruction_ifid(31 downto 7) <= (others => '0');
                instruction_ifid(6 downto 0) <= "0010011";
            
            elsif ifid_en = '1' then
                pc_ifid_buffer <= pc;
                prediction_ifid <= prediction;
                prediction_ta_ifid <= prediction_ta;
                instruction_ifid <= instruction_in;
            end if;
        end if;
    end process;
    
    pc_ifid <= pc_ifid_buffer;

    -- Program Counter
    pc : GenericReg generic map (32) port map (
        d <= pc_in,
        clk <= clk,
        rst <= pc_rst,
        en <= pc_en,
        q <= pc
    );

    -- Reset the PC means to load the starting address, therefore the register
    -- reset signal is not used and instead a mux is switched to the proper input.
    pc_rst <= '0';

    -- Sequential PC restore register
    prev_pc : GenericReg generic map (32) port map (
        d <= pc_4,
        clk <= clk,
        rst <= rst,
        en <= one,
        q <= prev_pc_4
    );

    -- Next sequential address
    pc_4 <= std_logic_vector(signed(pc) + 4);

    -- PC's next value
    pc_in <= start_address when rst <= '0'
        else target_address when wrong_prediction = '1' and  branch_decision = '1'
        else prev_pc_4 when wrong_prediction = '1' and  branch_decision = '0'
        else prediction_ta when wrong_prediction = '0' and prediction = '1'
        else pc_4;

    instruction_address <= pc;


    

end structure ; -- structure