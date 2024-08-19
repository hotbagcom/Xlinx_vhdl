----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.08.2024 14:47:25
-- Design Name: 
-- Module Name: t16_uart_top - bhvrl_uart_top
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity t16_uart_top is
    Generic(
        c_clk       : integer := 100_000_000;
        c_boudrate  : integer := 115_200;
        c_stopbit   : integer := 2
    );
    Port (
        clk_i           : in std_logic  ;
        din_i           : in std_logic_vector(7 downto 0);
        tx_start_i      : in std_logic  ;
        tx_o            : out std_logic ;
        tx_done_tick_o  : out std_logic 
    );
end t16_uart_top;

architecture bhvrl_uart_top of t16_uart_top is

type states is ( S_IDLE  , S_START , S_DATA , S_STOP );
signal d_state :states := S_IDLE ;


begin

P_MAIN : process (clk_i) begin 
    if rising_edge(clk_i) then
        case d_state is 
            when S_IDLE =>  
                tx_o <= '1';
                tx_done_tick_o <= '0';
                if (tx_start_i = '1' ) then
                    d_state <= S_START;
                end if;
            when S_START=>  
            when S_DATA =>  
            when S_STOP =>  
        end case ;
    end if ;
end process P_MAIN;





end bhvrl_uart_top;
