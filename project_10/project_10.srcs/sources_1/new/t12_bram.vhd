 package log2_pck is
 function log2_c(depth :in natural ) return integer;
 end log2_pck ;


package body log2_pck is
 function log2_c(depth :in natural ) return integer is
 variable temp    : integer := depth;
 variable ret_val : integer := 0;
 begin
    while temp > 1 loop
        ret_val := ret_val + 1;
        temp    := temp / 2;
    end loop;
  	return ret_val;
 end function;
 end package body log2_pck ;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.log2_pck.all;



entity t12_bram is
generic(
RAM_WIDTH 		: integer 	;				-- Specify RAM data width
RAM_DEPTH 		: integer 	;				-- Specify RAM depth (number of entries)
RAM_PERFORMANCE : string 	    -- Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 

);
port(
clk : in std_logic;
we : in std_logic;
addr : in std_logic_vector(log2_c(RAM_DEPTH)-1 downto 0);
din : in std_logic_vector(RAM_WIDTH-1 downto 0);
dout : out std_logic_vector(RAM_WIDTH-1 downto 0)
);
end t12_bram;

architecture syn of t12_bram is
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


    process(clk)
    begin
        if (rising_edge(clk)) then
            if we = '1' then
                RAM(to_integer(unsigned(addr))) <= to_bitvector(din);
            end if;
            dout <= to_stdlogicvector(RAM(to_integer(unsigned(addr))));
        end if;
    end process;
end syn;
