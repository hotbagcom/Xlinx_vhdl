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

    signal C_Wave_freq :  std_logic_vector(log2(C_sys_ram_depth)-1 downto 0) :=   x"006"; 
    
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

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;

C_Wave_freq <= x"008";

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;



C_Wave_freq <= x"00C";

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= x"010";

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= x"020";

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;

C_Wave_freq <= x"030";

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= x"040";

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= x"080";

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= x"0A0";

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;

C_Wave_freq <= x"0C0";

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= x"100";

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;


C_Wave_freq <= x"400";

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;



C_Wave_freq <= x"012";

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;



C_Wave_freq <= x"010";

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;



C_Wave_freq <= x"00E";

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;



C_Wave_freq <= x"00C";

for y in 0 to W_point loop
wait for P_clk/2;
clk <= '1';
wait for P_clk/2;
clk <= '0';
end loop;



C_Wave_freq <= x"008";

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
