----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.08.2024 12:44:45
-- Design Name: 
-- Module Name: tb_t15_dds_v2 - bhvrl_tb_top
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
use work.pck_log.all;
use IEEE.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_t15_dds_v2 is
    Generic (
        sys_ram_width_bitnum    :integer := 16 ;    --ram width
        sys_ram_depth    :integer := 2048           --ram depth    
     );
    Port ( 
        C_Sin_val     :out std_logic_vector(sys_ram_width_bitnum-1 downto 0);
        C_Cos_val     :out std_logic_vector(sys_ram_width_bitnum-1 downto 0) 
    );
end tb_t15_dds_v2;

architecture bhvrl_tb_top of tb_t15_dds_v2 is

signal P_clk : time := 1000ms / X_clk; 
signal clk : std_logic := '1';

signal C_Wave_freq :  std_logic_vector(log2(sys_ram_depth)-1 downto 0) := ( x"00000100" );

constant C_sys_ram_width_bitnum : integer := 16 ; 
constant C_sys_ram_depth : integer := 2048 ;


component t15_dds_v2 is
  Generic  (
        sys_ram_width_bitnum    :integer := 16 ;    --ram width
        sys_ram_depth    :integer := 2048           --ram depth    
     );
    Port (
        clk         : in std_logic ;
        reset       : in std_logic :='0' ; 
        Wave_freq   : in std_logic_vector(log2(sys_ram_depth)-1 downto 0);
        Sin_val     :out std_logic_vector(sys_ram_width_bitnum-1 downto 0);
        Cos_val     :out std_logic_vector(sys_ram_width_bitnum-1 downto 0)
     );
end component ;

begin
DUT : t15_dds_v2 
generic map(
    sys_ram_width_bitnum  => C_sys_ram_width_bitnum ,
    sys_ram_depth => C_sys_ram_depth
)
port map(
    clk  => clk ,
    reset => '0' ,
    Wave_freq =>  C_Wave_freq ,
    Sin_val => C_Sin_val ,
    Cos_val => C_Cos_val 
);

STIMULTI : process begin 

clk <= '0';
wait for P_clk;


C_Wave_freq <= x"00200";

for y in 0 to 1024 loop
wait for P_clk;
clk <= '1';
wait for P_clk;
clk <= '0';
end loop;



C_Wave_freq <= x"00080";

for y in 0 to 1024 loop
wait for P_clk;
clk <= '1';
wait for P_clk;
clk <= '0';
end loop;

assert false 
report "Sým Done"
severity failure;

end process;


end bhvrl_tb_top;
