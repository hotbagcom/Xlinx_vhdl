----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.08.2024 15:11:46
-- Design Name: 
-- Module Name: t10_system - Bhvl_system
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

entity t10_system is
    generic(
        Nsw : integer := 16 ;
        Nbit_len : integer := 8
    );
    Port (
        SW : in std_logic_vector(Nsw-1 downto 0);
        BTN: in std_logic ;
        LED: out std_logic_vector(Nbit_len downto 0)
    );
end t10_system;

architecture Bhvl_system of t10_system is

-- COMPONENT DECLERATION
component t10_NA is 
    generic (
        Nbit : integer := 8
    );
    port (
        Num0_i : in std_logic_vector(Nbit-1 downto 0);
        Num1_i : in std_logic_vector(Nbit-1 downto 0);
        Carry_i: in std_logic ;
        Final_o:out std_logic_vector(Nbit-1 downto 0);
        Flag_o :out std_logic 
    );

end component t10_NA ;

begin

-- COMPONENT INSTANTIATION
t10_NA_i : t10_NA
generic map(
    Nbit => Nbit_len 
)
port map(
    Num0_i  =>  SW(Nsw-1 downto Nbit_len),
    Num1_i  =>  SW(Nbit_len-1 downto 0),
    Carry_i =>  BTN,
    Final_o =>  LED(Nbit_len-1 downto 0),
    Flag_o  =>  LED(Nbit_len)
);

end Bhvl_system;
