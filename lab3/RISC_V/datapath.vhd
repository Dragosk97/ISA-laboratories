library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
    port ( 

    );
end datapath;

ARCHITECTURE structural of datapath is

    component fetch_unit is
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
    end component;

    component decode_stage is
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
    end component;

    component execution_stage IS
	PORT (
          --input ID/EX
          data1_idex, data2_idex: IN signed(31 downto 0);
          wb_idex: IN std_logic;
          mem_idex: IN std_logic_vector(1 downto 0);
          aluop_idex: IN std_logic_vector(1 downto 0);
          funct3_idex: IN std_logic_vector(2 downto 0); 
          rs1_address_idex: IN std_logic_vector(4 downto 0);
          rs2_address_idex: IN std_logic_vector(4 downto 0);
          rd_address_idex: IN std_logic_vector(4 downto 0);
          mux1_pc_sel_idex: IN std_logic;
          mux2_imm_sel_idex: IN std_logic;
          mux_result_sel_idex: IN std_logic;
        
          pc_idex: IN std_logic_vector(31 downto 0);
          immediate_idex: IN signed(31 downto 0);

          --input EX/MEM
          rd_address_exmem: IN std_logic_vector(4 downto 0);
          result_exmem: IN signed(31 downto 0);
          exmem_fwd_en: IN std_logic;

          --input MEM/WB
          rd_address_memwb: IN std_logic_vector(4 downto 0);
          result_memwb: IN signed(31 downto 0);
          memwb_fwd_en: IN std_logic;

          --output
          ex_result_out : OUT signed (31 downto 0);
          data2_fwd: OUT signed (31 downto 0);
          rd_address_out: OUT std_logic_vector(4 downto 0);
          wb_exmem: OUT std_logic;
          mem_exmem: OUT std_logic_vector(1 downto 0));
END component;

component memory_stage IS
	PORT (
          --input EX/MEM
          result_exmem: IN signed(31 downto 0); 
          data_exmem: IN signed(31 downto 0);
          
          rd_address_exmem: IN std_logic_vector(4 downto 0);
          RegWrite_exmem : in std_logic; --useful fwd
          wb_mux_sel: IN std_logic;

          --use for memory
          data_mem_in: IN signed(31 downto 0); --out_of_memory
          
          --output to data memory
          data_mem_out: OUT signed(31 downto 0);
          address_mem_out: OUT std_logic_vector(31 downto 0);
          
          --output to WB
          data_memwb: OUT signed(31 downto 0); --out of memory
          result_memwb: OUT signed(31 downto 0); --out of alu
          rd_address_memwb: OUT std_logic_vector(4 downto 0);
          memwb_mux_sel_out: OUT std_logic;
          RegWrite_memwb: out std_logic);
END component;

component write_back_stage is
    port (
        wb_mux_sel : in std_logic;
        data_memwb : in signed(31 downto 0);
        result_memwb : in signed(31 downto 0);

        mux_out : out signed(31 downto 0));
end component;


--SIGNAL

STAGE_fetch: fetch_unit is 
port map ();

begin

end structural;