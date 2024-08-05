----------------------------------------------------------------------------------
-- Company: MArmara University
-- Engineer:  Arif
-- 
-- Create Date: 01.08.2024 13:54:27
-- Design Name: 
-- Module Name: test09_Nbitadder_v2 - Behavioral
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



-- not use full








library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;




entity test09_Nbitadder_v2 is
    Generic(
    Nbit : integer := 8 
    );
    Port (
        Sw0_i           : in std_logic_vector(Nbit-1 downto 0 );
        Sw1_i           : in std_logic_vector(Nbit-1 downto 0 );
        BtnC_i          : in std_logic ;
        LedS_o          : out std_logic_vector(Nbit-1 downto 0 );
        LED_ovflv_o     : out std_logic
    );
end test09_Nbitadder_v2;

architecture NBITADDER_v2 of test09_Nbitadder_v2 is

--Component decleration
component nbitadder_v2 is                          --10:30
   generic(
   N : integer := 8
   );
    port(
        a_i : in std_logic_vector(N-1 downto 0 ) ;
        b_i : in std_logic_vector(N-1 downto 0 ) ;
        c_i : in std_logic ;
        s_o : out std_logic_vector(N-1 downto 0 );
        c_o : out std_logic
    );
end component ;
--Signal decleretion
--signal temp_cary : std_logic_vector(N downto 0) := (others => '0');

begin

--Component instantiation
nbitadder_v2_i : nbitadder_v2
    generic map(
       N =>Nbit
    )
    port map(
        a_i => Sw0_i(Nbit-1 downto 0 ) ,
        b_i => Sw1_i(Nbit-1 downto 0 ) ,
        c_i => BtnC_i ,
        s_o => LedS_o(Nbit-1 downto 0 ) ,
        c_o => LED_ovflv_o
    );
    
end NBITADDER_v2;
