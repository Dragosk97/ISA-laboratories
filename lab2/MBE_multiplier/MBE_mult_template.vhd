LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity MBE_mult is 
		port(	
				a : IN std_logic_vector (23 downto 0);
				b : IN std_logic_vector (23 downto 0);
				p : OUT std_logic_vector (47 downto 0)	
);
end MBE_mult;

architecture behavioural of MBE_mult is 

	-- In order to compute the partial products, "MBE" units are exploited which
	-- implements the modified booth encoding. These signals are rearranged and
	-- extended in order to have the correct sign extension. The result of this
	-- operation is collected into the array of std_logic_vector "in_dadda". In
	-- particular, each element of this array could have a different number of
	-- bits occupied accordingly to the partial product it is referring to.
	
	-- The internal signals of the Dadda tree are grouped in such a way that a
	-- single instance is exploited with the name dadda_i(x)(y)(z), where:
	-- 		x: indicates the reduction stage;
	-- 		y: indicates the row;
	-- 		z: indicates the column.
	-- It is worth noticing that the signals corresponding to the stage 0 are
	-- the starting partial products matrix from which the reduction has to be
	-- performed. In fact, these signals are driven by properly rearranging the
	-- signals of in_dadda.

	-- The Dadda tree is implemented as a netlist of full adders and half adders
	-- properly positioned accordingly to its algorithm. This is achieved by
	-- exploiting the Python script dadda_algorithm.py which decides whether to
	-- insert a full adder, a half adder or to propagate the bits between two
	-- consecutive stages.

	-- Lastly, a half adder is used to reduce the final adder parallelism, which
	-- is implemented as a behavioural "+" operator.


	-- Component declaration
	component MBE_n is
	generic(nbit : integer);
		port(
			a : in std_logic_vector(nbit-1 downto 0);
			b0 : in std_logic; 
			b1 : in std_logic;
			b2 : in std_logic;
			pp : out std_logic_vector(nbit downto 0)
		);
	end component;

	component HA is
		port (a, b: in std_logic;
				s, cout : out std_logic);
	end component;

	component FA is
		port (a, b, cin : in std_logic;
				s, cout : out std_logic);
	end component;

	-- Signal types and internal signals declarations
	-- MBEs units' output
	type array_mbe is array (0 to 12) of std_logic_vector (24 downto 0);
	signal mbe_out : array_mbe;

	-- Dadda input preparation
	type array_s is array (0 to 12) of std_logic_vector (28 downto 0);
	signal in_dadda : array_s;

	-- Dadda internal signals
	type array_matrix is array (0 to 12) of std_logic_vector(48 downto 0);
	type array_stage is array(0 to 5) of array_matrix;
	signal dadda_i : array_stage;

	-- Signal forced to logic '0'
	signal zero : std_logic;

BEGIN

	zero <= '0';

	--MBE
	mbe_pp0: MBE_n generic map (24) port map(
				a => a,
				b0 => zero,
				b1 => b(0),
				b2 => b(1),
				pp=> mbe_out(0));

	mult_pp: for i in 1 to 11
		generate 
			mult1: MBE_n generic map (24) port map(
				a => a,
				b0 => b(2*i-1),
				b1 => b(2*i),
				b2 => b(2*i+1),
				pp=> mbe_out(i));
		end generate;

	mbe_pp12: MBE_n generic map (24) port map(
				a => a,
				b0 => b(23),
				b1 => zero,
				b2 => zero,
				pp=> mbe_out(12));


	-- Dadda input signals sign extension
	-- First partial products row
	in_dadda(0) <= NOT(b(1)) & b(1) & b(1) & mbe_out(0) & b(1);
	
	-- Middle partial products rows
	input_dadda : for i in 1 to 10
		generate
			in_dadda(i)(27 downto 0) <= '1' & NOT(b(2*i+1)) & mbe_out(i) & b(2*i+1);
		end generate;
		
	-- Second to last partial products row
	in_dadda(11)(26 downto 0) <= NOT(b(2*11+1)) & mbe_out(11) & b(2*11+1);
	-- Last partial products row
	in_dadda(12)(23 downto 0) <= mbe_out(12) (23 downto 0);


	-- Initialization of dadda_i(0)
	-- First row
	dadda_i(0)(0)(27 downto 0) <= in_dadda(0)(28 downto 1);

	-- Middle row
	dadda_init : for i in 1 to 11
	generate
		dadda_i(0)(i)(27 downto 2*i) <= in_dadda(i)(28 -2*i downto 1);
		dadda_i(0)(i)(2*(i-1)) <= in_dadda(i-1)(0);
		
		-- column 28 lifts of one position 
		dadda_i(0)(i-1)(28) <= in_dadda(i)(27 - 2*(i-1));
		
		-- each column lifts as much as possible
		middle_row_lift: for j in 2 to i 
		generate
			last_midcol_lift: if j = 11 generate 
				dadda_i(0)(0)(47) <= in_dadda(11)(26);
			end generate;
			midcol_lift: if j < 11 generate
				dadda_i(0)(i-j)(27 + 2*(j-1) + 1 downto 27 + 2*(j-1) ) <= in_dadda(i)(27+2*(-i+j) downto 26+2*(-i+j));
			end generate;
		end generate;

	end generate;

	-- Last row, i = 12
	dadda_i(0)(12)(27 downto 24) <= in_dadda(12)(3 downto 0);
	dadda_i(0)(12)(22) <= in_dadda(11)(0);

	-- column 28 bit lift
	dadda_i(0)(11)(28) <= in_dadda(12)(4);

	-- each other column lifts as much as possible
	lastrow_lift: for j in 2 to 11 
	generate
		
		lastrow_lastcol_lift: if j = 11 generate 
		dadda_i(0)(1)(47) <= in_dadda(12)(23);
		end generate;
		lastrow_midcol_lift: if j < 11 generate
		dadda_i(0)(12-j)(27 + 2*(j-1) + 1 downto 27 + 2*(j-1) ) <= in_dadda(12)(24+2*(-11+j) downto 23+2*(-11+j));
		end generate;

	end generate;


	--------------------------------------------------------------------
	-- The Python generated netlist follows here:

{{ netlist_str }}

	-- This half adder is needed in order to reduce the final adder parallelism.
	-- It does not introduce any additional delay as it operates in parallel to the
	-- Dadda tree reduction.
	last_HA : HA port map(
		dadda_i(5)(0)(0),
		dadda_i(5)(1)(0),
		p(0),
		dadda_i(5)(1)(1)
	);

	-- Final adder
	p(47 downto 1) <= std_logic_vector(unsigned(dadda_i(5)(0)(47 downto 1)) + unsigned(dadda_i(5)(1)(47 downto 1)));
 
end behavioural; 
