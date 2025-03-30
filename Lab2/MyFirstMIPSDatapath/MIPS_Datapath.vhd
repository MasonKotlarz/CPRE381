-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- ALU.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 1/6/20 by H3::Created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.my_package.all;

entity MIPS_Datapath is
    port (
        -- Clock, Reset, and Write Enable
        i_Clock         : in  std_logic;
        i_Reset         : in  std_logic;
        i_WriteEnable   : in  std_logic;

        -- Control signals
        i_nAdd_Sub      : in  std_logic; --Controls Adding or Subtracting
        i_ALUSrc        : in  std_logic; --Controls Immediate Value or Register Value

        -- Register file ports
        i_RegDst        : in  std_logic_vector(4 downto 0); --Register Desination Address
        i_DataIn        : in  std_logic_vector(31 downto 0); --Register Desination Data
        i_RegRs         : in  std_logic_vector(4 downto 0); --Register Source Address
        i_RegRt         : in  std_logic_vector(4 downto 0); --Register Target Addres

        o_DataRs        : out std_logic_vector(31 downto 0); --Register Source Data
        o_DataRt        : out std_logic_vector(31 downto 0); --Register Target Data
        o_ALUOut        : out std_logic_vector(31 downto 0));
end entity MIPS_Datapath;

architecture structural of MIPS_Datapath is


    component RegFile is
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

    component ALU is
        port(
            i_A                 : in std_logic_vector(32-1 downto 0);
            i_B                 : in std_logic_vector(32-1 downto 0);
            i_Imm               : in std_logic_vector(32-1 downto 0);
            i_nAdd_Sub          : in std_logic;
            i_ALU_Src           : in std_logic;
            o_C                 : out std_logic_vector(32-1 downto 0));
    end component;

    signal RegData_Src : std_logic_vector(32-1 downto 0);
    signal RegData_Trg : std_logic_vector(32-1 downto 0);
    signal ALUData : std_logic_vector(32-1 downto 0);

begin

  -- Component Instantiation
    
    -- ALU Instantiation
    ALU_comp : ALU
        port map ( 
            i_A             => RegData_Src,
            i_B             => RegData_Trg,
            i_Imm           => i_DataIn,
            i_nAdd_Sub      => i_nAdd_Sub,
            i_ALU_Src       => i_ALUSrc,
            o_C             => ALUData
        );

    -- Reg Instantiation
    RegFile_comp : RegFile
        port map ( 
            i_ReadAddress1  => i_RegRs,
            i_ReadAddress2  => i_RegRt,
            i_WriteAddress  => i_RegDst,
            i_WriteData     => ALUData,
            i_Clock         => i_Clock,
            i_Reset         => i_Reset,
            i_WriteEnable   => i_WriteEnable,
            o_ReadData1     => RegData_Src,
            o_ReadData2     => RegData_Trg
        );

    -- Output data from register file
    o_DataRs <= RegData_Src;
    o_DataRt <= RegData_Trg;
    o_ALUOut <= ALUData;
end structural;
