-------------------------------------------------------------------------
-- Joseph Zambreno
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- org2.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2-input OR 
-- gate.
--
--
-- NOTES:
-- 8/19/16 by JAZ::Design created.
-- 1/16/19 by H3::Changed name to avoid name conflict with Quartus 
--         primitives.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity org2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_C          : out std_logic);

end org2;

architecture dataflow of org2 is
begin

  o_C <= i_A or i_B;
  
end dataflow;
