-------------------------------------------------------------------------
-- Joseph Zambreno
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_RegFile.vhd
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
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_RegFile is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_RegFile;

architecture behavior of tb_RegFile is

  constant cCLK_PER  : time := gCLK_HPER * 2;

  component RegFile
    port(         
      i_ReadAddress1     : in std_logic_vector(5-1 downto 0);
      i_ReadAddress2     : in std_logic_vector(5-1 downto 0);
      i_WriteAddress     : in std_logic_vector(5-1 downto 0);
      i_WriteData        : in std_logic_vector(32-1 downto 0);
      i_Clock            : in std_logic;
      i_Reset            : in std_logic;
      i_WriteEnable      : in std_logic;
      o_ReadData1        : out std_logic_vector(32-1 downto 0);
      o_ReadData2        : out std_logic_vector(32-1 downto 0));
  end component;

  -- Temporary signals to connect to the decoder component.
    signal s_i_ReadAddress1     : std_logic_vector(5-1 downto 0);
    signal s_i_ReadAddress2     : std_logic_vector(5-1 downto 0);
    signal s_i_WriteAddress     : std_logic_vector(5-1 downto 0);
    signal s_i_WriteData        : std_logic_vector(32-1 downto 0);
    signal s_i_Clock            : std_logic;
    signal s_i_Reset            : std_logic;
    signal s_i_WriteEnable      : std_logic;
    signal s_o_ReadData1        : std_logic_vector(32-1 downto 0);
    signal s_o_ReadData2        : std_logic_vector(32-1 downto 0);
begin

  DUT: RegFile 
    port map(
      i_ReadAddress1     => s_i_ReadAddress1,
      i_ReadAddress2     => s_i_ReadAddress2,
      i_WriteAddress     => s_i_WriteAddress,
      i_WriteData        => s_i_WriteData,
      i_Clock            => s_i_Clock,
      i_Reset            => s_i_Reset,
      i_WriteEnable      => s_i_WriteEnable,
      o_ReadData1        => s_o_ReadData1,
      o_ReadData2        => s_o_ReadData2);
  

  --This first process is to setup the clock for the test bench
  P_CLK: process
  begin
    s_i_Clock <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    s_i_Clock <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;

  P_RST: process
  begin
  	s_i_Reset <= '0';   
    wait for gCLK_HPER/2;
    s_i_Reset <= '1';
    wait for gCLK_HPER*2;
    s_i_Reset <= '0';
	wait;
  end process;  

  -- Testbench process  
  P_TB: process
  begin
    wait for gCLK_HPER*2;

    -- Reset the register file
    s_i_Reset <= '1';
    wait for gCLK_HPER*2;
    s_i_Reset <= '0';

    -- Write values to registers
    s_i_WriteEnable <= '1';
    for i in 0 to 32-1 loop
        s_i_WriteAddress <= std_logic_vector(to_unsigned(i, s_i_WriteAddress'length));
        s_i_WriteData <= std_logic_vector(to_unsigned(i + 1, 32));
        wait for gCLK_HPER*2;
    end loop;
    s_i_WriteEnable <= '0';

    -- Read values from registers
    for i in 0 to 32-1 loop
        s_i_ReadAddress1 <= std_logic_vector(to_unsigned(i, s_i_ReadAddress1'length));
        s_i_ReadAddress2 <= std_logic_vector(to_unsigned((i + 1) mod 32, s_i_ReadAddress2'length));  -- Read from adjacent registers
        wait for gCLK_HPER*2;
    end loop;

    wait for gCLK_HPER*2;
    wait;
  end process;
  
end behavior;
