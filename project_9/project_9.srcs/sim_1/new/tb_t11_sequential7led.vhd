----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.08.2024 16:24:12
-- Design Name: 
-- Module Name: tb_t11_sequential7led - tb_Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


entity tb_t11_sequential7led is
    generic (
    constant Sled_b  : std_logic_vector(7 downto 0) := "00000000"; -- Tamamen kapalý
    constant Sled_0  : std_logic_vector(7 downto 0) := "01111110"; -- Rakam 0
    constant Sled_1  : std_logic_vector(7 downto 0) := "00110000"; -- Rakam 1
    constant Sled_2  : std_logic_vector(7 downto 0) := "01101101"; -- Rakam 2
    constant Sled_3  : std_logic_vector(7 downto 0) := "01111001"; -- Rakam 3
    constant Sled_4  : std_logic_vector(7 downto 0) := "00110011"; -- Rakam 4
    constant Sled_5  : std_logic_vector(7 downto 0) := "01011011"; -- Rakam 5
    constant Sled_6  : std_logic_vector(7 downto 0) := "01011111"; -- Rakam 6
    constant Sled_7  : std_logic_vector(7 downto 0) := "01110000"; -- Rakam 7
    constant Sled_8  : std_logic_vector(7 downto 0) := "01111111"; -- Rakam 8
    constant Sled_9  : std_logic_vector(7 downto 0) := "01111011"; -- Rakam 9
    constant Sled_dp : std_logic_vector(7 downto 0) := "10000000" -- Sadece nokta (dp)
    );
end tb_t11_sequential7led;

architecture tb_Behavioral of tb_t11_sequential7led is
-- CONSTANT
-- dot , top , RU , RD , bottom , LD , LU , middle 
--constant Sled_b : std_logic_vector(7 downto 0) := "00000000";
--constant Sled_0 : std_logic_vector(7 downto 0) := "01111110";
--constant Sled_1 : std_logic_vector(7 downto 0) := "01100000";

component t11_sequential7led is 
    Port( 
        sw  : in std_logic_vector( 1 downto 0 ) := "01";
        counter : out std_logic_vector (7 downto 0)
    );

end component t11_sequential7led ;

-- signal 
signal SW_1 : std_logic_vector(1 downto 0) := "10";
signal COUNTER_1 : std_logic_vector(7 downto 0) :=  Sled_b ;

begin

DUT :  t11_sequential7led 
port map (
    sw => SW_1 ,
    counter => counter_1
);


STIMULI : process begin  
wait for 3 us  ;


SW_1 <= x"11" ;
wait for 3 us  ;


SW_1 <= x"00" ;
wait for 3 us;


SW_1 <= x"01" ;
wait for 3 us;

SW_1 <= x"10" ;
wait for 3 us;

SW_1 <= x"11" ;
wait for 3 us;

SW_1 <= x"01" ;
wait for 3 us;

SW_1 <= x"10" ;
wait for 3 us;



assert false 
report "SIM DONE";
severity failure;
end process

end tb_Behavioral;
