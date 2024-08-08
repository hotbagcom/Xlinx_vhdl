----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.08.2024 16:18:56
-- Design Name: 
-- Module Name: t15_accum - bhvl_accum
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

use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity t15_accum is
    Generic (   
        Ram_width_bitsize : integer := 16;
        Ram_depth_bitsize : integer := 11;
        Accum_bitsize :integer := 28
     );
    Port (
        clk :in std_logic;
        rst :in std_logic ; 
        w_freq :in std_logic_vector(Ram_depth_bitsize-1 downto 0);
        addrs : out std_logic_vector(Ram_depth_bitsize-1 downto 0)
     );
end t15_accum;

architecture bhvl_accum of t15_accum is

------- CONSTANT -------

------- VARIABLE -------

------- SIGNAL -------
signal accum_value : std_logic_vector( Accum_bitsize - 1 downto 0 ) := (others => '0');

begin



process (clk , rst ) 
begin 
    
    if rising_edge(clk) then -- todo clk or rst
        if (rst= '1' ) then
           accum_value <= (others=> '0' ) ;
           addrs <= (others=> '0' ) ;
        else--if  (rst= '0' ) then
            accum_value <= std_logic_vector ( unsigned (accum_value) + unsigned(w_freq) );
        end if ;
    end if ;
    addrs <= accum_value(Ram_depth_bitsize-1 downto 0);
   
end process  ;


end bhvl_accum;
