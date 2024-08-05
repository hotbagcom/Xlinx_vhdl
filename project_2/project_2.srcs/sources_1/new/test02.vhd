----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.07.2024 15:45:40
-- Design Name: 
-- Module Name: test02 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test02 is
  Port (
  A : in std_logic_vector(7 downto 0);
  B : in std_logic_vector(7 downto 0);
  C : out std_logic);
  
end test02;

architecture Behavioral of test02 is
    
   signal s0 : std_logic_vector (7 downto 0) := x"00" ;
       
begin
    s0 <=  std_logic_vector( unsigned(A) + unsigned(B) ) ;

process (s0) begin
    if( unsigned(s0) <20) then
        C <= '1';
    else
        C <= '0';
    end if;
   
end process;
          
        

end Behavioral;
