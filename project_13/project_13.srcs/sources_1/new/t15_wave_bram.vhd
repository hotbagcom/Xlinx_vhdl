----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.08.2024 14:10:32
-- Design Name: 
-- Module Name: t15_wave_bram - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity t15_wave_bram is
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

end t15_wave_bram;

architecture Behavioral of t15_wave_bram is

begin


end Behavioral;
