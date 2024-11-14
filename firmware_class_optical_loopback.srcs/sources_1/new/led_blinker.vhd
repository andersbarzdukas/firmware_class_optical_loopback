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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity led_blinker is
  Port ( 
    clk_led : in std_logic;
    led_out : out std_logic_vector(7 downto 0);
    vio_signal : in std_logic
  );
end led_blinker;

architecture Behavioral of led_blinker is
signal led_count: std_logic_vector(6 downto 0) := (others => '0');

begin

--Fill in the code you want to light up the LEDs
--led_out(7 downto 0) <= (others => clk_led);
counter_led : process(clk_led)
begin
  if (rising_edge(clk_led)) then
    led_count <= std_logic_vector(unsigned(led_count) + 1);
  end if;
end process;

led_out(6 downto 0) <= led_count;
led_out(7 downto 7) <= (0 => vio_signal);

end Behavioral;
