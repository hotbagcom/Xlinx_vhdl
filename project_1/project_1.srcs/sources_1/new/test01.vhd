----------------------------------------------------------------------------------
-- Company: Marmara University
-- Engineer: Arif Yardým
-- 
-- Create Date: 30.07.2024 14:25:09
-- Design Name: Genearal Syntax study
-- Module Name: test01 - Behavioral
-- Project Name: Vivado test 
-- Target Devices: 
-- Tool Versions: V0.1
-- Description: 
-- 
-- Dependencies: None
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--  First give than forget to kind people
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test01 is
    port(
    A : in std_logic ;
    B : in std_logic ;
    Y : out std_logic);
    
end test01;

architecture AndGATE of test01 is
begin

Y  <= A and B ;

 
end AndGATE;
