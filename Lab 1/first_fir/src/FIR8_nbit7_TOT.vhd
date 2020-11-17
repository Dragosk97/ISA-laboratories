library ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity FIR8_nbit7_TOT is
    port(
        DIN : in signed(7 downto 0);
        VIN : in std_logic;
        rst_n: in std_logic;
        clk: in std_logic;
        b0: in signed(7 downto 0);
        b1: in signed(7 downto 0);
        b2: in signed(7 downto 0);
        b3: in signed(7 downto 0);
        b4: in signed(7 downto 0);
        b5: in signed(7 downto 0);
        b6: in signed(7 downto 0);
        b7: in signed(7 downto 0);
        b8: in signed(7 downto 0);
        
        --output
        DOUT: out signed(7 downto 0);
        VOUT: out std_logic
    );
end FIR8_nbit7_TOT;

architecture structural of FIR8_nbit7_TOT is

component datapath is
  port(
   DIN : in signed(6 downto 0);
   REG_IN_en : in std_logic;
   REG_sample_en : in std_logic;
   REG_coeff_en : in std_logic;
   REG_OUT_en : in std_logic;
   rst_n: in std_logic;
   clk: in std_logic;
   
   b0: in signed(6 downto 0);
   b1: in signed(6 downto 0);
   b2: in signed(6 downto 0);
   b3: in signed(6 downto 0);
   b4: in signed(6 downto 0);
   b5: in signed(6 downto 0);
   b6: in signed(6 downto 0);
   b7: in signed(6 downto 0);
   b8: in signed(6 downto 0);
   
   --output
   DOUT: out signed(6 downto 0)
  );
end component;

component fsm is
    port (
        VIN : in std_logic;
        clk : in std_logic;
        rst_n : in std_logic;
        
        reg_in_en : out std_logic;
        reg_out_en : out std_logic;
        reg_coeff_en : out std_logic;
        reg_sample_en : out std_logic;
      
        reg_rst_n : out std_logic;
        VOUT : out std_logic
    );
end component;

signal reg_in_en, reg_rst_n, reg_sample_en, reg_out_en, reg_coeff_en : std_logic;

begin

datapath_FIR: datapath port map (DIN => DIN(7 downto 1),
                                 REG_IN_en => reg_in_en,
                                 REG_sample_en => reg_sample_en,
                                 REG_coeff_en => reg_coeff_en,
                                 REG_OUT_en => reg_out_en, 
                                 rst_n => reg_rst_n,
                                 clk => clk,
                                 b0 => b0(7 downto 1), 
                                 b1 => b1(7 downto 1),
                                 b2 => b2(7 downto 1),
                                 b3 => b3(7 downto 1),
                                 b4 => b4(7 downto 1),
                                 b5 => b5(7 downto 1),
                                 b6 => b6(7 downto 1),
                                 b7 => b7(7 downto 1),
                                 b8 => b8(7 downto 1),
                                 DOUT => DOUT(7 downto 1));
DOUT(0) <= '0';

control_unit_FIR: fsm port map (VIN => VIN,
                                clk => clk,
                                rst_n => rst_n,
                                reg_in_en => reg_in_en,
                                reg_out_en => reg_out_en,  
                                reg_coeff_en => reg_coeff_en,            
                                reg_sample_en => reg_sample_en, 
                                reg_rst_n => reg_rst_n,
                                VOUT => VOUT);

end structural;
