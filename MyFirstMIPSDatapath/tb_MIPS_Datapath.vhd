library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.my_package.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_MIPS_Datapath is
    generic(gCLK_HPER   : time := 50 ns);
end tb_MIPS_Datapath;

architecture behavior of tb_MIPS_Datapath is

    constant cCLK_PER  : time := gCLK_HPER * 2;
  
    component MIPS_Datapath
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
    end component;


    -- Temporary signals to connect to the decoder component.
    -- Clock, Reset, and Write Enable
    signal s_i_Clock         :  std_logic;
    signal s_i_Reset         :  std_logic;
    signal s_i_WriteEnable   :  std_logic;

    -- Control signals
    signal s_i_nAdd_Sub      :  std_logic; --Controls Adding or Subtracting
    signal s_i_ALUSrc        :  std_logic; --Controls Immediate Value or Register Value

    -- Register file ports
    signal s_i_RegDst        :  std_logic_vector(4 downto 0); --Register Desination Address
    signal s_i_DataIn        :  std_logic_vector(31 downto 0); --Register Desination Data
    signal s_i_RegRs         :  std_logic_vector(4 downto 0); --Register Source Address
    signal s_i_RegRt         :  std_logic_vector(4 downto 0); --Register Target Addres

    signal s_o_DataRs        :  std_logic_vector(31 downto 0); --Register Source Data
    signal s_o_DataRt        :  std_logic_vector(31 downto 0); --Register Target Data
    signal s_o_ALUOut        :  std_logic_vector(31 downto 0);
