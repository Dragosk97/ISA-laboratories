library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decode_stage is
    port (
        -- input
        clk : in std_logic;
        
        -- IF/ID
        instruction_ifid : in std_logic_vector(31 downto 0);
        pc_ifid : in std_logic_vector(31 downto 0);
        
        -- EX/MEM
        rd_address_exmem : in std_logic_vector(4 downto 0);
        result_exmem : in signed(31 downto 0);
        MemLoad_exmem : in std_logic;
        RegWrite_exmem : in std_logic;

        -- MEM/WB
        rd_address_memwb : in std_logic_vector(4 downto 0);
        result_memwb : in signed(31 downto 0);
        RegWrite_memwb : in std_logic;

        -- output
        target_address : out std_logic_vector(31 downto 0);
        
        -- IDEX
        rd_address_idex : out std_logic_vector(4 downto 0);
        rs1_address_idex : out std_logic_vector(4 downto 0);
        rs2_address_idex : out std_logic_vector(4 downto 0);
        data1_idex : out signed(31 downto 0);
        data2_idex : out signed(31 downto 0);
        pc_idex : out std_logic_vector(31 downto 0);
        aluop_idex : out std_logic_vector(1 downto 0);
        funct3_idex : out std_logic_vector(2 downto 0);
        RegWrite_idex : out std_logic;
        MemRead_idex : out std_logic;
        MemLoad_idex: out std_logic
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

    component forwarding_unit is 
    port( rs1_address_idex: IN std_logic_vector(4 downto 0);
          rs2_address_idex: IN std_logic_vector(4 downto 0);
          rd_address_exmem: IN std_logic_vector(4 downto 0);
          rd_address_memwb: IN std_logic_vector(4 downto 0);
          exmem_fwd_en:IN std_logic;
          memwb_fwd_en:IN std_logic;
          mux1_fwd, mux2_fwd: OUT std_logic_vector(1 downto 0));
    end component;

    component hazard_detect_unit is
        port (
            rs1_address : in std_logic_vector(4 downto 0);
            rs2_address : in std_logic_vector(4 downto 0);
            rd_address_idex : in std_logic_vector(4 downto 0);
            rd_address_exmem : in std_logic_vector(4 downto 0);
            is_branch : in std_logic;
            is_ex_load : in std_logic;
            is_mem_load : in std_logic;
            is_ex_rd_valid : in std_logic;
            is_rs1_valid : in std_logic;
            is_rs2_valid : in std_logic;
            insert_nop : out std_logic
        );
    end component;
    
    -- instruction dispatch signal
    signal opcode : std_logic_vector(6 downto 0);
    signal funct3 : std_logic_vector(2 downto 0);
    signal funct7 : std_logic_vector(6 downto 0);
    signal rd_address : std_logic_vector(4 downto 0);
    signal rs1_address, rs2_address : std_logic_vector(31 downto 0);
    
    -- data signal
    signal data1, data2, data1_fwd, data2_fwd : signed(31 downto 0);
    signal immediate : signed(31 downto 0);
    
    -- control signals
    signal RegWrite, rf_rst : std_logic;
    signal MemLoad, MemWrite : std_logic;
    signal clear_idex : std_logic;
    signal mux_fwd_1_sel, mux_fwd_1_sel : std_logic_vector(1 downto 0);
    signal branch_decision : std_logic;
    
    -- internal flag signals
    signal is_branch, is_rs1_valid, is_rs2_valid : std_logic;
    signal insert_nop : std_logic;

    -- Buffer signals
    signal MemLoad_idex_buff, RegWrite_idex_buff : std_logic;
    signal rd_address_idex_buff : std_logic_vector(4 downto 0);

begin

    -- Instruction dispatch
    opcode <= instruction_ifid(6 downto 0);
    rd_address <= instruction_ifid(11 downto 7);
    funct3 <= instruction_ifid(14 downto 12);
    rs1_address <= instruction_ifid(19 downto 15);
    rs2_address <= instruction_ifid(24 downto 20);
    funct7 <= instruction_ifid(31 downto 25);

    -- ID/EX registers
    IDEX_regs: process(clk, clear_idex)
    begin
        if clk'event and clk='1' then
            if clear_idex = '1' then
                funct3_idex <= "000";
                rd_address_idex_buff <= "00000";
                rs1_address_idex <= "00000";
                rs2_address_idex <= "00000";
                data1_idex <= x"00000";
                data2_idex <= x"00000";
                pc_idex <= x"00000";
                immediate_idex <= x"00000";
                RegWrite_idex_buff <= '0';
                MemLoad_idex_buff <= '0';

            else
                funct3_idex <= funct3;
                rd_address_idex_buff <= rd_address;
                rs1_address_idex <= rs1_address;
                rs2_address_idex <= rs2_address;
                data1_idex <= data1_fwd;
                data2_idex <= data2_fwd;
                pc_idex <= pc_ifid;
                immediate_idex <= immediate;
                RegWrite_idex_buff <= RegWrite;
                MemLoad_idex_buff <= MemLoad;
            end if;
        end if;
    end process;

    -- Buffer output
    MemLoad_idex <= MemLoad_idex_buff;
    RegWrite_idex <= RegWrite_idex_buff;
    rd_address_idex <= rd_address_idex_buff;

    -- Register File instance
    reg_file : Register_File port map (
        write_data => rd_data_memwb,
        RegWrite => RegWrite,
        read_reg1 => rs1_address,
        read_reg2 => rs2_address,
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
    branch_equal_unit : comparator generic map (32) port map(
        x => data1_fwd,
        y => data2_fwd,
        eq => branch_decision
    );
    
    -- Hazard detection unit
    hazard_det_unit : hazard_detect_unit port map(
        rs1_address => rs1_address,
        rs2_address => rs2_address,
        rd_address_idex => rd_address_idex_buff,
        rd_address_exmem => rd_address_exmem,
        is_branch => is_branch,
        is_ex_load => MemLoad_idex_buff,
        is_mem_load => MemLoad_exmem,
        is_ex_rd_valid => RegWrite_idex_buff,
        is_rs1_valid => is_rs1_valid,
        is_rs2_valid => is_rs2_valid,
        insert_nop => insert_nop
    );

    -- Branch Forwarding unit
    branch_fwd_unit : forwarding_unit port map(
        rs1_address_idex => rs1_address,
        rs2_address_idex => rs2_address,
        rd_address_exmem => rd_address_exmem,
        rd_address_memwb => rd_address_memwb,
        exmem_fwd_en => RegWrite_exmem,
        memwb_fwd_en => RegWrite_memwb,
        mux1_fwd => mux_fwd_1_sel,
        mux2_fwd => mux_fwd_2_sel
    )
end struct ; -- struct