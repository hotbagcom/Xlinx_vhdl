----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.08.2024 15:11:46
-- Design Name: 
-- Module Name: t10_FA - Bhvl_fa
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

entity t10_FA is
    Port (
        A_i : in std_logic ;
        B_i : in std_logic ;
        C_i : in std_logic ;
        S_o : out std_logic;
        C_o : out std_logic
    );
end t10_FA;

architecture Bhvl_fa of t10_FA is

component t10_HA is 
    port(
        Bit0_i : in std_logic ;
        Bit1_i : in std_logic ;
        Carry_o: out std_logic;
        Sum_o  : out std_logic
    );
end component t10_HA;


    signal first_carry  : std_logic ;
    signal second_carry : std_logic ;
    signal first_sum    : std_logic ;
    
begin
    first_HA : t10_HA
    port map(
        Bit0_i  =>  A_i ,
        Bit1_i  =>  B_i ,
        Carry_o =>  first_carry ,
        Sum_o   =>  first_sum
    );
    
    second_HA : t10_HA
    port map(
        Bit0_i  =>  first_sum ,
        Bit1_i  =>  C_i ,
        Carry_o =>  second_carry ,
        Sum_o   =>  S_o
    );
    
    C_o <= first_carry or second_carry ;
end Bhvl_fa;
