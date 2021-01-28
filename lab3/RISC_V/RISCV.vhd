library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RISCV is
    port ( 
        --Input
        clk : in std_logic;
        rst : in std_logic;
        start_address : in std_logic_vector(31 downto 0);
        
        --data memory
        data_mem_in : in signed(31 downto 0);
        data_mem_out: out signed(31 downto 0);
        address_mem_out: out std_logic_vector(31 downto 0);
        MemRead : out std_logic;
        MemLoad : out std_logic;

        --instruction memory
        instruction_in : in std_logic_vector(31 downto 0);
        instruction_address : out std_logic_vector(31 downto 0));
end RISCV;

ARCHITECTURE structural of RISCV is

    component fetch_stage is
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
    end component;

    component decode_stage is
        port (
            -- input
            clk : in std_logic;
            rst : in std_logic;

            -- IF/ID
            instruction_ifid : in std_logic_vector(31 downto 0);
            pc_ifid : in std_logic_vector(31 downto 0);
            prediction_ifid: in std_logic;
            prediction_ta_ifid : in std_logic_vector(31 downto 0);
            
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
            branch_decision : out std_logic;
            is_jump: out std_logic;
            ifid_clear: out std_logic;
            wrong_prediction: out std_logic; 
            pc_en : out std_logic;
            ifid_en : out std_logic;

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
            MemLoad_idex: out std_logic;
            wb_mux_sel_idex: out std_logic;
            immediate_idex: out signed(31 downto 0);
            mux1_PC_sel_idex: out std_logic;
            mux2_imm_sel_idex: out std_logic;
            mux_result_sel_idex : out std_logic_vector(1 downto 0)
        );
    end component;

    component execution_stage IS
	PORT (
          clk:IN std_logic;
          rst:IN std_logic;

          --input ID/EX
          data1_idex, data2_idex: IN signed(31 downto 0);
          wb_mux_sel_idex: IN std_logic;
          MemRead_idex: IN std_logic;
          MemLoad_idex: IN std_logic;
          aluop_idex: IN std_logic_vector(1 downto 0);
          funct3_idex: IN std_logic_vector(2 downto 0); 
          rs1_address_idex: IN std_logic_vector(4 downto 0);
          rs2_address_idex: IN std_logic_vector(4 downto 0);
          rd_address_idex: IN std_logic_vector(4 downto 0);
          mux1_pc_sel_idex: IN std_logic;
          mux2_imm_sel_idex: IN std_logic;
          mux_result_sel_idex: IN std_logic_vector(1 downto 0);
          pc_idex: IN std_logic_vector(31 downto 0);
          immediate_idex: IN signed(31 downto 0);
          RegWrite_idex : IN std_logic;
          
          --input MEM/WB
          rd_address_memwb: IN std_logic_vector(4 downto 0);
          result_memwb: IN signed(31 downto 0);
          RegWrite_memwb: IN std_logic;
          
          -- Output EX/MEM
          data2_fwd_exmem: OUT signed (31 downto 0);
          MemRead_exmem: OUT std_logic;
          MemLoad_exmem: OUT std_logic;
          RegWrite_exmem: OUT std_logic;
          rd_address_exmem: OUT std_logic_vector(4 downto 0);
          result_exmem: OUT signed(31 downto 0);
          wb_exmem: OUT std_logic
          );
END component;

component memory_stage IS
	PORT (
          clk: IN std_logic;
          rst: IN std_logic;

          --input EX/MEM
          result_exmem: IN signed(31 downto 0); 
          data_exmem: IN signed(31 downto 0);
          
          rd_address_exmem: IN std_logic_vector(4 downto 0);
          RegWrite_exmem : in std_logic; --useful fwd
          wb_mux_sel_exmem: IN std_logic;

          --use for memory
          data_mem_in: IN signed(31 downto 0); --out_of_memory
          
          --output to data memory
          data_mem_out: OUT signed(31 downto 0);
          address_mem_out: OUT std_logic_vector(31 downto 0);
          
          --output to WB
          data_memwb: OUT signed(31 downto 0); --out of memory
          result_memwb: OUT signed(31 downto 0); --out of alu
          rd_address_memwb: OUT std_logic_vector(4 downto 0);
          wb_mux_sel_memwb: OUT std_logic;
          RegWrite_memwb: out std_logic);
