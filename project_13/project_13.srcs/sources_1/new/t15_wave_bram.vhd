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
use std.textio.all;
use IEEE.NUMERIC_STD.ALL;
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
            clk : in std_logic;                                         --for give an outpot (0 for out of some bandwidth)
            addr: in std_logic_vector(log2(RAM_DEPTH)-1 downto 0);    --ram line 
            dout: out std_logic_vector(RAM_WIDTH-1 downto 0)            --ram line value
        );

end t15_wave_bram;

architecture Behavioral of t15_wave_bram is

type RamType is array (0 to RAM_DEPTH-1 ) of bit_vector (RAM_WIDTH-1 downto 0) ;

impure function InitRamFromFile(RamFileName : in string ) return RamType is
FILE RamFile :text is in RamFileName;
variable RamFileLine :Line;
variable RAM : RamType;
begin -- function 
    for k in RamType'range loop
    readline(RamFile , RamFileLine);
    read(RamFileLine , RAM(k));
    end loop;
    return RAm;
end function;

signal ROM : RamType := InitRamFromFile("read_only_mem.mem");

begin --architecture

process (clk) begin 
    if rising_edge(clk) then 
        dout <=  std_logic_vector(to_stdulogicvector ( ROM( to_integer  (unsigned(addr)) )  )   )  ;
    end if;
end process ;

end Behavioral;
