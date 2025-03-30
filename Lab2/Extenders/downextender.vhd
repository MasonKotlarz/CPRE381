library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity downextender is
    port (
        i_input          : in  std_logic_vector(31 downto 0);
        o_output         : out std_logic_vector(9 downto 0)
    );
end entity downextender;

architecture behavior of downextender is 
    o_output <= i_input(9 downto 0);
begin

end behavior;