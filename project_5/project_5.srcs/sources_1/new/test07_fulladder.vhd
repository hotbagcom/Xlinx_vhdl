----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.07.2024 15:45:24
-- Design Name: 
-- Module Name: test07_fulladder - Behavioral
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

entity test07_fulladder is
    Port(
        a_i : in std_logic ;
        b_i : in std_logic ;
        c_i : in std_logic ;
        s_o : out std_logic ;
        c_o : out std_logic 
    );
end test07_fulladder;

architecture FULLADDER of test07_fulladder is

-- COMPONENT DECLERATION
component halfadder is 
    port(
        bit0_i      : in std_logic ;
        bit1_i      : in std_logic ;
        carry_o     : out std_logic ;
        sum_o       : out std_logic 
    );
end component halfadder;

-- SIGNALS
signal first_carry  : std_logic := '0';
signal first_sum    : std_logic := '0'; 
signal second_carry : std_logic := '0';

begin

-- COMPONENT INSTANTIATION
first_halfadder : halfadder 
port map(
    bit0_i => a_i ,
    bit1_i => b_i ,
    carry_o => first_carry ,
    sum_o => first_sum 
);
second_halfadder : halfadder 
port map(
    bit0_i => first_sum ,
    bit1_i => c_i ,
    carry_o => second_carry ,
    sum_o => s_o 
);

c_o <= first_carry xor second_carry ;


end FULLADDER;
