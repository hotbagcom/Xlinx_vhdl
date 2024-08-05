-- vhdl 5. course
--+----------------------
--|AN VHDL FÝLE TAMPLETE
--+----------------------

--+----------------------
--|LIBRARY AND PACKAGES DECLERATION
--+----------------------
----Standart packages
library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.STD_LOGIC_ARITH.ALL;
    use IEEE.STD_LOGIC_UNSIGNED.ALL; 
    --use IEEE.STD
----User defined packages
    --use work.PCK_MYPACKAGE.ALL;
    
--+----------------------
--|ENTITY
--+----------------------
entity my_entity_name is
    generic(
    c_clkfreq : integer := 100_000_000;
    c_sclfreq : integer := 1_000_000;  
    c_i2cfreq : integer := 400_000;
    c_bitnum  : integer := 8;
    c_is_sim : boolean := false;
    c_clk_fgr_cnfg : std_logic_vector( 7 downto 0) := X"AE"
    );
    port(
    A0: in std_logic_vector( c_bitnum-1 downto 0 );
    A1: in std_logic ;
    B0: out std_logic ;
    B1: out std_logic_vector(15 downto 0);
    )
end my_entity_name;




--+----------------------
--|ARCHITECTURE
--+----------------------
Architecture my_architecture_name of my_entity_name is 

--+----------------------
--|CONSTANTS
--+----------------------
constant c_const1   : integer           := '30';
constant c_timer1mslim : integer        := c_clkfreq/1000;
constant c_constant2 : std_logic_vector(c_bitnum -1 downto 0) := (others=> '0'); 

--+----------------------
--|COMPONENT DECLERATIONS
--+----------------------
component my_component is
    generic(
        gen1 :integer := 10;
        gen2 :std_logic := '0'
    );
    port(
        in1 :std_logic_vector(c_bitnum-1 downto 0 ) ;
        out1:std_logic
    );
end component my_component;

--+----------------------
--|TYPES
--+----------------------
type t_state is(S_START , S_OPPERATION , S_TERMINATE , IDLE );
--Subtype is a type with a constraint
subtype t_decimal_digit is integer range  0 to 9;
subtype t_byte is bit_vector( 7 downto 0 );
--record
type my_record_type is record
    param1 : std_logic;
    param2 : std_logic_vector( 3 downto 0 );
end record;

--+----------------------
--|SIGNALS
--+----------------------
signal s0        : std_logic_vector(c_bitnum-1 downto 0);               --signal with out initialization
signal s1        : std_logic_vector(c_bitnum-1 downto 0) :=  x"00";     --signal with initialization
signal s2        : integer range 0 to 255       := 0 ;      --user defined 8 bit 
signal s3        : integer                      := 0 ;      --defoult 32 bit defined
signal s4        : std_logic                    := '0' ; 
signal state     : t_state          := S_START ;
signal bcd       :t_decimal_digit   :=  0;
signal opcode    : t_byte           := x"BA";
signal s_record  : my_record_type ;

--+----------------------
--|BEGIN
--+----------------------
begin

--+----------------------
--|COMONENT INSTANTIATIONS
--+----------------------
mycomponen1 :  my_component
generic map(
    gen1    =>  c_i2cfreq;
    gen2    =>  '0';
)

port map(
    in1 => A0 ,
    out1 => B0
);

--+----------------------
--|CONCURRENT ASIGNMENT
--+----------------------
s1 <=   x"01" when s0 < 30 else
        x"02" when s0 < 40 else
        x"03" ;
        
with state select
s0 <=   x"01" when S_START,
        x"02" when S_OPERATION,
        x"03" when S_TERMINATE,
        x"04" when others,
s3 <= 5+3 ; 
s4 <= A0(1) and A0(0) xor A1 ;

s_record.param1 <= '0';
s_record.param2 <= "0101";

inout2_io <= '0' when sda_ena_n = '0' else 'z';

--+----------------------
--|SEQUENTIAL ASIGNMENTS - PROCESS BLOCK
--|NOTE : Process block works concurrently witk each other
--|         Tool gives multipledriven net error if a signal is assigned multiple process book
--+----------------------
-- COMBINATIONAL PROCESS 
P_combinational : process (s0 , state , A0 , A1 ) begin
    if(s0 < 50) then 
        s1 <= x"01";
    elsif (s0 < 70)
        s1 <= x"02";
    else
        s1 <= x"03";
    end if;
    
    case state is 
        when S_START => S0 <= X"01";
        when S_OPERATION => S0 <= X"02";
        when S_TERMINATE => S0 <= X"03";
        when others => S0 <= X"04";
    end case;
    
    s4 <= A0(6) or A0(7) xnor A0(5) and A0(4);

end process P_combinational;

---------------------------------------------------------
-- Sequential Process 
P_sequential : process (clk) begin 
    if(rising_edge(clk)) then
    --
    --
    end if
end process

end  my_architecture_name;







