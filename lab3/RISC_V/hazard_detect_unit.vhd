library ieee;
use ieee.std_logic_1164.all;

entity hazard_detect_unit is
    port (
        rs1_address : in std_logic_vector(4 downto 0);
        rs2_address : in std_logic_vector(4 downto 0);
        rd_address_idex : in std_logic_vector(4 downto 0);
        rd_address_exmem : in std_logic_vector(4 downto 0);
        is_branch : in std_logic;
        is_ex_load : in std_logic;
        is_mem_load : in std_logic;
        is_ex_rd_valid : in std_logic;
        is_rs1_valid : in std_logic;
        is_rs2_valid : in std_logic;
        insert_nop : out std_logic
    );
end hazard_detect_unit;

architecture behav of hazard_detect_unit is

begin

    hazard_detection : process(rs1_address, rs2_address, rd_address_exmem, rd_address_idex, is_branch, is_ex_load, is_mem_load, is_ex_rd_valid, is_rs1_valid, is_rs2_valid)
    begin
        insert_nop <= '0';

        -- Branch hazard
        if is_branch = '1' then
            if rd_address_idex /= "00000" then
                if is_ex_rd_valid = '1' and (rs1_address = rd_address_idex or rs2_address = rd_address_idex) then
                    insert_nop <= '1';
                end if;
            end if;
                
            if rd_address_idex /= "00000" then
                if is_mem_load = '1' and (rs1_address = rd_address_exmem or rs2_address = rd_address_exmem) then
                    insert_nop <= '1';
                end if;
            end if;

        end if;

        -- Load hazard
        if is_ex_load = '1' then

            if is_rs1_valid = '1' and rs1_address = rd_address_idex then
                insert_nop <= '1';
            end if;

            if is_rs2_valid = '1' and rs2_address = rd_address_idex then
                insert_nop <= '1';
            end if;
        end if;
    end process;

end behav ; -- behav