library verilog;
use verilog.vl_types.all;
entity RISCV is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start_address   : in     vl_logic_vector(31 downto 0);
        data_mem_in     : in     vl_logic_vector(31 downto 0);
        data_mem_out    : out    vl_logic_vector(31 downto 0);
        address_mem_out : out    vl_logic_vector(31 downto 0);
        MemRead         : out    vl_logic;
        MemLoad         : out    vl_logic;
        instruction_in  : in     vl_logic_vector(31 downto 0);
        instruction_address: out    vl_logic_vector(31 downto 0)
    );
end RISCV;