END component;

component write_back_stage is
    port (
        wb_mux_sel_memwb : in std_logic;
        data_memwb : in signed(31 downto 0);
        result_memwb : in signed(31 downto 0);

        rd_data : out signed(31 downto 0));
end component;


--SIGNAL fetch
SIGNAL target_address : std_logic_vector(31 downto 0);
SIGNAL ifid_clear, ifid_en : std_logic;
SIGNAL is_jump : std_logic;
SIGNAL wrong_prediction : std_logic;
SIGNAL branch_decision : std_logic;
SIGNAL pc_en : std_logic;
SIGNAL pc_ifid : std_logic_vector(31 downto 0);
SIGNAL prediction_ifid : std_logic;
SIGNAL prediction_ta_ifid : std_logic_vector(31 downto 0);
SIGNAL instruction_ifid :  std_logic_vector(31 downto 0);

--SIGNAL decode
-- EX/MEM
SIGNAL rd_address_exmem : std_logic_vector(4 downto 0);
SIGNAL result_exmem : signed(31 downto 0);
SIGNAL MemLoad_exmem : std_logic;
SIGNAL RegWrite_exmem : std_logic;
signal address_mem_out_dummy: std_logic_vector(31 downto 0);
-- MEM/WB
SIGNAL rd_address_memwb : std_logic_vector(4 downto 0);
SIGNAL rd_data : signed(31 downto 0);
SIGNAL RegWrite_memwb : std_logic;
-- ID/EX
SIGNAL rd_address_idex : std_logic_vector(4 downto 0);
SIGNAL rs1_address_idex : std_logic_vector(4 downto 0);
SIGNAL rs2_address_idex : std_logic_vector(4 downto 0);
SIGNAL data1_idex : signed(31 downto 0);
SIGNAL data2_idex : signed(31 downto 0);
SIGNAL pc_idex : std_logic_vector(31 downto 0);
SIGNAL aluop_idex : std_logic_vector(1 downto 0);
SIGNAL funct3_idex : std_logic_vector(2 downto 0);
SIGNAL RegWrite_idex : std_logic;
SIGNAL MemRead_idex : std_logic;
SIGNAL MemLoad_idex: std_logic;
SIGNAL wb_mux_sel_idex: std_logic;
SIGNAL immediate_idex: signed(31 downto 0);
SIGNAL mux1_PC_sel_idex: std_logic;
SIGNAL mux2_imm_sel_idex: std_logic;

--SIGNAL execution
--ID/EX
SIGNAL mux_result_sel_idex : std_logic_vector(1 downto 0);
--EX/MEM
SIGNAL data2_fwd_exmem: signed(31 downto 0); --data signal to memory when STORE
SIGNAL MemRead_exmem: std_logic;
SIGNAL wb_mux_sel_exmem: std_logic;

--MEM/WB
SIGNAL data_memwb: signed(31 downto 0);
SIGNAL wb_mux_sel_memwb: std_logic;
SIGNAL result_memwb : signed(31 downto 0);

begin

MemRead <= MemRead_exmem;
MemLoad <= MemLoad_exmem;

fetch: fetch_stage 
port map ( 
    clk => clk,  
    rst => rst, 
    start_address => start_address,
    target_address => target_address,
    ifid_clear => ifid_clear,
    ifid_en => ifid_en,
    is_jump => is_jump,
    wrong_prediction => wrong_prediction,
    branch_decision => branch_decision,
    pc_en => pc_en,
    instruction_in => instruction_in,
    instruction_address => instruction_address,
    pc_ifid => pc_ifid,
    prediction_ifid => prediction_ifid,
    prediction_ta_ifid => prediction_ta_ifid,
    instruction_ifid => instruction_ifid
);

