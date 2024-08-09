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
        Ram_width_bitsize : integer ;
        Ram_depth_bitsize : integer ;
        Accum_bitsize :integer := 28
     );
    Port (
        clk :in std_logic;
        rst :in std_logic ; 
        w_freq :in std_logic_vector(Ram_depth_bitsize-1 downto 0) := "000001000000";
        addrs : out std_logic_vector(Ram_depth_bitsize-1 downto 0)
     );
end t15_accum;

architecture bhvl_accum of t15_accum is

------- SIGNAL -------
signal accum_value : std_logic_vector( Accum_bitsize - 1 downto 0 ) := (others => '0');

begin


process (clk , rst ) begin 
        if ( rising_edge(clk) and rst= '0' ) then 
            accum_value <= std_logic_vector ( unsigned (accum_value) + unsigned(w_freq) );
        end if ;
        report "inside accum : " &to_string(accum_value) ;
end process  ;

--process (clk , rst  ) begin 
--        if ( falling_edge(clk) and rst= '1' ) then 
--           accum_value <= (others=> '0' ) ;
--           addrs <= (others=> '0' ) ;
--        end if ;
        
--end process  ;

    addrs <= accum_value(Ram_depth_bitsize-1 downto 0);

end bhvl_accum;