begin

  DUT: MIPS_Datapath 
    port map(
        i_Clock         => s_i_Clock,
        i_Reset         => s_i_Reset,
        i_WriteEnable   => s_i_WriteEnable,

        -- Control signals
        i_nAdd_Sub      => s_i_nAdd_Sub,
        i_ALUSrc        => s_i_ALUSrc,

        -- Register file ports
        i_RegDst        => s_i_RegDst,
        i_DataIn        => s_i_DataIn,
        i_RegRs         => s_i_RegRs,
        i_RegRt         => s_i_RegRt,

        o_DataRs        => s_o_DataRs,
        o_DataRt        => s_o_DataRt,
        o_ALUOut        => s_o_ALUOut);
  
    P_CLK: process
    begin
        s_i_Clock <= '0';
        wait for cCLK_PER;
        s_i_Clock <= '1';
        wait for cCLK_PER;
    end process;
 
    -- Testbench process  
    P_TB: process
    begin

        wait for cCLK_PER;
        s_i_Reset <= '1';
        wait for cCLK_PER;
        s_i_Reset <= '0';
        wait for cCLK_PER;
        
        s_i_WriteEnable <= '1';

           -- Test Case 1: addi $1, $0, 1    # Place "1" in $1
        s_i_nAdd_Sub      <= '0';
        s_i_ALUSrc        <= '1';
        s_i_DataIn        <= x"00000001";
        s_i_RegDst        <= "00001";
        s_i_RegRs         <= "00000";
        s_i_RegRt         <= "00000";
        wait for cCLK_PER;

        -- Test Case 2: addi $2, $0, 2    # Place "2" in $2
        s_i_nAdd_Sub      <= '0';
        s_i_ALUSrc        <= '1';
        s_i_DataIn        <= x"00000002";
        s_i_RegDst        <= "00010";
        s_i_RegRs         <= "00000";
        s_i_RegRt         <= "00000";
        wait for cCLK_PER;

        -- Test Case 3: addi $3, $0, 3    # Place "3" in $3
        s_i_nAdd_Sub      <= '0';
        s_i_ALUSrc        <= '1';
        s_i_DataIn        <= x"00000003";
        s_i_RegDst        <= "00011";
        s_i_RegRs         <= "00000";
        s_i_RegRt         <= "00000";
        wait for cCLK_PER;

        -- Test Case 4: addi $4, $0, 4    # Place "4" in $4
        s_i_nAdd_Sub      <= '0';
        s_i_ALUSrc        <= '1';
        s_i_DataIn        <= x"00000004";
        s_i_RegDst        <= "00100";
        s_i_RegRs         <= "00000";
        s_i_RegRt         <= "00000";
        wait for cCLK_PER;

        -- Test Case 5: addi $5, $0, 5    # Place "5" in $5
        s_i_nAdd_Sub      <= '0';
        s_i_ALUSrc        <= '1';
        s_i_DataIn        <= x"00000005";
        s_i_RegDst        <= "00101";
        s_i_RegRs         <= "00000";
        s_i_RegRt         <= "00000";
        wait for cCLK_PER;

        -- Test Case 6: addi $6, $0, 6    # Place "6" in $6
        s_i_nAdd_Sub      <= '0';
        s_i_ALUSrc        <= '1';
        s_i_DataIn        <= x"00000006";
        s_i_RegDst        <= "00110";
        s_i_RegRs         <= "00000";
        s_i_RegRt         <= "00000";
        wait for cCLK_PER;

        -- Test Case 7: addi $7, $0, 7    # Place "7" in $7
        s_i_nAdd_Sub      <= '0';
        s_i_ALUSrc        <= '1';
        s_i_DataIn        <= x"00000007";
        s_i_RegDst        <= "00111";
        s_i_RegRs         <= "00000";
        s_i_RegRt         <= "00000";
        wait for cCLK_PER;

        -- Test Case 8: addi $8, $0, 8    # Place "8" in $8
        s_i_nAdd_Sub      <= '0';
        s_i_ALUSrc        <= '1';
        s_i_DataIn        <= x"00000008";
        s_i_RegDst        <= "01000";
        s_i_RegRs         <= "00000";
        s_i_RegRt         <= "00000";
        wait for cCLK_PER;

        -- Test Case 9: addi $9, $0, 9    # Place "9" in $9
        s_i_nAdd_Sub      <= '0';
        s_i_ALUSrc        <= '1';
        s_i_DataIn        <= x"00000009";
        s_i_RegDst        <= "01001";
        s_i_RegRs         <= "00000";
        s_i_RegRt         <= "00000";
        wait for cCLK_PER;

        -- Test Case 10: addi $10, $0, 10    # Place "10" in $10
        s_i_nAdd_Sub      <= '0';
        s_i_ALUSrc        <= '1';
        s_i_DataIn        <= x"0000000A";
        s_i_RegDst        <= "01010";
        s_i_RegRs         <= "00000";
        s_i_RegRt         <= "00000";
        wait for cCLK_PER;

        -- Test Case 11: add $11, $1, $2    # $11 = $1 + $2
        s_i_nAdd_Sub      <= '0';
        s_i_ALUSrc        <= '0';
        s_i_DataIn        <= x"00000000";
        s_i_RegDst        <= "01011";
        s_i_RegRs         <= "00001";  -- $1
        s_i_RegRt         <= "00010";  -- $2
        wait for cCLK_PER;

        -- Test Case 12: sub $12, $11, $3    # $12 = $11 - $3
        s_i_nAdd_Sub      <= '1';
        s_i_ALUSrc        <= '0';
        s_i_DataIn        <= x"00000000";
        s_i_RegDst        <= "01100";  -- $12
        s_i_RegRs         <= "01011";  -- $11
        s_i_RegRt         <= "00011";  -- $3
        wait for cCLK_PER;

        -- Test Case 13: add $13, $12, $4    # $13 = $12 + $4
        s_i_nAdd_Sub      <= '0';
        s_i_ALUSrc        <= '0';
        s_i_DataIn        <= x"00000000";
        s_i_RegDst        <= "01101";  -- $13
        s_i_RegRs         <= "01100";  -- $12
        s_i_RegRt         <= "00100";  -- $4
        wait for cCLK_PER;

        -- Test Case 14: sub $14, $13, $5    # $14 = $13 - $5
        s_i_nAdd_Sub      <= '1';
        s_i_ALUSrc        <= '0';
        s_i_DataIn        <= x"00000000";
        s_i_RegDst        <= "01110";  -- $14
        s_i_RegRs         <= "01101";  -- $13
        s_i_RegRt         <= "00101";  -- $5
        wait for cCLK_PER;

        -- Test Case 15: add $15, $14, $6    # $15 = $14 + $6
        s_i_nAdd_Sub      <= '0';
        s_i_ALUSrc        <= '0';
        s_i_DataIn        <= x"00000000";
        s_i_RegDst        <= "01111";  -- $15
        s_i_RegRs         <= "01110";  -- $14
        s_i_RegRt         <= "00110";  -- $6
        wait for cCLK_PER;

        -- Test Case 16: sub $16, $15, $7    # $16 = $15 - $7
        s_i_nAdd_Sub      <= '1';
        s_i_ALUSrc        <= '0';
        s_i_DataIn        <= x"00000000";
        s_i_RegDst        <= "10000";  -- $16
        s_i_RegRs         <= "01111";  -- $15
        s_i_RegRt         <= "00111";  -- $7
        wait for cCLK_PER;

        -- Test Case 17: add $17, $16, $8    # $17 = $16 + $8
        s_i_nAdd_Sub      <= '0';
        s_i_ALUSrc        <= '0';
        s_i_DataIn        <= x"00000000";
        s_i_RegDst        <= "10001";  -- $17
        s_i_RegRs         <= "10000";  -- $16
        s_i_RegRt         <= "01000";  -- $8
        wait for cCLK_PER;

        -- Test Case 18: sub $18, $17, $9    # $18 = $17 - $9
        s_i_nAdd_Sub      <= '1';
        s_i_ALUSrc        <= '0';
        s_i_DataIn        <= x"00000000";
        s_i_RegDst        <= "10010";  -- $18
        s_i_RegRs         <= "10001";  -- $17
        s_i_RegRt         <= "01001";  -- $9
        wait for cCLK_PER;

        -- Test Case 19: add $19, $18, $10    # $19 = $18 + $10
        s_i_nAdd_Sub      <= '0';
        s_i_ALUSrc        <= '0';
        s_i_DataIn        <= x"00000000";
        s_i_RegDst        <= "10011";  -- $19
        s_i_RegRs         <= "10010";  -- $18
        s_i_RegRt         <= "01010";  -- $10
        wait for cCLK_PER;

        -- Test Case 20: addi $20, $0, -35    # Place "-35" in $20
        s_i_nAdd_Sub      <= '0';
        s_i_ALUSrc        <= '1';
        s_i_DataIn        <= x"FFFFFFDD";
        s_i_RegDst        <= "10100";  -- $20
        s_i_RegRs         <= "00000";  -- $0
        s_i_RegRt         <= "00000";  -- $0
        wait for cCLK_PER;

        -- Test Case 21: add $21, $19, $20    # $21 = $19 + $20
        s_i_nAdd_Sub      <= '0';
        s_i_ALUSrc        <= '0';
        s_i_DataIn        <= x"00000000";
        s_i_RegDst        <= "10101";  -- $21
        s_i_RegRs         <= "10011";  -- $19 
        s_i_RegRt         <= "10100";  -- $20
        wait for cCLK_PER;
    
        wait;
    end process;
  
end behavior;
