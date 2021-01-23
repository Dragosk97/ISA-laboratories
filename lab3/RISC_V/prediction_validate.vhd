library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity prediction_validate is
    port (
        branch_decision : in std_logic;
        prediction : in std_logic;
        is_branch : in std_logic;

        wrong_prediction : out std_logic;
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
    wrong_prediction <= is_branch and (branch_decision xor prediction);

end behav ; -- behav