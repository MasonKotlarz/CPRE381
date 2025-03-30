library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_extender is
    generic(gCLK_HPER  : time := 50 ns);
end tb_extender;

architecture behavior of tb_extender is

    constant cCLK_PER  : time := gCLK_HPER * 2;

    -- Component instantiation
    component extender is
        port (
            i_switch         : in  std_logic;
            i_input          : in  std_logic_vector(16-1 downto 0);
            o_output         : out std_logic_vector(32-1 downto 0)
        );
    end component;

    -- Signals
    signal s_i_Clock   :  std_logic;
    signal s_i_switch   : std_logic;
    signal s_i_input     : std_logic_vector(16-1 downto 0);
    signal s_o_output    : std_logic_vector(32-1 downto 0);
    
begin
    -- Component instantiation
    extender_inst : extender
        port map (
            i_switch          => s_i_switch,
            i_input           => s_i_input,
            o_output          => s_o_output
        );

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
        s_i_switch <= '0'; -- Start with zero extension
        s_i_input <= "0000000000001100"; -- 16-bit input (12)
        wait for cCLK_PER;
        s_i_switch <= '1'; -- Switch to sign extension
        s_i_input <= "1111111111111100"; -- -4 (two's complement)
        wait for cCLK_PER;
        s_i_switch <= '1'; -- Start with sign extension
        s_i_input <= "0000000000001100"; 
        wait for cCLK_PER;
        s_i_switch <= '0'; -- Switch to zero extension
        s_i_input <= "1111111111111100"; 


        wait for cCLK_PER;
    end process;
end behavior;
