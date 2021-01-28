library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture struct of testbench is

    component RISCV is
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
    end component;

    component data_memory IS
        port (address: IN std_logic_vector(31 downto 0);
            data: IN signed(31 downto 0);
            MemWrite, MemRead, clock, cs, rst: IN STD_LOGIC;
            Qout: OUT signed(31 downto 0));
    end component;

    component instruction_memory is
        port ( address : in std_logic_vector(31 downto 0);
               data : out std_logic_vector(31 downto 0) );
    end component;

    component clk_gen is
        port (
          CLK: out std_logic;
          start_address: out std_logic_vector(31 downto 0);
          RST  : out std_logic);
    end component;

    signal clk, rst, one : std_logic;
    signal start_address : std_logic_vector(31 downto 0);
    signal data_mem_write, data_mem_read : signed(31 downto 0);
    signal address_data_mem : std_logic_vector(31 downto 0);
    signal MemRead, MemLoad : std_logic;
    signal instruction_read : std_logic_vector(31 downto 0);
    signal instruction_address : std_logic_vector(31 downto 0);

begin

    one <= '1';

    DUT : RISCV port map (
        clk => clk,
        rst => rst,
        start_address => start_address,
        data_mem_in => data_mem_write,
        data_mem_out => data_mem_read,
        address_mem_out => address_data_memn
        MemRead => MemRead,
        MemLoad => MemLoad,
        instruction_in => instruction_read,
        instruction_address => instruction_address
    );

    DM : data_memory port map (
        address => address_data_mem,
        data => data_mem_write,
        MemWrite => MemWrite,
        MemRead => MemRead,
        clock => clk,
        cs => one,
        rst => rst,
        Qout => data_mem_read
    );

    IM : instruction_memory port map (
        address => instruction_address,
        data => instruction_read
    );

end struct ; -- struct