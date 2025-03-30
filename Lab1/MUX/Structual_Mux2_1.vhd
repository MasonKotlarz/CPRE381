-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Structual_Mux2_1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a processing
-- element for the systolic matrix-vector multiplication array inspired 
-- by Google's TPU.
--
--
-- NOTES:
-- 1/14/19 by H3::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity Structual_Mux2_1 is

  port(i_D0 		           : in std_logic;
       i_D1 		           : in std_logic;
       i_S 		             : in std_logic;
       o_O                 : out std_logic);

end Structual_Mux2_1;

architecture structure of Structual_Mux2_1 is

  component andg2
    port(i_A             : in std_logic;
         i_B             : in std_logic;
         o_F             : out std_logic);
  end component;

  component org2
    port(i_A             : in std_logic;
         i_B             : in std_logic;
         o_F             : out std_logic);
  end component;

  component invg
    port(i_A             : in std_logic;
         o_F             : out std_logic);
  end component;


  -- Signal to carry not gate
  signal s_S         : std_logic;
  -- Signals to carry the first And gate
  signal s_SaD0      : std_logic;
  -- Signal to carry the Second And gate
  signal s_SaD1        : std_logic;

begin

  ---------------------------------------------------------------------------
  -- Gates Implementation
  ---------------------------------------------------------------------------
  g_Not: invg
    port MAP(i_A              => i_S,
             o_F              => s_S);
  
  g_1stAnd: andg2
    port MAP(i_A               => i_D0,
             i_B               => s_S,
             o_F               => s_SaD0);

  g_2ndAnd: andg2
    port MAP(i_A              => i_S,
             i_B              => i_D1,
             o_F              => s_SaD1);

  g_Or: org2
    port MAP(i_A              => s_SaD0,
             i_B              => s_SaD1,
             o_F              => o_O);
    

  end structure;
