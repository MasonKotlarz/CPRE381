library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.my_package.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_ALU is
end tb_ALU;

architecture behavior of tb_ALU is
  constant N : integer := 32;  -- Set N to the desired bit width

  component ALU
    generic ( N : integer := 32 ); -- Pass the same value as the testbench constant
    port(         
        i_A                 : in std_logic_vector(N-1 downto 0);
        i_B                 : in std_logic_vector(N-1 downto 0);
        i_Imm               : in std_logic_vector(N-1 downto 0);
        i_nAdd_Sub          : in std_logic;
        i_ALU_Src           : in std_logic;
        o_C                 : out std_logic_vector(N-1 downto 0));
  end component;

  -- Temporary signals to connect to the decoder component.
    signal s_i_A              : std_logic_vector(N-1 downto 0);
    signal s_i_B              : std_logic_vector(N-1 downto 0);
    signal s_i_Imm            : std_logic_vector(N-1 downto 0);
    signal s_i_nAdd_Sub       : std_logic;
    signal s_i_ALU_Src        : std_logic;
    signal s_o_C              : std_logic_vector(N-1 downto 0);
begin

  DUT: ALU 
    port map(
        i_A                     => s_i_A,
        i_B                     => s_i_B,
        i_Imm                   => s_i_Imm,
        i_nAdd_Sub              => s_i_nAdd_Sub,
        i_ALU_Src               => s_i_ALU_Src,
        o_C                     => s_o_C);

 
  -- Testbench process  
  P_TB: process
  begin
    

    -- Test Case 1
    s_i_A           <= x"00004455";
    s_i_B           <= x"00003322";
    s_i_Imm         <= x"00001100";
    s_i_nAdd_Sub    <= '0';
    s_i_ALU_Src     <= '0';
    wait for 10 ns;
    -- Expected C = A + B;


    -- Test Case 2
    s_i_A           <= x"00004455";
    s_i_B           <= x"00003322";
    s_i_Imm         <= x"00001100";
    s_i_nAdd_Sub    <= '0';
    s_i_ALU_Src     <= '1';
    wait for 10 ns;
    -- Expected C = A + immediate;

    
    -- Test Case 3
    s_i_A           <= x"00004455";
    s_i_B           <= x"00003322";
    s_i_Imm         <= x"00001100";
    s_i_nAdd_Sub    <= '1';
    s_i_ALU_Src     <= '0';
    wait for 10 ns;
    -- Expected C = A - B;

    -- Test Case 4
    s_i_A           <= x"00004455";
    s_i_B           <= x"00003322";
    s_i_Imm         <= x"00001100";
    s_i_nAdd_Sub    <= '1';
    s_i_ALU_Src     <= '1';
    wait for 10 ns;
    -- Expected C = A - immediate;


    
    wait;
  end process;
  
end behavior;
