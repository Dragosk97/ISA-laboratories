--Squadra C04
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux4to1 IS
	GENERIC (N: integer:=8);
	PORT (a, b, c, d: IN std_logic_vector(N-1 downto 0);
			sel : IN std_logic_vector(1 downto 0);
			m_out : OUT std_logic_vector(N-1 downto 0));
END mux4to1;

ARCHITECTURE LogicFunction OF mux4to1 IS
BEGIN

	m_out <= a when sel="00" else
				b when sel="01" else
				c when sel="10" else
				d;
		  
END LogicFunction;