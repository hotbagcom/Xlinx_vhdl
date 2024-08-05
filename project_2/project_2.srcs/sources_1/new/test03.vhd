----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.07.2024 16:12:00
-- Design Name: 
-- Module Name: test03 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test03 is
    Port (
        A : in std_logic_vector( 7 downto 0 ); 
        B : in std_logic_vector( 7 downto 0 );
        C : out std_logic
    
     );
end test03;


architecture Behavioral of test03 is
    signal d  :  unsigned( 7 downto 0 ) := x"00";
    
begin
    d <= unsigned(A) + unsigned(B);
    process (d) begin
        if( d < 20)
        then
            C <= '1';
         else 
            C <= '0';
         end if;
     end process;
end Behavioral;
