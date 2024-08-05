----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.08.2024 15:13:10
-- Design Name: 
-- Module Name: tb_t10_system - Bhvl_tb_system
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

entity tb_t10_system is
    generic(
        Nsw : integer := 16 ;
        Nbit_len : integer := 8
    );
end tb_t10_system;

architecture Bhvl_tb_system of tb_t10_system is

component t10_system is 
    generic(
        Nsw : integer := 16 ;
        Nbit_len : integer := 8
    );
    port(
        SW : in std_logic_vector(Nsw-1 downto 0);
        BTN: in std_logic ;
        LED: out std_logic_vector(Nbit_len downto 0)
    );
end component t10_system;

signal SW		: std_logic_vector (15 downto 0) := (others => '0');
signal BTNL		: std_logic := '0';
signal LED		: std_logic_vector (8 downto 0);

begin

DUT : t10_system 
generic map(
    Nsw => Nsw,
    Nbit_len => Nbit_len
)
port map(
    SW  => SW,
    BTN => BTNL,
    LED => LED
);

STIMULI : process begin

SW 		<= x"0000";
BTNL	<= '0';

wait for 20 ns;

SW		<= x"1234";
BTNL	<= '1';

wait for 20 ns;
SW		<= x"5412";
BTNL	<= '1';


wait for 20 ns;
SW		<= x"4652";
BTNL	<= '1';

wait for 20 ns;
SW 		<= x"0000";
BTNL	<= '0';

wait for 20 ns;

for i in 0 to 255 loop
	SW(7 downto 0) <= SW(7 downto 0) + 1;
	SW(15 downto 8) <= SW(15 downto 8) + 2;
	BTNL	<= not BTNL;
	wait for 20 ns;
end loop;

for i in 0 to 255 loop
	SW(7 downto 0) <= SW(7 downto 0) - 1;
	SW(15 downto 8) <= SW(15 downto 8) - 2;
	BTNL	<= not BTNL;
	wait for 20 ns;
end loop;

assert false
report "SIM DONE"
severity failure;



end process;




end Bhvl_tb_system;
