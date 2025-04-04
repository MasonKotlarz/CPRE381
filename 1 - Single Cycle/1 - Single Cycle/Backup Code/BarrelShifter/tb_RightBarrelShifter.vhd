-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_TPU_MV_Element.vhd
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
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tb_RightBarrelShifter is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_RightBarrelShifter;

architecture mixed of tb_RightBarrelShifter is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component RightBarrelShifter is
   generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
   port(i_signed      : in std_logic;
        i_WD          : in std_logic_vector(N-1 downto 0);
        i_SHAMT       : in std_logic_vector(4 downto 0);
        o_numShifted  : out std_logic_vector(N-1 downto 0));

end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK : std_logic := '0';

-- TODO: change input and output signals as needed.
signal s_WD         : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal s_SHAMT      : std_logic_vector(4 downto 0)  := "00000";
signal s_signed     : std_logic := '0';
signal s_numShifted : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";

begin

  -- TODO: Actually instantiate the component to test and wire all signals to the corresponding
  -- input or output. Note that DUT0 is just the name of the instance that can be seen 
  -- during simulation. What follows DUT0 is the entity name that will be used to find
  -- the appropriate library component during simulation loading.
  DUT0: RightBarrelShifter
  port map(i_signed         => s_signed,
           i_WD             => s_WD,
           i_SHAMT          => s_SHAMT,
           o_numShifted     => s_numShifted);
  --You can also do the above port map in one line using the below format: http://www.ics.uci.edu/~jmoorkan/vhdlref/compinst.html

  
  --This first process is to setup the clock for the test bench
  P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;
  
  -- Assign inputs for each test case.
  -- TODO: add test cases as needed.
  P_TEST_CASES: process
  begin
    wait for gCLK_HPER/2; -- for waveform clarity, I prefer not to change inputs on clk edges

    -- Test case 1: SRL
    s_WD        <= "00000000000000000000000000001111";
    s_signed    <= '0';
    s_SHAMT     <= "00001";
    wait for gCLK_HPER*2;
    -- Expect: s_numShifted = 0x00000007

    -- Test case 2: SRL
    s_WD        <= "00000000000000000000000011111111";
    s_signed    <= '0';
    s_SHAMT     <= "00100";
    wait for gCLK_HPER*2;
    -- Expect: s_numShifted = 0x0000000F

    -- Test case 3: SRA
    s_WD        <= "10100000000000000000000011111111";
    s_signed    <= '1';
    s_SHAMT     <= "00100";
    wait for gCLK_HPER*2;
    -- Expect: s_numShifted = 0xFA00000F

    -- Test case 4: SRA
    s_WD        <= "00100000000000000000000011111111";
    s_signed    <= '1';
    s_SHAMT     <= "00100";
    wait for gCLK_HPER*2;
    -- Expect: s_numShifted = 0x0200000F

    -- Test case 5: SRL
    s_WD        <= "10100000000000000000000011111111";
    s_signed    <= '0';
    s_SHAMT     <= "00100";
    wait for gCLK_HPER*2;
    -- Expect: s_numShifted = 0x0A00000F

    -- Test case 5: SRL
    s_WD        <= "10100000000000000000000011111111";
    s_signed    <= '0';
    s_SHAMT     <= "11111";
    wait for gCLK_HPER*2;
    -- Expect: s_numShifted = 0x00000000

    wait;
  end process;

end mixed;
