-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_Nbit_dffreg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the TPU MAC unit.
--              
-- 01/03/2020 by H3::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
entity tb_Nbit_dffreg is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_Nbit_dffreg;

architecture mixed of tb_Nbit_dffreg is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;
constant N : integer := 32;  -- Set N to the desired bit width

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
component Nbit_dffreg is
  generic ( N : integer := 32 ); -- Pass the same value as the testbench constant    
  port(i_CLK              : in std_logic;
       i_RST              : in std_logic;
       i_WE               : in std_logic;
       i_D                : in std_logic_vector(N-1 downto 0);
       o_Q                : out std_logic_vector(N-1 downto 0));
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

signal s_i_D, s_o_Q : std_logic_vector(N-1 downto 0);
signal s_i_WE : std_logic;

begin

  DUT0: Nbit_dffreg

  generic map ( N => N )

  port map(
            i_CLK               => CLK,
            i_RST               => reset,
            i_WE                => s_i_WE,
            i_D                 => s_i_D,
            o_Q                 => s_o_Q
          );

  
  --This first process is to setup the clock for the test bench
  P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;

  -- This process resets the sequential components of the design.
  -- It is held to be 1 across both the negative and positive edges of the clock
  -- so it works regardless of whether the design uses synchronous (pos or neg edge)
  -- or asynchronous resets.
  P_RST: process
  begin
  	reset <= '0';   
    wait for gCLK_HPER/2;
	reset <= '1';
    wait for gCLK_HPER*2;
	reset <= '0';
	wait;
  end process;  
  
  -- Assign inputs for each test case.
  -- TODO: add test cases as needed.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER/2; -- for waveform clarity, I prefer not to change inputs on clk edges




    wait for gCLK_HPER*2;

    wait;
  end process;

end mixed;
