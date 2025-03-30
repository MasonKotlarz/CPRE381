library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_dmem is
    generic(gCLK_HPER  : time := 50 ns);
end tb_dmem;

architecture behavior of tb_dmem is

    constant cCLK_PER  : time := gCLK_HPER * 2;

    -- Component instantiation
    component mem is
        port (
            clk    : in std_logic;
            addr   : in std_logic_vector((10-1) downto 0);
            data   : in std_logic_vector((32-1) downto 0);
            we     : in std_logic := '1';
            q      : out std_logic_vector((32-1) downto 0)
        );
    end component;

    -- Temporary signals to connect to the decoder component.
    signal s_i_Clock   :  std_logic;
    signal s_i_WriteEnable : std_logic;
    signal s_i_addr    :  std_logic_vector(10-1 downto 0);
    signal s_i_data    :  std_logic_vector(32-1 downto 0);
    signal s_o_q       :  std_logic_vector(32-1 downto 0);
    
begin

    -- DUT instantiation
    dmem_inst : mem 
        port map (
            clk => s_i_Clock,
            addr => s_i_addr, 
            data => s_i_data, 
            we => s_i_WriteEnable, 
            q => s_o_q 
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
        
        --(ii) reads the initial 10 values stored in memory
        for i in 0 to 9 loop
            s_i_addr <= std_logic_vector(to_unsigned(i, 10));
            wait for cCLK_PER;
        end loop;
        --(iii) writes those same values back to consecutive locations in memory starting at 0x100 
        for i in 0 to 9 loop
            s_i_WriteEnable <= '1';
            wait for cCLK_PER;
            s_i_addr <= std_logic_vector(to_unsigned(16#100# + i*4, 10));
            s_i_data <= std_logic_vector(to_unsigned(i, s_i_data'length));  -- Set different data value for each iteration
            wait for cCLK_PER;
            s_i_WriteEnable <= '0';
            wait for cCLK_PER;
        end loop;
        --(iv) reads those new values back to ensure they were written properly
        for i in 0 to 9 loop
            s_i_addr <= std_logic_vector(to_unsigned(16#100# + i*4, 10));
            wait for cCLK_PER;
        end loop;


        wait for cCLK_PER;
    end process;
  
end behavior;
