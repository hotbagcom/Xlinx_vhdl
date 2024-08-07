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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity t15_dds_v2 is
    Generic (
        X_clk : integer := 1_000_000_000 ;                
        WAVEfreqBIT     :integer := 28; 
        WAVElevelBIT    :integer := 16 
     );
    Port (
        clk         : in std_logic ;
        reset       : in std_logic ; 
        Wave_freq   : in std_ulogic_vector(WAVEfreqBIT-1 downto 0):= std_ulogic_vector( to_unsigned(1_000 , WAVEfreqBIT ) );
        temp_adress : in std_logic_vector(WAVElevelBIT-1 downto 0);
        Sin_val     :out std_logic_vector(WAVElevelBIT-1 downto 0);
        Cos_val     :out std_logic_vector(WAVElevelBIT-1 downto 0)
     );
end t15_dds_v2;

architecture bhvral_top of t15_dds_v2 is
    component t15_wave_bram is
        generic(
            RAM_WIDTH 		: integer 	;				-- Specify RAM data width
            RAM_DEPTH 		: integer 	;				-- Specify RAM depth (number of entries)
            RAM_PERFORMANCE : string 	    -- Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
        );
        port (
            clk : in std_logic;                                         --for control by wave_freq
            rst  : in std_logic;                                         --for give an outpot (0 for out of some bandwidth)
            addr: in std_logic_vector(log2(RAM_DEPTH)-1 downto 0);    --ram line 
            dout: out std_logic_vector(RAM_WIDTH-1 downto 0)            --ram line value
        );
    end component;
    
    signal addr_first : std_logic_vector(WAVEfreqBIT-1 downto 0);
    signal addr_second : std_logic_vector(WAVEfreqBIT-1 downto 0);
    signal onoff_clk : std_logic := '1';
    signal wave_periode : integer := X_clk/Wave_freq;
    
    
begin

process (clk) begin
wait for wave_periode /2;
onoff_clk <= not onoff_clk;
end process;


Sinwave : t15_wave_bram 
    generic map(
    RAM_WIDTH 		=> WAVElevelBIT,
    RAM_DEPTH 		=>  to_unsigned( std_logic_vector(WAVEfreqBIT'range) ) ,
    RAM_PERFORMANCE => "LOW_LATENCY" 
    )
    port map(
    clk     => onoff_clk ,                                     
    rst     => reset ,      
    --TODO adres döndürme iþlemini nasýl yapacak                              
    addr    =>  temp_adress,
    dout    => Sin_val       
    );
Coswave : t15_wave_bram 
    generic map(
    RAM_WIDTH 		=> WAVElevelBIT,
    RAM_DEPTH 		=> WAVEfreqBIT ,
    RAM_PERFORMANCE => "LOW_LATENCY" 
    ) 
    port map(
    clk     => clk ,                                     
    rst     => reset ,                                    
    addr    =>  temp_adress,
    dout    => Cos_val       
    );




end bhvral_top;
