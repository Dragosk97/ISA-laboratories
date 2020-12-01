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

ARCHITECTURE behavioural of MBE_mult IS 

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

type array_mbe IS array (0 to 12) of std_logic_vector (24 downto 0);
SIGNAL mbe_out : array_mbe;

--dadda input preparation
type array_s IS array (0 to 12) of std_logic_vector (28 downto 0);
SIGNAL in_dadda : array_s;

--
type array_int is array (0 to 47) of integer;
type array_stage_int is array (0 to 5) of array_int;

type array_target is array (0 to 5) of integer;

type array_matrix is array (0 to 12) of std_logic_vector(48 downto 0);
type array_stage is array(0 to 5) of array_matrix;
SIGNAL dadda_i : array_stage;
SIGNAL zero : std_logic;

BEGIN
--MBE
zero <= '0';

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

--input DADDA
in_dadda(0) <= NOT(b(1)) & b(1) & b(1) & mbe_out(0) & b(1);
 
input_dadda : for i in 1 to 10
	generate
		in_dadda(i)(27 downto 0) <= '1' & NOT(b(2*i+1)) & mbe_out(i) & b(2*i+1);
	end generate;
	
in_dadda(11)(26 downto 0) <= NOT(b(2*11+1)) & mbe_out(11) & b(2*11+1);
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

--Last row, i = 12

dadda_i(0)(12)(27 downto 24) <= in_dadda(12)(3 downto 0);
dadda_i(0)(12)(22) <= in_dadda(11)(0);

-- column 28 bit lift
dadda_i(0)(11)(28) <= in_dadda(12)(4);

lastrow_lift: for j in 2 to 11 
generate
	
	lastrow_lastcol_lift: if j = 11 generate 
	dadda_i(0)(1)(47) <= in_dadda(12)(23);
	end generate;
	lastrow_midcol_lift: if j < 11 generate
	dadda_i(0)(12-j)(27 + 2*(j-1) + 1 downto 27 + 2*(j-1) ) <= in_dadda(12)(23+2*(-11+j) downto 22+2*(-11+j) );
	end generate;

end generate;

--------------------------------------------------------------------

process(dadda_i)

variable row_num : array_stage_int;
variable diff : integer;
variable num_HA, num_FA, num_unproc : integer;
variable num_carry : integer := 0;
constant row_target : array_target := (13, 9, 6, 4, 3, 2);

begin

	diff := 0;
	num_HA := 0;
	num_FA := 0;
	num_unproc := 0;
	row_num(0) := (2,1,3,2,4,3,5,4,6,5,7,6,8,7,9,8,10,9,11,10,12,11,13,12,13,13,13,13,12,11,11,10,10,9,9,6,6,7,7,6,6,5,5,4,4,3,3,2);

	--Dadda_alg: 
	for stage in 0 to 4 loop
	--generate
	--begin

		--column_elab:
		for col in 0 to 47 loop
		--generate
			--no_reduction:
			if row_num(stage)(col) + num_carry <= row_target(stage+1) then
			--generate
				row_num(stage+1)(col) := row_num(stage)(col);
				num_carry := 0;
			--end generate;
			
			--yes_reduction: 
			else
				-- row_num(stage)(col) + num_carry > row_target(stage+1) then
			--generate
				diff := row_num(stage)(col) + num_carry - row_target(stage+1);	
				num_FA := diff / 2;
				num_HA := diff mod 2;
				num_unproc := row_num(stage)(col) - 3*num_FA - 2*num_HA;
			
				--FA_gen : 
				for i in 0 to num_FA-1 loop
					
				--sum_FA
					dadda_i(stage+1)(i+num_carry)(col) <= dadda_i(stage)(3*i)(col) XOR dadda_i(stage)(3*i+1)(col) XOR dadda_i(stage)(3*i+2)(col);
				--cout_FA
					dadda_i(stage+1)(i)(col+1) <= ((dadda_i(stage)(3*i)(col) XOR dadda_i(stage)(3*i+1)(col)) AND dadda_i(stage)(3*i+2)(col)) OR (dadda_i(stage)(3*i)(col) AND dadda_i(stage)(3*i+1)(col));
				end loop;
			
				--HA_gen : 
				for i in 0 to num_HA-1 loop
				--generate
					-- HA_inst : HA port map(
					-- 	a <= dadda_i(stage)(col)(3*num_FA + 2*i),
					-- 	b <= dadda_i(stage)(col)(3*num_FA + 2*i + 1),
					-- 	s <= dadda_i(stage+1)(col)(num_carry + num_FA + i),
					-- 	cout <= dadda_i(stage+1)(col+1)(num_FA+i)
					-- );
					dadda_i(stage+1)(num_carry + num_FA + i)(col) <= dadda_i(stage)(3*num_FA + 2*i)(col) XOR dadda_i(stage)(3*num_FA + 2*i + 1)(col);
					dadda_i(stage+1)(num_FA+i)(col+1) <= dadda_i(stage)(3*num_FA + 2*i)(col) AND dadda_i(stage)(3*num_FA + 2*i + 1)(col);
				--end generate;
				end loop;

				--Unprocessed_propagation: 
				for i in 0 to num_unproc-1 loop
				--generate
					dadda_i(stage+1)(num_carry + num_FA + num_HA + i)(col) <= dadda_i(stage)(3*num_FA + 2*num_HA + i)(col);
				--end generate;
				end loop;

				row_num(stage+1)(col) := row_num(stage)(col) - 2*num_FA - num_HA + num_carry;
				num_carry := num_FA + num_HA;

			end if;
		end loop;
		num_carry := 0;

	end loop;

end process;

 last_HA : HA port map(
	 dadda_i(5)(0)(0),
	 dadda_i(5)(1)(0),
	 p(0),
	 dadda_i(5)(1)(1)
 );

 p(47 downto 1) <= std_logic_vector(unsigned(dadda_i(5)(0)(47 downto 1)) + unsigned(dadda_i(5)(0)(47 downto 1)));

end behavioural; 
