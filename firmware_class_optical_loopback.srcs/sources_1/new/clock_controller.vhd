----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/03/2024 01:46:45 PM
-- Design Name: 
-- Module Name: led_blinker - Behavioral
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
library UNISIM;
use UNISIM.VComponents.all;

entity clock_controller is
  Port ( 
    clk_in_p : in std_logic;
    clk_in_n : in std_logic;
    clk_buf : out std_logic;
    clk_1hz : out std_logic;
    count_out : out std_logic_vector(7 downto 0);
    clk_halfspeed : out std_logic;
    clk_250MHz : out std_logic;
    clk_62p5MHz : out std_logic
    --Optional:
    --clk_factor : in std_logic;
    --clk_variable : out std_logic
  );
end clock_controller;

architecture Behavioral of clock_controller is

component clk_wiz_0 is
port (
  reset : in std_logic;
  locked : out std_logic;
  clk_in1 : in std_logic;
  clk_out1 : out std_logic;
  clk_out2 : out std_logic
);
end component;

--Signals used to create buffered clocks
signal clk_unbuf : std_logic :='U'; -- these values will be coming from the clock
signal clk_buf_int : std_logic := 'U';
signal count : unsigned(26 downto 0) := (others => '0');
signal clk_1hz_int: std_logic := '0';
signal clk_halfspeed_int : std_logic := '0';
signal clk_250MHz_int : std_logic := 'U';
signal clk_62p5MHz_int : std_logic := 'U';

begin

--Combining the p/n input ports then buffering the input clock
u_IBUFGDS : IBUFDS port map (I => clk_in_p,IB => clk_in_n,O => clk_unbuf);
u_bufg: bufg PORT map(i => clk_unbuf, o => clk_buf_int);

--Need intermediate signal for other processes 
clk_buf <= clk_buf_int; -- if routed to output, cannot access in this file
clk_1hz <= clk_1hz_int;
--clk_halfspeed <= clk_halfspeed_int;

--Counter to make a 1Hz clock
clock_1hz : process(clk_buf_int) 
variable count_max : unsigned(26 downto 0) := to_unsigned(125_000_000,27); --internal to function
begin
  if(rising_edge(clk_buf_int)) then
    --FILL IN CODE HERE
    if count < count_max then
       count <= count + 1;
    else
       count <= (others => '0');
       clk_1hz_int <= not clk_1hz_int; -- e.g. if we used clk_1hz here, it will not work
    end if;
    
  end if;
end process;

--Counter to make half speed clock
clock_halfspeed: process(clk_buf_int)
begin
 if(rising_edge(clk_buf_int)) then
   if count(0) = '0' then
     clk_halfspeed_int <= not clk_halfspeed_int;
   end if; 
 end if;
end process;

count_out <= std_logic_vector(count(7 downto 0));

-- clock wizards for changed speed clocks
u_clk_wiz_0 : clk_wiz_0
port map(
  reset => '0',
  locked => open,
  clk_in1 => clk_unbuf,
  clk_out1 => clk_62p5MHz_int,
  clk_out2 => clk_250MHz_int
);

clk_62p5MHz <= clk_62p5MHz_int;
clk_250MHz <= clk_250MHz_int;

end Behavioral;