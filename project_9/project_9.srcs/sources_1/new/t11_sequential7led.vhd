----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.08.2024 14:31:14
-- Design Name: 
-- Module Name: t11_sequential7led - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity t11_sequential7led is
   
    Port(
        --clk : in std_logic ;
        sw  : in std_logic_vector( 1 downto 0 ) := "11";
        counter : out std_logic_vector (7 downto 0)
    );
end t11_sequential7led;

architecture Behavioral of t11_sequential7led is
--constant
constant        c_clock : integer := 100_000_000 ;
constant        c_clockPeriod : time := 1000ms / c_clock  ;

constant c_timer1nslim : integer := c_clock/100_000 ;
constant c_timer2nslim : integer := 2*c_timer1nslim ;
constant c_timer500pslim : integer := c_timer1nslim/2 ;
constant c_timer250pslim : integer := c_timer1nslim/4 ;

constant Sled_b  : std_logic_vector(7 downto 0) := "00000000";
constant Sled_0  : std_logic_vector(7 downto 0) := "01111110";
constant Sled_1  : std_logic_vector(7 downto 0) := "00110000";
constant Sled_2  : std_logic_vector(7 downto 0) := "01101101";
constant Sled_3  : std_logic_vector(7 downto 0) := "01111001";
constant Sled_4  : std_logic_vector(7 downto 0) := "00110011";
constant Sled_5  : std_logic_vector(7 downto 0) := "01011011";
constant Sled_6  : std_logic_vector(7 downto 0) := "01011111";
constant Sled_7  : std_logic_vector(7 downto 0) := "01110000";
constant Sled_8  : std_logic_vector(7 downto 0) := "01111111";
constant Sled_9  : std_logic_vector(7 downto 0) := "01111011";
constant Sled_dp : std_logic_vector(7 downto 0) := "10000000";
    
--signal
signal timer    : integer range 0 to c_timer2nslim := 0;
signal timerlim : integer range 0 to c_timer2nslim := 0;
signal counter_internal : std_logic_vector(7 downto 0) := (others => '0');

signal  clk : std_logic := '1' ;

begin
    --combinational logic assignment
    timerlim <=     c_timer2nslim when sw= "00"
            else    c_timer1nslim when sw= "01"
            else    c_timer500pslim when sw= "10"
            else    c_timer250pslim;
            
    clk <= not clk after c_clockPeriod /2 ;
            
    process (clk) begin 
    if(rising_edge(clk)) then
        if(timer >= timerlim -1) then
            counter_internal <= counter_internal + 1 ;
            timer <=0 ;
        else 
            timer <= timer +1 ;
        end if;   
    
    end if;

    end process ;

counter <= counter_internal;

end Behavioral;
