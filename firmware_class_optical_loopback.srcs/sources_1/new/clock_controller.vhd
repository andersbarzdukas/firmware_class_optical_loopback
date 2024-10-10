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
  Generic(speed_factor_width : integer := 3);
  Port ( 
    clk_in_p : in std_logic;
    clk_in_n : in std_logic;
    clk_buf : out std_logic;
    clk_1hz : out std_logic;
    --Optional:
    clk_factor : in unsigned(speed_factor_width downto 0);
    clk_variable : out std_logic
  );
end clock_controller;

architecture Behavioral of clock_controller is

--Signals used to create buffered clocks
signal clk_unbuf : std_logic :='U';
signal clk_buf_int : std_logic := 'U';
signal clk_1hz_int : std_logic := '0';

signal count_max : unsigned(26 downto 0) := to_unsigned(62_500_000,27);
signal variable_count_max : unsigned(26 downto 0) := (others => '0');

component slow_clock 
generic( count_max_width : integer);
port(
clk_in : in std_logic;
count_max : in unsigned(26 downto 0);
clk_out_slow : out std_logic
);
end component;

begin

--Combining the p/n input ports then buffering the input clock
u_IBUFGDS : IBUFDS port map (I => clk_in_p,IB => clk_in_n,O => clk_unbuf);
u_bufg: bufg PORT map(i => clk_unbuf, o => clk_buf_int);

--Need intermediate signal for other processes 
clk_buf <= clk_buf_int;
clk_1hz <= clk_1hz_int;

u_slow_clk : slow_clock
generic map( count_max_width => 26)
port map(
clk_in => clk_buf_int,
count_max => count_max,
clk_out_slow => clk_1hz_int
);

--Optional slow clock that uses a vio input to set frequency
variable_count_max <= to_unsigned(5_000_000,26-speed_factor_width)*clk_factor; 

u_variable_slow_clk : slow_clock
generic map(count_max_width => 26)
port map(
clk_in => clk_buf_int,
count_max => variable_count_max,
clk_out_slow => clk_variable
);

end Behavioral;