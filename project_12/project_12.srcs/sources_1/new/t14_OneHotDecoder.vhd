----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.08.2024 09:08:11
-- Design Name: 
-- Module Name: t14_OneHotDecoder - Behavioral
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





-- OneHotDecoder.vhd
-- ----------------------------------------------------
-- Optimal One-Hot to Binary Decoder
-- ----------------------------------------------------
-- (c) ALSE / Bertrand CUZEAU - FPGA.fr
--
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- ---------------------------
Entity t14_OneHotDecoder is
-- ---------------------------
port( Din  : in  std_logic_vector(7 downto 0);
Dout : out std_logic_vector(2 downto 0) );
End entity t14_OneHotDecoder;
-- --------------------------------------
Architecture RTL of t14_OneHotDecoder is
-- --------------------------------------
Begin

process (Din)
variable R : unsigned (Dout'range);
begin
R := (others=>'0');
for i in Din'range loop
if Din(i)='1' then
R := R or to_unsigned(i,R'length);
end if;
end loop;
Dout <= std_logic_vector(R);
end process;

End architecture RTL;