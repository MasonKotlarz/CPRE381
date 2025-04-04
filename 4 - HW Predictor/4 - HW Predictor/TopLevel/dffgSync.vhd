-------------------------------------------------------------------------
-- Joseph Zambreno
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- dffg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an edge-triggered
-- flip-flop with parallel access and reset.
--
--
-- NOTES:
-- 8/19/16 by JAZ::Design created.
-- 11/25/19 by H3:Changed name to avoid name conflict with Quartus
--          primitives.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity dffgSync is

  port(i_CLK        : in std_logic;     -- Clock input
       i_FSH        : in std_logic;     -- Reset input
       i_STL        : in std_logic;     -- Stall input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output

end dffgSync;

architecture mixed of dffgSync is
  signal s_D    : std_logic;    -- Multiplexed input to the FF
  signal s_Q    : std_logic;    -- Output of the FF

  signal s_WRITE : std_logic := '0';    -- Write Enable

begin

  -- The output of the FF is fixed to s_Q
  o_Q <= s_Q;

  s_WRITE <= (not i_FSH) and (not i_STL);
  
  -- Create a multiplexed input to the FF based on i_WE
  with s_WRITE select
    s_D <= i_D when '1',
           s_Q when others;
  
  -- This process handles the asyncrhonous reset and
  -- synchronous write. We want to be able to reset 
  -- our processor's registers so that we minimize
  -- glitchy behavior on startup.
  process (i_CLK, i_FSH)
  begin
    
    if (rising_edge(i_CLK)) then
      if (i_FSH = '1') then
        s_Q <= '0'; -- Use "(others => '0')" for N-bit values
      else 
        s_Q <= s_D;
      end if;
    end if;
      
  end process;
  
end mixed;
