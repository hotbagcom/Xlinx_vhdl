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
        Mux_in_size : integer := 3 ;
        Accum_bitsize :integer := 28
        
     );
    Port (
        clk :in std_logic;
        rst :in std_logic ;  
        mode_select : in std_logic_vector(Mux_in_size -1 downto 0);
        addrs : out std_logic_vector(Ram_depth_bitsize-1 downto 0)
     );
end t15_accum;

architecture bhvl_accum of t15_accum is

------- SIGNAL -------
signal accum_value : std_logic_vector( Accum_bitsize - 1 downto 0 ) := (others => '0');
signal inc : integer ;
signal w_MODEfreq : integer range 1 to x_clk/2 := 1000000;
begin

FmodsACC :process (mode_select )begin 
    case mode_select is 
        when "000" => w_MODEfreq <= 200000 ;-- report "w_MODEfreq : 200000" ;
        when "001" => w_MODEfreq <= 500000 ;-- report "w_MODEfreq : 500000" ;
        when "010" => w_MODEfreq <= 1000000 ; --report "w_MODEfreq :1000000" ;
        when "011" => w_MODEfreq <= 2000000 ;--report "w_MODEfreq : 200000" ;
        when "100" => w_MODEfreq <= 5000000 ;--report "w_MODEfreq : 5000000" ;
        when "101" => w_MODEfreq <= 10000000 ;--report "w_MODEfreq :10000000" ;
        when "110" => w_MODEfreq <= 15000000 ;--report "w_MODEfreq :15000000" ;
        when "111" => w_MODEfreq <= 20000000 ;--report "w_MODEfreq :20000000" ;
        when others =>w_MODEfreq <= X_clk;
     end case ;           
     
end process ;

PincACCM : process (clk , rst ) begin 
        if ( rising_edge(clk) and rst= '0' ) then 
        
      --    inc <= ( adj_Pinc_byfreq(w_freq ) ) ;
      inc <= ( adj_Pinc_byfreq(w_MODEfreq ) ) ;
            accum_value <= std_logic_vector ( unsigned (accum_value) + ( inc ) );
        end if ;
        report "inside accum : " &to_string(accum_value) ;
end process  ;



--process (clk , rst  ) begin 
--        if ( falling_edge(clk) and rst= '1' ) then 
--           accum_value <= (others=> '0' ) ;
--           addrs <= (others=> '0' ) ;
--        end if ;
        
--end process  ;

   addrs <= accum_value(Accum_bitsize -1 downto Accum_bitsize - Ram_depth_bitsize);
  --    addrs <= accum_value(Ram_depth_bitsize -1  downto 0);
end bhvl_accum;
