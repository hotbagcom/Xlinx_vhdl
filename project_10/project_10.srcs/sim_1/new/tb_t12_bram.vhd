----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.08.2024 08:56:37
-- Design Name: 
-- Module Name: tb_t12_bram - Behavioral
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
--use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.log2_pck.all;

entity tb_t12_bram is
generic (
RAM_WIDTH 		: integer 	:= 32;				-- Specify RAM data width
RAM_DEPTH 		: integer 	:= 1024;				-- Specify RAM depth (number of entries)
RAM_PERFORMANCE : string 	:= "LOW_LATENCY"    -- Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
-- RAM_PERFORMANCE : string 	:= "HIGH_PERFORMANCE"    -- Select "HIGH_PERFORMANCE" or "LOW_LATENCY"
);
end tb_t12_bram;

architecture Behavioral of tb_t12_bram is

component t12_bram is
generic (
RAM_WIDTH 		: integer 	:= 32;				-- Specify RAM data width
RAM_DEPTH 		: integer 	:= 1024;				-- Specify RAM depth (number of entries)
RAM_PERFORMANCE : string 	:= "LOW_LATENCY"    -- Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
);
port (
addr : in std_logic_vector(log2_c(RAM_DEPTH)-1 downto 0);    -- Address bus, width determined from RAM_DEPTH
din  : in std_logic_vector(RAM_WIDTH-1 downto 0);		  		-- RAM input data
clk  : in std_logic;                       			  		-- Clock
we   : in std_logic;                       			  		-- Write enable
dout : out std_logic_vector(RAM_WIDTH-1 downto 0)   			-- RAM output data
);
end component;

signal addra : std_logic_vector((log2_c(RAM_DEPTH)-1) downto 0)	:= (others => '0');
signal dina  : std_logic_vector(RAM_WIDTH-1 downto 0) 			:= (others => '0');
signal clka  : std_logic 										:= '0';            
signal wea   : std_logic 										:= '0';                      
signal douta_1 : std_logic_vector(RAM_WIDTH-1 downto 0);

constant c_clkperiod	: time := 10 ns;
signal  adress_0 : integer range 0 to (RAM_DEPTH-1)  := 0 ;



begin

DUT : t12_bram
generic map(
RAM_WIDTH 		=> 	RAM_WIDTH 		   ,
RAM_DEPTH 		=> 	RAM_DEPTH 		   ,
RAM_PERFORMANCE =>  RAM_PERFORMANCE    
)
port map(
addr => addra  ,
din  => dina   ,
clk  => clka   ,
we   => wea    ,
dout => douta_1
);

P_CLKGEN : process begin

clka	<= '1';
wait for c_clkperiod/2;
clka	<= '0';
wait for c_clkperiod/2;

end process P_CLKGEN;



P_STIMULI : process begin




--wea		<= '1';
--addra 	<= "000000";
--dina	<= x"F0F0F0F0";
--wait for c_clkperiod;
--addra 	<= "000001";
--dina	<= x"1234FFFF";
--wait for c_clkperiod;
--addra 	<= "000010";
--dina	<= x"ABCD0000";
--wait for c_clkperiod;
--addra 	<= "000011";
--dina	<= x"00111100";



--wait for c_clkperiod/2;
--wea		<= '0';

--wait for c_clkperiod/2;
--addra 	<= "000000";
--wait for c_clkperiod;
--addra 	<= "000001";
--wait for c_clkperiod;
--addra 	<= "000010";
--wait for c_clkperiod;
--addra 	<= "000011";
--wait for c_clkperiod;



for p in 0 to RAM_DEPTH-1 loop
addra <= std_logic_vector(to_unsigned(p , log2_c(RAM_DEPTH) ));
wait for c_clkperiod/2; 
end loop;

for u in RAM_DEPTH-1 downto 0 loop
addra <= std_logic_vector(to_unsigned(u , log2_c(RAM_DEPTH) ));
wait for c_clkperiod/2; 
end loop;



assert false ;
report "SIM DONE";
--severity failure;

end process P_STIMULI;

end Behavioral;