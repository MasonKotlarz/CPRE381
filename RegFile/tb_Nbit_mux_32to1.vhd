-------------------------------------------------------------------------
-- Joseph Zambreno
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_Nbit_mux_32to1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the
-- edge-triggered flip-flop with parallel access and reset.
--
--
-- NOTES:
-- 8/19/16 by JAZ::Design created.
-- 11/25/19 by H3:Changed name to avoid name conflict with Quartus
--          primitives.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.my_package.all;

entity tb_Nbit_mux_32to1 is
end tb_Nbit_mux_32to1;

architecture behavior of tb_Nbit_mux_32to1 is

  component Nbit_mux_32to1
    port (
      i_Regs : in t_bus_32x32;
      i_S : in std_logic_vector(5-1 downto 0);
      o_O : out std_logic_vector(32-1 downto 0)
    );
  end component;

  -- Signals for testbench
  signal s_i_Regs : t_bus_32x32;
  signal s_i_S : std_logic_vector(5-1 downto 0);
  signal s_o_O : std_logic_vector(32-1 downto 0);

begin

  DUT: Nbit_mux_32to1 
    port map (
      i_Regs => s_i_Regs,
      i_S => s_i_S,
      o_O => s_o_O
    );
  
  -- Testbench process  
  P_TB: process
  begin
    -- Apply stimulus
    for i in 0 to 31 loop
      s_i_Regs(i) <= std_logic_vector(to_unsigned(i, s_i_Regs(i)'length));  -- Assign unique values to each register
  end loop;

  for j in 0 to 31 loop
      s_i_S <= std_logic_vector(to_unsigned(j, s_i_S'length));  -- Test each select signal
      wait for 10 ns;
  end loop;

  wait;

  end process;
  
end behavior;
