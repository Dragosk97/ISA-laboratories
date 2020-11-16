library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm is
    port (
        VIN : in std_logic;
        clk : in std_logic;
        rst_n : in std_logic;

        reg_rst_n : out std_logic;
        reg_in_en : out std_logic;
        reg_out_en : out std_logic;
        reg_sample_en : out std_logic;
        
        VOUT : out std_logic
    );
end entity;

architecture behavioural of fsm is

    type state_type is (reset, idle, wait_state, exec, exec_cont);
    signal present_state, next_state : state_type;

	 begin
	 
 		   state_assignment_proc : process(clk, rst_n)
			begin
				if rst_n = '0' then
							present_state <= reset;
				elsif rising_edge(clk) then 
							present_state <= next_state;
				end if;
			end process;
			
        output_gen : process(present_state)
        begin
            reg_rst_n <= '1';
            reg_in_en <= '1';
            reg_out_en <= '0';
            reg_sample_en <= '0';
            VOUT <= '0';

            case present_state is
                when reset =>   reg_rst_n <= '0';
                                reg_in_en <= '0';
                                reg_out_en <= '0';
                                reg_sample_en <= '0';
										  
                when idle =>    reg_sample_en <= '0';
                                reg_out_en <= '0';
										  
                when exec =>    reg_sample_en <= '1';
                                reg_out_en <= '1';
										  
                when exec_cont => reg_out_en <= '1';
                                  reg_sample_en <= '1';
                                  VOUT <= '1';
											 
                when wait_state => VOUT <= '1';
				   
					 when others => --default signal assigments
            end case;
        end process;

    next_state_proc : process(present_state, VIN)
    begin
   
            case present_state is
                when reset =>   next_state <= idle;
                when idle =>    if VIN = '0' then
                                    next_state <= idle;
                                else
                                    next_state <= exec;
                                end if;
                when exec =>    if VIN = '1' then
                                    next_state <= exec_cont;
                                else
                                    next_state <= wait_state;
                                end if;
                when exec_cont => if VIN = '1' then
                                    next_state <= exec_cont;
                                else
                                    next_state <= wait_state;
                                end if;
                when wait_state =>    if VIN = '1' then
                                    next_state <= exec;
                                else
                                    next_state <= idle;
                                end if;
					 when others => next_state <= reset;	
            end case;
       end process;
end behavioural;
