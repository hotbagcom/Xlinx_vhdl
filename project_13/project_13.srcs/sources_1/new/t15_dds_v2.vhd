----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.08.2024 10:31:15
-- Design Name: 
-- Module Name: t15_dds_v2 - top_bhvral
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
-- TODO fill logarithm package 
use work.pck_log.all;

use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity t15_dds_v2 is
    Generic (
        sys_ram_width_bitnum    :integer := 16 ;    --ram width
        sys_ram_depth    :integer := 2048           --ram depth    
     );
    Port (
        clk         : in std_logic ;
        reset       : in std_logic ; 
        Wave_freq   : in std_logic_vector(log2(sys_ram_depth)-1 downto 0);
        Sin_val     :out std_logic_vector(sys_ram_width_bitnum-1 downto 0);
        Cos_val     :out std_logic_vector(sys_ram_width_bitnum-1 downto 0)
     );
end t15_dds_v2;

architecture bhvral_top of t15_dds_v2 is
------------------ SIGANL ------------------
    signal  ram_adress : std_logic_vector(log2(sys_ram_depth)-1 downto 0);

------------------ COMPONENT ------------------
    component t15_accum is
    Generic (   
        Ram_width_bitsize : integer ;       --ram width
        Ram_depth_bitsize : integer ;       --ram depth 
        Accum_bitsize :integer --:= 28
     );
    Port (
        clk :in std_logic;
        rst :in std_logic ; 
        w_freq :in std_logic_vector( log2(Ram_depth_bitsize)-1 downto 0);
        addrs :out std_logic_vector( log2(Ram_depth_bitsize)-1 downto 0)
     );
    end component t15_accum;

    component t15_wave_bram is
        generic(
            RAM_WIDTH 		: integer 	;				-- Specify RAM data width
            RAM_DEPTH 		: integer 	;				-- Specify RAM depth (number of entries)
            RAM_PERFORMANCE : string 	    -- Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
        );
        port (
            clk : in std_logic;                                         --for control by wave_freq
            rst  : in std_logic;                                         --for give an outpot (0 for out of some bandwidth)
            addr: in std_logic_vector(RAM_DEPTH-1 downto 0);    --ram line 
            dout: out std_logic_vector(RAM_WIDTH-1 downto 0)            --ram line value
        );
    end component t15_wave_bram;
    
    signal addr_first : std_logic_vector(WAVElevelNUM-1 downto 0);
    signal addr_second : std_logic_vector(WAVElevelNUM-1 downto 0);
    
    
begin

ACC : t15_accum 
    generic map(
        Ram_width_bitsize 	=> WAVElevelBIT,
        Ram_depth_bitsize   => sys_ram_depth,
        Accum_bitsize       => 28
    )
    port map(
        clk     => clk , 
        rst     => RESET ,
        w_freq  => Wave_freq ,
        addrs   => ram_adress
    );
    

Sinwave : t15_wave_bram 
    generic map(
    RAM_WIDTH 		=> sys_ram_width_bitnum,
    RAM_DEPTH 		=>  sys_ram_depth ,
    RAM_PERFORMANCE => "LOW_LATENCY" 
    )
    port map(
    clk     => clk ,                                     
    rst     => reset ,                                  
    addr    => ram_adress ,
    dout    => Sin_val       
    );
Coswave : t15_wave_bram 
    generic map(
    RAM_WIDTH 		=> WAVElevelBIT,
    RAM_DEPTH 		=> sys_ram_depth ,
    RAM_PERFORMANCE => "LOW_LATENCY" 
    ) 
    port map(
    clk     => clk ,                                     
    rst     => reset ,                                    
    addr    => ram_adress ,
    dout    => Cos_val       
    );




end bhvral_top;
