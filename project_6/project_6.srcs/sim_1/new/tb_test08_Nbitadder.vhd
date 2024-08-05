----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.08.2024 11:10:08
-- Design Name: 
-- Module Name: tb_test08_Nbitadder - Behavioral
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

entity tb_test08_Nbitadder is
    Generic(
        Nbit : integer := 8 
    );
--Port (
--Num0_i      : in std_logic_vector(Nbit-1 downto 0 );
--Num1_i      : in std_logic_vector(Nbit-1 downto 0 );
--Cary_i      : in std_logic ;
--Sum_o       : out std_logic_vector(Nbit-1 downto 0 );
--F_ovflv_o   : out std_logic
--);
end tb_test08_Nbitadder;



architecture TB_NBITADDER of tb_test08_Nbitadder is
--Component decleration
component nbitadder is 
    Generic(
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
signal temp_cary   : std_logic_vector(Nbit downto 0)   := (others => '0');
signal Num0_i      :  std_logic_vector(Nbit-1 downto 0 ):= (others => '0');
signal Num1_i      :  std_logic_vector(Nbit-1 downto 0 ):= (others => '0');
signal Cary_i      :  std_logic := '0' ;
signal Sum_o       :  std_logic_vector(Nbit-1 downto 0 ):= (others => '0');
signal F_ovflv_o   :  std_logic := '0' ;


begin

--Component implementation
--temp_cary(0) <= Cary_i;
--F_ovflv_o <= temp_cary(N);
    DUT : nbitadder
    generic map(
        N => Nbit
    )
    port map(
        temp_cary(0) := Cary_i ,
        a_i => Num0_i,
        b_i => Num1_i,
        c_i => temp_cary(0),
        s_o => Sum_o,
        c_o =>  temp_cary(Nbit)
    );
    
    
    
end NBITADDER;

