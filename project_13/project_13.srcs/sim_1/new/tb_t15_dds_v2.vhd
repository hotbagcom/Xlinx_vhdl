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
        C_sys_ram_width_bitnum    :integer := 32 ;    --ram width
        C_sys_ram_depth    :integer := 4096           --ram depth    
     );

end tb_t15_dds_v2;

architecture bhvrl_tb_top of tb_t15_dds_v2 is

constant W_point : integer := 1024 ;


signal P_clk : time := 1_000ms / X_clk; -- 1ps
signal clk : std_logic := '1';

    signal C_Wave_freq : integer range 1 to x_clk/10  :=  100_000; 
    
    signal    C_Sin_val     : std_logic_vector(C_sys_ram_width_bitnum-1 downto 0);
    signal    C_Cos_val     : std_logic_vector(C_sys_ram_width_bitnum-1 downto 0) ;
    



component t15_dds_v2 is
  Generic  (
        sys_ram_width_bitnum    :integer ;    --ram width
        sys_ram_depth    :integer           --ram depth    
     );
    Port (
        clk         : in std_logic ;
        reset       : in std_logic :='0' ; 
        Wave_freq   :in integer range 1 to x_clk/10  ; 
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

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= 1_000;

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= 5_000;

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= 10_000;

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= 20_000;

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= 50_000;

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= 75_000;

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= 100_000;

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= 150_000;

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= 200_000;

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= 250_000;

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= 400_000;

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= 500_000;

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= 600_000;

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= 750_000;

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= 800_000;

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= 1_000_000;

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;

assert false 
report "Sým Done"
severity failure;

end process;


end bhvrl_tb_top;
