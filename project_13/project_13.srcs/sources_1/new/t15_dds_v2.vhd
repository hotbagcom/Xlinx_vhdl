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
use IEEE.Numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity t15_dds_v2 is
    Generic (
        sys_ram_width_bitnum    :integer := 32 ;    --ram width
        sys_ram_depth    :integer  := 4096          --ram depth    
     );
    Port (
        clk         : in std_logic ;
        reset       : in std_logic :='0' ; 
        Wave_freq   : in std_logic_vector(log2(sys_ram_depth)-1 downto 0);
        Sin_val     :out std_logic_vector(sys_ram_width_bitnum-1 downto 0);
        Cos_val     :out std_logic_vector(sys_ram_width_bitnum-1 downto 0)
     );
end t15_dds_v2;

architecture bhvral_top of t15_dds_v2 is

------------------ SIGANL ------------------
    signal  ram_adress : std_logic_vector(log2(sys_ram_depth)-1 downto 0);
    
    signal S_Sin_val     : std_logic_vector(sys_ram_width_bitnum-1 downto 0);
    signal S_Cos_val     : std_logic_vector(sys_ram_width_bitnum-1 downto 0);
    signal S_phaseshift  : std_logic_vector(log2(sys_ram_depth)-1 downto 0)  ;
    
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
            w_freq :in std_logic_vector( Ram_depth_bitsize-1 downto 0);
            addrs :out std_logic_vector( Ram_depth_bitsize-1 downto 0)
         );
    end component t15_accum;

    component ROM_file is
        generic(
            RAM_WIDTH 		: integer 	;			
            RAM_DEPTH 		: integer 	
        );
        port (
            clk : in std_logic;                                         --for control by wave_freq
            addr: in std_logic_vector(log2(RAM_DEPTH)-1 downto 0);    --ram line 
            dout: out std_logic_vector(RAM_WIDTH-1 downto 0)            --ram line value
        );
    end component ROM_file;

    
begin

ACC : t15_accum 
    generic map(
        Ram_width_bitsize 	=> sys_ram_width_bitnum,
        Ram_depth_bitsize   => log2(sys_ram_depth),
        Accum_bitsize       => 28
    )
    port map(
        clk     => clk , 
        rst     => reset ,
        w_freq  => Wave_freq ,
        
        addrs   => ram_adress
    );
    

Sinwave : ROM_file 
    generic map(
    RAM_WIDTH 		=> sys_ram_width_bitnum,
    RAM_DEPTH 		=>  sys_ram_depth
    )
    port map(
    clk     => clk ,                                    
    addr    => ram_adress ,
    dout    => S_Sin_val       
    );
    
    S_phaseshift <= std_logic_vector( unsigned(ram_adress) + to_unsigned( sys_ram_depth/4 , log2(sys_ram_depth) ) );
    
Coswave : ROM_file 
    generic map(
    RAM_WIDTH 		=> sys_ram_width_bitnum,
    RAM_DEPTH 		=> sys_ram_depth 
    ) 
    port map(
    clk     => clk ,                                     
    addr    =>  S_phaseshift ,
    
    
   -- std_logic_vector( unsigned() + to_unsigned(  stdlogicvector(sys_ram_depth) sra 2) ) 
    dout    => S_Cos_val       
    );

    Sin_val <=S_Sin_val;

    Cos_val <=S_Cos_val;

end bhvral_top;
