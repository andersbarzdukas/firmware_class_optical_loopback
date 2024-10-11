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
    clk_1hz : out std_logic
    --Optional:
    --clk_factor : in std_logic;
    --clk_variable : out std_logic
  );
end clock_controller;

architecture Behavioral of clock_controller is

--Signals used to create buffered clocks
signal clk_unbuf : std_logic :='U';
signal clk_buf_int : std_logic := 'U';
signal clk_1hz_int : std_logic := 'U';
signal counter : unsigned(26 downto 0) := (others => '0');

begin

--Combining the p/n input ports then buffering the input clock
u_IBUFGDS : IBUFDS port map (I => clk_in_p,IB => clk_in_n,O => clk_unbuf);
u_bufg: bufg PORT map(i => clk_unbuf, o => clk_buf_int);

--Need intermediate signal for other processes 
clk_buf <= clk_buf_int;
clk_1hz <= clk_1hz_int;

--Counter to make a 1Hz clock
clock_1hz : process(clk_buf_int) 
variable counter_max : unsigned(26 downto 0) := to_unsigned(250_000_000,27);
begin
  if(rising_edge(clk_buf_int)) then
    if(counter = counter_max) then
        clk_1hz_int <= not clk_1hz_int;
        counter <= (others => '0');
    else
        counter <= counter + 1;
    end if;
  end if;
end process;


end Behavioral;