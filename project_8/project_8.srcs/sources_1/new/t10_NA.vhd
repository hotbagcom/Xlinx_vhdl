----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.08.2024 15:11:46
-- Design Name: 
-- Module Name: t10_NA - Bhvl_na
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

entity t10_NA is
    generic(
        Nbit : integer := 8
    );
    Port(
        Num0_i : in std_logic_vector(Nbit-1 downto 0);
        Num1_i : in std_logic_vector(Nbit-1 downto 0);
        Carry_i: in std_logic ;
        Final_o:out std_logic_vector(Nbit-1 downto 0);
        Flag_o :out std_logic 
    );
end t10_NA;

architecture Bhvl_na of t10_NA is

component t10_FA is
    port(
        A_i : in std_logic ;
        B_i : in std_logic ;
        C_i : in std_logic ;
        S_o : out std_logic;
        C_o : out std_logic
    );
end component t10_FA;

signal temp_carry : std_logic_vector(Nbit  downto 0 );

begin
temp_carry(0) <= Carry_i ;
Flag_o <= temp_carry(Nbit);

FULL_ADDER_GEN : for k in 0 to Nbit-1
    generate
    t10_FA_i : t10_FA
    port map(
        A_i =>  Num0_i(k) ,
        B_i =>  Num1_i(k) ,
        C_i =>  temp_carry(k) ,
        S_o => Final_o(k)  ,
        C_o => temp_carry(k+1) 
    );
    end generate;

end Bhvl_na;
