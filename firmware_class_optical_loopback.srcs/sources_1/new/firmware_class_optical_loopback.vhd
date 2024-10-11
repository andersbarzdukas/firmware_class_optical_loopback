----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/03/2024 01:25:25 PM
-- Design Name: 
-- Module Name: firmware_class_optical_loopback - Behavioral
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

entity firmware_class_optical_loopback is
    Port ( clk_in_p : in STD_LOGIC;
           clk_in_n : in STD_LOGIC;
           led_out : out STD_LOGIC_VECTOR(7 DOWNTO 0)
         );
end firmware_class_optical_loopback;

architecture Behavioral of firmware_class_optical_loopback is

--Declaration of components (other source files/ip cores) that are used in this project

--Source file that outputs clocks
component clock_controller is
port(
    clk_in_p : in std_logic;
    clk_in_n : in std_logic;
    clk_buf : out std_logic;
    clk_1hz : out std_logic
    --Optional:
    --clk_factor : in std_logic;
    --clk_variable : out std_logic
);
end component;


--Source file that controls the LEDs blinking
component led_blinker is
port(
    clk_led : in std_logic;
    led_out : out std_logic_vector(7 downto 0)
);
end component; 

component vio_0 is
port(
    clk : in std_logic;
    probe_out0 : out std_logic
);
end component; 

component ila_0 is
port(
    clk : in std_logic;
    probe0 : in std_logic
);
end component; 
---------------------------------------------------------------------------------------

--Put any signals, variables, or constants needed for the firmware below: 
signal clk_buf : std_logic := 'U';
signal clk_1hz : std_logic := 'U';
signal vio_out : std_logic := 'U';

begin


--Instantiation of clock signal
u_clock_controller : clock_controller
port map(
    clk_in_p => clk_in_p,
    clk_in_n => clk_in_n,
    clk_buf => clk_buf,
    clk_1hz => clk_1hz
);

--Instatiation of LED blinker file
u_led_blinker : led_blinker
port map(
    clk_led => clk_1hz,
    led_out => led_out
);

u_vio_0 : vio_0
port map(
    clk => clk_buf,
    probe_out0 => vio_out
);

u_ila_0 : ila_0
port map(
    clk => clk_buf,
    probe0 => clk_1hz
);


--WEEK 1: ADD VIO, ILA, AND FIFO BELOW



end Behavioral;
