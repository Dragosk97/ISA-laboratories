library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fetch_stage is
    port (
        -- Input
        clk : in std_logic;
        rst : in std_logic;
        start_address : in std_logic_vector(31 downto 0);
        target_address : in std_logic_vector(31 downto 0);
        ifid_clear : in std_logic;
        ifid_en : in std_logic;

        -- Input from Decode stage for jump
        is_jump : in std_logic;

        -- Input from Decode stage for Branch correction
        wrong_prediction : in std_logic;
        branch_decision : in std_logic;
        
        -- Input from Decode stage for stall such as Branch Hazards
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
end fetch_stage;

architecture structure of fetch_stage is

    component GenericReg is
        generic(regwidth : integer);
        port(d : in std_logic_vector (regwidth -1 downto 0);
              clk : in std_logic;
              rst: in std_logic;
              en : in std_logic;
              q : out std_logic_vector(regwidth -1 downto 0));
    end component;

    component prediction_table IS
    PORT (  PT_read_address: IN std_logic_vector(3 downto 0);
            PT_write_address: IN std_logic_vector(3 downto 0);
            PT_data: IN std_logic_vector(58 downto 0);
            MemWrite, clock, rst: IN STD_LOGIC;
            Qout: OUT std_logic_vector(58 downto 0));
    END component;

    -- Buffer signals
    signal pc_ifix_buffer : std_logic_vector(31 downto 0);

    -- Prediction Table signals
    signal PT_in, PT_out : std_logic_vector(58 downto 0);
    signal PT_decision : std_logic;
    signal tag : std_logic_vector(25 downto 0);
    signal PT_hit : std_logic;
    signal prediction_ta : std_logic_vector(31 downto 0);
    signal prediction : std_logic;

    -- Program Counter's signals
    signal pc_in, pc : std_logic_vector(31 downto 0);
    signal pc_rst : std_logic;
    signal pc_4 : std_logic_vector(31 downto 0);

    -- Buffer signals
    signal pc_ifid_buffer : std_logic_vector(31 downto 0);

    -- Sequential PC restore regs signals
    signal prev_pc_4 : std_logic_vector(31 downto 0);
    -- signal fixed to '1'
    signal one : std_logic;


begin

    one <= '1';

    -- IF/ID Registers
    IFID_regs : process(clk, rst, ifid_clear, ifid_en)
    begin
        if rst = '1' then
            pc_ifid_buffer <= (others => '0');
            prediction_ifid <= '0';
            prediction_ta_ifid <= (others => '0');
            -- NOP as ADDI x0, x0, 0
            instruction_ifid(31 downto 7) <= (others => '0');
            instruction_ifid(6 downto 0) <= "0010011";

        elsif clk'event and clk = '1' then
            if ifid_clear = '1' then
                pc_ifid_buffer <= (others => '0');
                prediction_ifid <= '0';
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

    -- Buffer output
    pc_ifid <= pc_ifid_buffer;

    -- Program Counter
    pc_reg : GenericReg generic map (32) port map (
        d => pc_in,
        clk => clk,
        rst => pc_rst,
        en => pc_en,
        q => pc
    );

    -- Reset the PC means to load the starting address, therefore the register
    -- reset signal is not used and instead a mux is switched to the proper input.
    pc_rst <= '0';

    -- Prediction Table
    PT : prediction_table port map (
        PT_read_address => pc(5 downto 2),
        PT_write_address => pc_ifid_buffer(5 downto 2),
        PT_data => PT_in,
        MemWrite => wrong_prediction,
        clock => clk,
        rst => rst,
        Qout => PT_out
    );

    -- Prediciton table input concatenation
    PT_in <= pc_ifid_buffer(31 downto 6) & target_address & branch_decision;

    -- Prediction table output dispatch
    PT_decision <= PT_out(0);
    prediction_ta <= PT_out(32 downto 1);
    tag <= PT_out(58 downto 33);

    -- PT hit or miss
    PT_hit <= '1' when tag = pc(31 downto 6) else '0';

    -- The final prediction is given by the decision stored in the
    -- Prediction Table if the tag gave a hit.
    prediction <= PT_hit and PT_decision;


    -- Sequential PC restore register
    prev_pc : GenericReg generic map (32) port map (
        d => pc_4,
        clk => clk,
        rst => rst,
        en => one,
        q => prev_pc_4
    );

    -- Next sequential address
    pc_4 <= std_logic_vector(signed(pc) + 4);

    -- PC's next value
    pc_in <= start_address when rst = '1'
        else target_address when is_jump = '1'
        else target_address when wrong_prediction = '1' and  branch_decision = '1'
        else prev_pc_4 when wrong_prediction = '1' and  branch_decision = '0'
        else prediction_ta when wrong_prediction = '0' and prediction = '1'
        else pc_4;

    instruction_address <= pc;


end structure ; -- structure