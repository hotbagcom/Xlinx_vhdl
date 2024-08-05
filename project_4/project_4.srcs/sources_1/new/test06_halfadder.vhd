----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.07.2024 14:57:09
-- Design Name: 
-- Module Name: test06_halfadder - Behavioral
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
entity test06_halfadder is
    Port (
        bit0_i: in std_logic := '1';
        bit1_i : in std_logic := '0';
        sum0_o : out std_logic;
        cary0_o : out std_logic 
     );
end test06_halfadder;

architecture HALFADDER of test06_halfadder is

begin
    out0_o <= bit1_i xor bit0_i;
    cary0_o <= bit1_i and bit0_i;
end HALFADDER ;
