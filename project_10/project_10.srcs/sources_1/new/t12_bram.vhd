----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.08.2024 13:18:06
-- Design Name: 
-- Module Name: t12_bram - t12_bram_bhvrl
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
--Insert the following in the architecture before the begin keyword
--  The following function calculates the address width based on specified RAM depth

package ram_pkg is
function clogb2( depth : natural) return integer ;
end ram_pkg;






package body ram_pkg is
function clogb2( depth : natural) return integer is
variable temp    : integer := depth;
variable ret_val : integer := 0;
begin
    while temp > 1 loop
        ret_val := ret_val + 1;
        temp    := temp / 2;
    end loop;
    return ret_val;
end function;

end package body ram_pkg;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use std.textio.all;
use work.ram_pkg.ALL ;

entity t12_bram is
    Generic(
        constant RAM_WIDTH : integer := 4;            		-- Specify RAM data width
        constant RAM_DEPTH : integer := 8; 				        -- Specify RAM depth (number of entries)
        constant RAM_PERFORMANCE : string := "HIGH_PERFORMANCE" ; 		-- Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
        --constant C_RAM_PERFORMANCE : string := "LOW_LATENCY" ; 		-- Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
        
        constant C_INIT_FILE : string := "read_only_mem.mem"    				 -- Specify name/location of RAM initialization file if using one (leave blank if not)
        
    );
    Port (
        W_adrs_in  : in std_logic_vector((clogb2(RAM_DEPTH)-1) downto 0);    -- Write address bus, width determined from RAM_DEPTH
        R_adrs_in  : in std_logic_vector((clogb2(RAM_DEPTH)-1) downto 0);    -- Read address bus, width determined from RAM_DEPTH
        Din_in     : in std_logic_vector(RAM_WIDTH-1 downto 0);		        -- RAM input data
        clk_io     :inout std_logic;                       			        -- Clock
        W_enable   :out std_logic ;                      			           -- Write enable
        M_enable   :out std_logic;                       			           -- RAM Enable, for additional power savings, disable port when not in use
        Dout_out   :out std_logic_vector(RAM_WIDTH-1 downto 0) 		        -- RAM output data

    );
end t12_bram;

architecture t12_bram_bhvrl of t12_bram is

    constant C_RAM_WIDTH : integer := RAM_WIDTH;            		-- Specify RAM data width
    constant C_RAM_DEPTH : integer := RAM_DEPTH ; 				     -- Specify RAM depth (number of entries)
    constant C_RAM_PERFORMANCE : string := RAM_PERFORMANCE ; 		-- Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
    constant c_clock : integer := 1_000_000_000 ;
    constant c_clockPeriod : time := (1000 ms / c_clock)  ;         -- clock periode is 1 ns 

   signal  clk : std_logic := '1' ;

   
        -- RAM signal declaration
  type ram_type is array (0 to C_RAM_DEPTH-1) of std_logic_vector(C_RAM_WIDTH-1 downto 0);
  signal ram_data : ram_type := (others => (others => '0'));

  -- Register for output data
  signal Dout_reg : std_logic_vector(C_RAM_WIDTH-1 downto 0) := (others => '0');

  -- File handling variables
 shared variable ram_index : integer := 0;
 shared variable direction : std_logic := '1';
 
 
begin
  -- Initialize RAM from file
  read_file : process
  file ramfile    : text is in C_INIT_FILE;
  variable ramfileline : line ;
  variable bitvec : bit_vector((C_RAM_DEPTH*C_RAM_WIDTH)-1 downto 0)  ;
--  variable slv_vec : std_logic_vector(C_RAM_WIDTH-1 downto 0);
  begin
      for i in ram_type'range loop
        readline(ramfile, ramfileline); 
        read(ramfileline,  bitvec );
        
        ram_data(i) <= to_stdlogicvector(bitvec) ;
      end loop;
  end process read_file;




--begin--

    clk <= not clk after c_clockPeriod /2 ;
    clk_io <= clk ;   
    process (clk) begin
        if (rising_edge(clk)) then
           if(direction='1') then 
           ram_index := ram_index +1;
            Dout_out <= ram_data( 15 downto 0 ) ;
            --( ((ram_index  + 1)*C_RAM_WIDTH) -1 )  downto ram_index*C_RAM_WIDTH 
           else if ()then 
           
           ram_index := ram_index -1;
           
           end if ;
        end if;
        
        if (falling_edge(clk)) then
           if(ram_index = (C_RAM_DEPTH-1) ) then
            direction := '0';
           else if( ram_index = 0 ) then
            direction := '1';
           end if ;
        end if;
    end process;
    

    
end t12_bram_bhvrl;

    

