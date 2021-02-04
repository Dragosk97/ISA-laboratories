Library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity forwarding_unit is 
port( rs1_address_idex: IN std_logic_vector(4 downto 0);
      rs2_address_idex: IN std_logic_vector(4 downto 0);
      rd_address_exmem: IN std_logic_vector(4 downto 0);
      rd_address_memwb: IN std_logic_vector(4 downto 0);
      exmem_fwd_en:IN std_logic;
      memwb_fwd_en:IN std_logic;
      mux1_fwd, mux2_fwd: OUT std_logic_vector(1 downto 0));
end forwarding_unit;

architecture behavioural of forwarding_unit is
begin
    alu_process : process(rs1_address_idex,rs2_address_idex,rd_address_exmem,rd_address_memwb, memwb_fwd_en,exmem_fwd_en)
    
    begin
    mux1_fwd <= "00";
    mux2_fwd <= "00";    
        if memwb_fwd_en = '1' then
            if rs1_address_idex = rd_address_memwb then
                mux1_fwd <= "01";
            end if;
            if rs2_address_idex = rd_address_memwb then
                mux2_fwd <= "01";
            end if;     
        end if;

        if exmem_fwd_en = '1' then 
            if rs1_address_idex = rd_address_exmem then
                mux1_fwd <= "10";
            end if;

            if rs2_address_idex = rd_address_exmem then
                mux2_fwd <= "10";
            end if;
        end if;
                            
    end process;
end behavioural;