decode: decode_stage
port map ( 
    clk => clk,
    rst => rst,
    instruction_ifid => instruction_ifid,
    pc_ifid => pc_ifid,
    prediction_ifid => prediction_ifid,
    prediction_ta_ifid => prediction_ta_ifid,
    -- EX/MEM
    rd_address_exmem => rd_address_exmem,
    result_exmem => result_exmem,
    MemLoad_exmem => MemLoad_exmem,
    RegWrite_exmem => RegWrite_exmem,
    -- MEM/WB
    rd_address_memwb => rd_address_memwb,
    result_memwb => rd_data,
    RegWrite_memwb => RegWrite_memwb,
    -- output
    target_address => target_address,
    branch_decision => branch_decision,
    is_jump => is_jump,
    ifid_clear => ifid_clear,
    wrong_prediction => wrong_prediction,
    pc_en => pc_en,
    ifid_en => ifid_en,

    -- IDEX
    rd_address_idex => rd_address_idex, 
    rs1_address_idex => rs1_address_idex,
    rs2_address_idex => rs2_address_idex,
    data1_idex => data1_idex,
    data2_idex => data2_idex,
    pc_idex => pc_idex,
    aluop_idex => aluop_idex,
    funct3_idex => funct3_idex,
    RegWrite_idex => RegWrite_idex,
    MemRead_idex => MemRead_idex,
    MemLoad_idex => MemLoad_idex,
    wb_mux_sel_idex => wb_mux_sel_idex,
    immediate_idex => immediate_idex,
    mux1_PC_sel_idex => mux1_PC_sel_idex,
    mux2_imm_sel_idex => mux2_imm_sel_idex,
    mux_result_sel_idex => mux_result_sel_idex
);

execution: execution_stage
port map ( 
    clk => clk,
    rst => rst,
    --input ID/EX
    data1_idex=> data1_idex,
    data2_idex=> data2_idex,
    wb_mux_sel_idex=> wb_mux_sel_idex,
    MemRead_idex=> MemRead_idex,
    MemLoad_idex=> MemLoad_idex,
    aluop_idex=> aluop_idex,
    funct3_idex=> funct3_idex,
    rs1_address_idex=> rs1_address_idex,
    rs2_address_idex=> rs2_address_idex,
    rd_address_idex=> rd_address_idex,
    mux1_pc_sel_idex=> mux1_pc_sel_idex,
    mux2_imm_sel_idex=> mux2_imm_sel_idex,
    mux_result_sel_idex=> mux_result_sel_idex,
    pc_idex=> pc_idex,
    immediate_idex=> immediate_idex,
    RegWrite_idex=> RegWrite_idex,
    --input MEM/WB
    rd_address_memwb=> rd_address_memwb,
    result_memwb=> rd_data,
    RegWrite_memwb=> RegWrite_memwb,
    -- Output EX/MEM
    data2_fwd_exmem=> data2_fwd_exmem,
    MemRead_exmem=> MemRead_exmem,
    MemLoad_exmem=> MemLoad_exmem,
    RegWrite_exmem=> RegWrite_exmem,
    rd_address_exmem=> rd_address_exmem,
    result_exmem => result_exmem,
    wb_exmem => wb_mux_sel_exmem
);
address_mem_out <= std_logic_vector(result_exmem);
memory: memory_stage
port map ( 
    clk => clk,
    rst => rst,
    --input EX/MEM
    result_exmem=> result_exmem,
    data_exmem=> data2_fwd_exmem,
    rd_address_exmem=> rd_address_exmem,
    RegWrite_exmem=> RegWrite_exmem,
    wb_mux_sel_exmem=> wb_mux_sel_exmem,
    --use for memory
    data_mem_in=> data_mem_in,
    --output to data memory
    data_mem_out=> data_mem_out,
    address_mem_out=> address_mem_out_dummy,
    --output to WB
    data_memwb=> data_memwb,
    result_memwb=> result_memwb,
    rd_address_memwb=> rd_address_memwb,
    wb_mux_sel_memwb=> wb_mux_sel_memwb,
    RegWrite_memwb=> RegWrite_memwb
);

writeback: write_back_stage
port map ( 
    wb_mux_sel_memwb=> wb_mux_sel_memwb,
    data_memwb=> data_memwb,
    result_memwb=> result_memwb,
    rd_data=> rd_data
);
end structural;
