----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/03/2024 04:41:23 PM
-- Design Name: 
-- Module Name: firmware_class_optical_loopback_simulation - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity firmware_class_optical_loopback_simulation is
--  Port ( );
end firmware_class_optical_loopback_simulation;

architecture Behavioral of firmware_class_optical_loopback_simulation is

component firmware_class_optical_loopback is
port (
  clk_in_p : in std_logic;
  clk_in_n : in std_logic;
  led_out : out std_logic_vector(7 downto 0)
);
end component;

--clock signals
signal clk_in_p : std_logic := '1';
signal clk_in_n : std_logic := not clk_in_p;

--LED signal
signal led_out : std_logic_vector(7 downto 0) := (others => '0');


begin

--Simulation clocks to use for instantiation
clk_in_p <= not clk_in_p after 4ns;
clk_in_n <= not clk_in_p;

--Instantiation of the top source file
u_firmware_class_optical_loopback : firmware_class_optical_loopback
port map(
  clk_in_p => clk_in_p,
  clk_in_n => clk_in_n,
  led_out => led_out
);

end Behavioral;
