----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.08.2024 15:22:39
-- Design Name: 
-- Module Name: t13_dds - Behavioral
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

package pck_std is
function log_2(depth : in natural ) return integer;
end package pck_std ;

package body  pck_std is
function log_2(depth : in natural ) return integer is
    variable temp   : integer := depth ;
    variable return_val :integer := 0;
    begin
    while temp>1 loop
        return_val  :=return_val +1;
        temp        := temp/2  ;
    end loop;
    return return_val ;
end function ;
end package body pck_std ;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use std.textio.all;



entity t13_dds is
    Generic(
        RAM_WIDTH 		: integer 	;				-- Specify RAM data width
        RAM_DEPTH 		: integer 	;				-- Specify RAM depth (number of entries)
        RAM_PERFORMANCE : string 	;   -- Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
        clk             : integer   ;
        lvl_presc_bit   : integer 
    );
    Port(
        clk_in : in std_logic ;
        resetn_in :in std_logic ; 
        wave_freq_in : in std_logic_vector( 27 downto 0);
        sin_val_out :out std_logic_vector( (lvl_presc_bit-1) downto 0 );
        cos_val_out :out std_logic_vector( (lvl_presc_bit-1) downto 0 )
    );
end t13_dds;

architecture Behavioral of t13_dds is
shared variable wave_index : integer range 0 to RAM_DEPTH-1 := 0; 



type RamType is array (0 to RAM_DEPTH-1) of bit_vector(RAM_WIDTH-1 downto 0);
impure function InitRamFromFile( RamFileName: in string) return RamType is
FILE RamFile : text is in RamFileName;
variable RamFileLine : line;
variable RAM : RamType;

begin
for I in RamType'range loop
readline(RamFile, RamFileLine);
read(RamFileLine, RAM(I));
end loop;
return RAM;
end function;




signal RAM : RamType := InitRamFromFile("read_only_mem.mem");
begin


    process(clk_in)
    begin
        if (rising_edge(clk_in)) then
            if(wave_index >= RAM_DEPTH/2 ) then 
                wave_index := 0;
            end if;
            sin_val_out <= to_stdlogicvector(RAM(wave_index));
            cos_val_out <= to_stdlogicvector(RAM(wave_index + ( RAM_DEPTH/4 ) ));
            wave_index := wave_index +1;
        end if;
    end process;

end Behavioral;
