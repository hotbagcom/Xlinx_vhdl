----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.07.2024 18:13:09
-- Design Name: 
-- Module Name: test08_Nbitadder - Behavioral
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

--not usefull










library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test08_Nbitadder is
    Generic(
    N : integer := 8 
    );
    Port (
        Num0_i      : in std_logic_vector(N-1 downto 0 );
        Num1_i      : in std_logic_vector(N-1 downto 0 );
        Cary_i      : in std_logic ;
        Sum_o       : out std_logic_vector(N-1 downto 0 );
        F_ovflv_o   : out std_logic
    );
end test08_Nbitadder;

architecture NBITADDER of test08_Nbitadder is

--Component decleration
component fulladder is 
    port(
        a_i : in std_logic ;
        b_i : in std_logic ;
        c_i : in std_logic ;
        s_o : out std_logic;
        c_o : out std_logic
    );
end component ;
--Signal decleretion
signal temp_cary : std_logic_vector(N downto 0) := (others => '0');

begin

temp_cary(0) <= Cary_i;
F_ovflv_o <= temp_cary(N);

FULL_ADDER_GEN: for k in 0 to N-1 generate
    full_adder_k : fulladder
    port map(
        a_i => Num0_i(k),
        b_i => Num1_i(k),
        c_i => temp_cary(k),
        s_o => Sum_o(k),
        c_o =>  temp_cary(k+1)
    );
    end generate;
    
end NBITADDER;
