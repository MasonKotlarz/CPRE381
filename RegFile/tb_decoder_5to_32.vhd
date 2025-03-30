-------------------------------------------------------------------------
-- Joseph Zambreno
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_decoder_5to32.vhd
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

entity tb_decoder_5to32 is
end tb_decoder_5to32;

architecture behavior of tb_decoder_5to32 is

  component decoder_5to32
    port(i_D          : in std_logic_vector(5-1 downto 0);
         o_Q          : out std_logic_vector(32-1 downto 0));
  end component;

  -- Temporary signals to connect to the decoder component.
  signal s_i_D : std_logic_vector(5-1 downto 0);
  signal s_o_Q : std_logic_vector(32-1 downto 0);

begin

  DUT: decoder_5to32 
  port map(i_D => s_i_D, 
           o_Q => s_o_Q);
  
  -- Testbench process  
  P_TB: process
  begin
    for i in 0 to 2**5-1 loop
      s_i_D <= std_logic_vector(to_unsigned(i, s_i_D'length));
      wait for 10 ns;
    end loop;
  end process;
  
end behavior;
