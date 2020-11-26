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
generic(nbit : integer)
    port(
        a : in std_logic_vector(nbit-1 downto 0);
        b0 : in std_logic_vector; 
        b1 : in std_logic_vector;
        b2 : in std_logic_vector;
        pp : out std_logic_vector(nbit downto 0)
    );
end component;

type array_mbe IS array (0 to 12) of std_logic_vector (24 downto 0);
SIGNAL mbe_out : array_mbe;

--dadda input preparation
type array_s IS array (0 to 12) of std_logic_vector (28 downto 0);
SIGNAL in_dadda : array_s;

BEGIN
--MBE
mbe_pp0: MBE_n generic map (24) port map(
			a => a,
			b0 => '0',
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
			b1 => '0',
			b2 => '0',
			pp=> mbe_out(12));

--input DADDA
in_dadda(0) <= NOT(b(1)) & b(1) & b(1) & mbe_out(0) & b(1);
 
input_dadda : for i in 1 to 10
	generate
		in_dadda(i) : '1' & NOT(b(2*i+1)) & mbe_out(i) & b(2*i+1);
	end generate;
	
in_dadda(11) <= NOT(b(2*11+1)) & mbe_out(11) & b(2*11+1);
in_dadda(12) <= mbe_out(12) (23 downto 0);

end behavioural; 
