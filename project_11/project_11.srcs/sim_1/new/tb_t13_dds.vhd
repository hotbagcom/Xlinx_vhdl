----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.08.2024 16:13:54
-- Design Name: 
-- Module Name: tb_t13_dds - Behavioral
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_t13_dds is
    Generic(
        C_RAM_WIDTH 		: integer     := 32	;				-- Specify RAM data width
        C_RAM_DEPTH 		: integer     :=2048	;				-- Specify RAM depth (number of entries)
        C_RAM_PERFORMANCE   : string 	  :="LOW_LATENCY" ;   -- Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
        C_clk               : integer     := 10_000_000 ;
        C_lvl_presc_bit     : integer     := 16
        );
end tb_t13_dds;

architecture Behavioral of tb_t13_dds is


component t13_dds is
    Generic(
        RAM_WIDTH 		: integer 	;				-- Specify RAM data width
        RAM_DEPTH 		: integer 	;				-- Specify RAM depth (number of entries)
        RAM_PERFORMANCE : string 	;   -- Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
        clk             : integer   ;
        lvl_presc_bit   : integer   
    );
    Port(
        clk_in      : in std_logic ;
        resetn_in   : in std_logic ; 
        wave_freq_in: in std_logic_vector( 27 downto 0);
        sin_val_out :out std_logic_vector( (lvl_presc_bit-1) downto 0 );
        cos_val_out :out std_logic_vector( (lvl_presc_bit-1) downto 0 )
    );

end component ;



    signal  C_clk_in      :  std_logic := '0';
    signal  C_resetn_in   : std_logic := '0'; 
    signal  C_wave_freq_in:  std_logic_vector( 27 downto 0) range 0 to  std_logic_vector(to_unsigned(C_clk, 28)) := x"0000014"; --20HZ
    signal  C_sin_val_out : std_logic_vector( (C_lvl_presc_bit-1) downto 0 );
    signal  C_cos_val_out : std_logic_vector( (C_lvl_presc_bit-1) downto 0 );

    

begin





DUT : t13_dds 
generic map(
        RAM_WIDTH 		=> C_RAM_WIDTH	,				-- Specify RAM data width
        RAM_DEPTH 		=> C_RAM_DEPTH ,				-- Specify RAM depth (number of entries)
        RAM_PERFORMANCE => C_RAM_PERFORMANCE ,   -- Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
        clk             => C_clk ,
        lvl_presc_bit   =>  C_lvl_presc_bit 
)

port map(
        clk_in          => C_clk_in  ,
        resetn_in       => C_resetn_in , 
        wave_freq_in    => C_wave_freq_in ,
        sin_val_out     => C_sin_val_out ,
        cos_val_out     => C_cos_val_out
);



P_CLKGEN : process begin

C_clk_in	<= '1';
wait for 1000 ms / ( 2*C_wave_freq_in);
C_clk_in	<= '0';
wait for 1000 ms / ( 2*C_wave_freq_in);

end process P_CLKGEN;



end Behavioral;
