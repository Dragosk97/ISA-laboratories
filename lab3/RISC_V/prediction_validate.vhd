library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity prediction_validate is
    port (
        is_branch : in std_logic;
        branch_decision : in std_logic;
        prediction : in std_logic;
        target_address : in std_logic_vector(31 downto 0);
        prediction_ta : in std_logic_vector(31 downto 0);
        wrong_prediction : out std_logic
    );
end prediction_validate;

architecture behav of prediction_validate is
    -- The signal is_branch is '1' if the instruction currently being decoded is
    -- a branch, otherwise it is '0'.
    -- The signal branch_decision is logic '1' when the current branch instruction
    -- has resulted into a "taken" decision, otherwise it is '0'.
    -- The signal prediction follows the same convention, but indicates what was
    -- decided by the branch prediction. 
    -- The prediction is wrong when it is different than the actual decision
    -- produced by the branch instruction.
begin
    
    wrong_prediction <= '1' when is_branch = '1' and (branch_decision /= prediction or (branch_decision = '1' and prediction_ta /= target_address))
        else '0';
end behav ; -- behav