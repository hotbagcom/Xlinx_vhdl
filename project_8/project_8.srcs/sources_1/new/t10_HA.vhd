----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.08.2024 15:11:46
-- Design Name: 
-- Module Name: t10_HA - Bhvl_ha
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity t10_HA is
    Port (
        Bit0_i  :in std_logic ;
        Bit1_i  :in std_logic ;
        Carry_o :out std_logic;
        Sum_o   :out std_logic
    );
end t10_HA;

architecture Bhvl_ha of t10_HA is
    
begin
    Carry_o <=  Bit0_i and Bit1_i ;
    Sum_o   <=  Bit0_i xor Bit1_i ;
    
end Bhvl_ha;
