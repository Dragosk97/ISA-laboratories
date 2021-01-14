library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decode_stage is
    port (
        -- input
        instruction_ifid : in std_logic_vector(31 downto 0);
        pc_ifid : in std_logic_vector(31 downto 0);
        rd_address_memwb : in std_logic_vector(4 downto 0);
        rd_data_memwb : in signed(31 downto 0);
        clk : in std_logic;
        result_exmem : in signed(31 downto 0);
        result_memwb : in signed(31 downto 0);

        -- output
        target_address : out std_logic_vector(31 downto 0);
        -- IDEX
        rd_address_idex : out std_logic_vector(4 downto 0);
        data1_address_idex : out std_logic_vector(4 downto 0);
        data2_address_idex : out std_logic_vector(4 downto 0);
        data1_idex : out signed(31 downto 0);
        data2_idex : out signed(31 downto 0);
        pc_idex : out std_logic_vector(31 downto 0);
        aluop_idex : out std_logic_vector(1 downto 0);
        funct3_idex : out std_logic_vector(2 downto 0);
    );
end decode_stage;

architecture struct of decode_stage is

    component register_file is   
        port
        (
            write_data    : in signed(31 downto 0);
            RegWrite      : in std_logic;
            read_reg1     : in std_logic_vector(4 downto 0);
            read_reg2     : in std_logic_vector(4 downto 0);
            write_reg     : in std_logic_vector(4 downto 0);
            clk           : in std_logic;
            rst			  : in std_logic;
            read_data1	  : out signed(31 downto 0);
            read_data2	  : out signed(31 downto 0)
        );
end component;

    component Immediate_Generator is 
    port(
        instr_input: in std_logic_vector(31 downto 0);
        immediate_out: out signed(31 downto 0)
        );
    end component;

    component mux3to1 IS
        GENERIC (N: integer:=8);
        PORT (a, b, c: IN signed(N-1 downto 0);
                sel : IN std_logic_vector(1 downto 0);
                m_out : OUT signed(N-1 downto 0));
    end component;

    component mux2to1 is
        GENERIC (n : INTEGER := 47 );
        port
        (
            a: in signed(n-1 downto 0);
            b: in signed(n-1 downto 0);
            s: in std_logic;
            z: out signed(n-1 downto 0)
        );
    end component;
    
    component comparator is
        generic (n : integer := 32);
        port (
            x : in signed(n-1 downto 0);
            y : in signed(n-1 downto 0);
            eq : out std_logic
        );
    end component;

    signal opcode : std_logic_vector(6 downto 0);
    signal funct3 : std_logic_vector(2 downto 0);
    signal funct7 : std_logic_vector(6 downto 0);
    signal rd_address : std_logic_vector(4 downto 0);
    signal data1_address, data2_address : std_logic_vector(31 downto 0);
    signal data1, data2, data1_fwd, data2_fwd : signed(31 downto 0);
    signal RegWrite, rf_rst : std_logic;
    signal clear_idex : std_logic;
    signal immediate : signed(31 downto 0);
    signal mux_fwd_1_sel, mux_fwd_1_sel : std_logic;
    signal branch_decision : std_logic;

begin

    -- Instruction dispatch
    opcode <= instruction_ifid(6 downto 0);
    rd_address <= instruction_ifid(11 downto 7);
    funct3 <= instruction_ifid(14 downto 12);
    data1_address <= instruction_ifid(19 downto 15);
    data2_address <= instruction_ifid(24 downto 20);
    funct7 <= instruction_ifid(31 downto 25);

    -- ID/EX registers
    IDEX_regs: process(clk, clear_idex)
    begin
        if clk'event and clk='1' then
            if clear_idex = '1' then
                funct3_idex <= "000";
                rd_address_idex <= "00000";
                data1_address_idex <= "00000";
                data2_address_idex <= "00000";
                data1_idex <= x"00000";
                data2_idex <= x"00000";
                pc_idex <= x"00000";
                immediate_idex <= x"00000";
            else
                funct3_idex <= funct3;
                rd_address_idex <= rd_address;
                data1_address_idex <= data1_address;
                data2_address_idex <= data2_address;
                data1_idex <= data1_fwd;
                data2_idex <= data2_fwd;
                pc_idex <= pc_ifid;
                immediate_idex <= immediate;
            end if;
        end if;
    end process;

    -- Register File instance
    reg_file : Register_File port map (
        write_data => rd_data_memwb,
        RegWrite => RegWrite,
        read_reg1 => data1_address,
        read_reg2 => data2_address,
        write_reg => rd_address_memwb,
        clk => clk,
        rst => rf_rst,
        read_data1 => data1,
        read_data2 => data2
    );

    -- Immediate Generator instance
    imm_gen : Immediate_Generator port map (
        instr_input => instruction_ifid,
        immediate_out => immediate
    );

    -- Target address computation
    target_address <= std_logic_vector(signed(pc_ifid) + (immediate(30 downto 0) & '0'));
    
    -- Branch Forwarding
    mux_fwd_1 : mux3to1 generic map (32) port map(
        a => data1,
        b => result_memwb,
        c => result_exmem,
        sel => mux_fwd_1_sel,
        m_out => data1_fwd
    );
    mux_fwd_2 : mux3to1 generic map (32) port map(
        a => data2,
        b => result_memwb,
        c => result_exmem,
        sel => mux_fwd_2_sel,
        m_out => data2_fwd
    );

    -- Branch equality unit
    branch_equal_unit : comparator generic map (32) port map (
        x => data1_fwd,
        y => data2_fwd,
        eq => branch_decision
    );
    
end struct ; -- struct