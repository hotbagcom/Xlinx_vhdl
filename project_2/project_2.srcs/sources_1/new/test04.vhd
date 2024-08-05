----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.07.2024 16:47:05
-- Design Name: 
-- Module Name: test04 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
--or use 
    use IEEE.STD_LOGIC_ARITH.ALL;
    use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test04 is
    Port (
        X : in std_logic_vector( 7 downto 0);
        Y : in std_logic_vector( 7 downto 0 );
        Z : out  STD_LOGIC
    );
end test04;

architecture Behavioral of test04 is
    signal q : std_logic_vector( 7 downto 0 ) := x"00";
begin 
    q <= X + Y ;
    process (q) begin 
        if(q < 20) then
            Z <= '1';
        else 
            Z <= '0';
        end if ;   
    end process;
end Behavioral;
