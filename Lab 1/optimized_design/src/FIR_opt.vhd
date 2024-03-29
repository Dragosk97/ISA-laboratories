library ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity FIR_opt is
	port(
		DIN1 : in signed(7 downto 0);
		DIN2 : in signed(7 downto 0);
		DIN3 : in signed(7 downto 0);
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
      DOUT1: out signed(7 downto 0);
		DOUT2: out signed(7 downto 0);
		DOUT3: out signed(7 downto 0);
      VOUT: out std_logic
    );
end FIR_opt;

architecture structural of FIR_opt is

   component datapath_opt is
		port(
			DIN1 : in signed(6 downto 0);
			DIN2 : in signed(6 downto 0);
			DIN3 : in signed(6 downto 0);
			REG_IN_en : in std_logic;
			REG_sample_en : in std_logic;
			reg_coeff_en : in std_logic;
			REG_OUT_en : in std_logic;
			counter_en : in std_logic;
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
			DOUT1: out signed(6 downto 0);
			DOUT2: out signed(6 downto 0);
			DOUT3: out signed(6 downto 0);
			TC: out std_logic
		);
   end component;

   component fsm_opt is
      port (
          VIN : in std_logic;
          clk : in std_logic;
          rst_n : in std_logic;
          tc : in std_logic;
          reg_rst_n : out std_logic;
          reg_in_en : out std_logic;
          reg_coeff_en : out std_logic;
          reg_out_en : out std_logic;
          reg_sample_en : out std_logic;
          counter_en : out std_logic;
          VOUT : out std_logic
      );
   end component;

   -- Interconnection signals
   signal REG_IN_en, REG_rst_n, REG_OUT_en, REG_sample_en, reg_coeff_en : std_logic;
   signal tc, counter_en : std_logic;

begin

   datapath : datapath_opt port map (
      DIN1 => DIN1(7 downto 1),
      DIN2 => DIN2(7 downto 1),
      DIN3 => DIN3(7 downto 1),
      REG_IN_en => REG_IN_en,
      reg_coeff_en => reg_coeff_en,
      REG_sample_en => REG_sample_en,
      REG_OUT_en => REG_OUT_en,
      counter_en => counter_en,
      rst_n => REG_rst_n,
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

      DOUT1 => DOUT1(7 downto 1),
      DOUT2 => DOUT2(7 downto 1),
      DOUT3 => DOUT3(7 downto 1),
      TC => tc
   );

   -- Output extension to 8-bit parallelism
   DOUT1(0) <= '0';
   DOUT2(0) <= '0';
   DOUT3(0) <= '0';

   controlunit : fsm_opt port map(
      VIN => VIN,
      clk => clk,
      rst_n => rst_n,
      tc => tc,
      reg_rst_n => REG_rst_n,
      reg_in_en => REG_IN_en,
      reg_coeff_en => reg_coeff_en,
      reg_out_en => REG_OUT_en,
      reg_sample_en => REG_sample_en,
      counter_en => counter_en,
      VOUT => VOUT
   );

end structural;
