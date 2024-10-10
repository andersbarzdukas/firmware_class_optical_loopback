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
use IEEE.NUMERIC_STD.ALL;

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
generic( speed_factor_width : integer);
port(
    clk_in_p : in std_logic;
    clk_in_n : in std_logic;
    clk_buf : out std_logic;
    clk_1hz : out std_logic;
    --Optional:
    clk_factor : in unsigned(speed_factor_width downto 0);
    clk_variable : out std_logic
);
end component;


--Source file that controls the LEDs blinking
component led_blinker is
port(
    clk_state_handler : in std_logic;
    clk_led : in std_logic;
    blink_select : in std_logic;
    led_out : out std_logic_vector(7 downto 0)
);
end component; 

--VIO used to control certain properties of LED blinking
component vio_0 is
port(
    clk : in std_logic;
    probe_out0 : out std_logic;
    probe_out1 : out std_logic;
    probe_out2 : out std_logic;
    probe_out3 : out std_logic_vector(3 downto 0)
);
end component;

component ila_0 is
port(
    clk : in std_logic;
    probe0 : in std_logic;
    probe1 : in std_logic;
    probe2 : in std_logic;
    probe3 : in std_logic_vector(7 downto 0)
);
end component;

---------------------------------------------------------------------------------------

--Put any signals, variables, or constants needed for the firmware below: 
signal clk_buf : std_logic := 'U';
signal clk_1hz : std_logic := 'U';
signal vio_reset : std_logic := 'U';
signal clk_select : std_logic := 'U';


--Clocking signals used to set clock signals
constant speed_factor_width : integer := 3;
signal clk_factor : unsigned(speed_factor_width downto 0) := (others => '0'); 
signal clk_factor_int : std_logic_vector(speed_factor_width downto 0) := (others => '0');
signal clk_variable : std_logic := 'U';
signal clk_led : std_logic := 'U';

--Signals for the blinking LED firmware
signal blink_select : std_logic := 'U';
signal led_out_int : std_logic_vector(7 downto 0) := (others => 'U');

begin

--Set clocking signals
clk_led <= clk_1hz when clk_select='0' else clk_variable;
clk_factor <= unsigned(clk_factor_int);

--Set LED out signal to turn LEDs on or off
led_out <= led_out_int;

--Instantiation of clock signal
u_clock_controller : clock_controller
generic map(speed_factor_width => speed_factor_width)
port map(
    clk_in_p => clk_in_p,
    clk_in_n => clk_in_n,
    clk_buf => clk_buf,
    clk_1hz => clk_1hz,
    clk_factor => clk_factor,
    clk_variable => clk_variable
);

--Instatiation of LED blinker file
u_led_blinker : led_blinker
port map(
    clk_state_handler => clk_buf,
    clk_led => clk_led,
    blink_select => blink_select,
    led_out => led_out_int
);

--VIO used to set the various options for the clock or blinking led
u_vio_0 : vio_0
port map(
    clk => clk_buf,
    probe_out0 => vio_reset,
    probe_out1 => clk_select,
    probe_out2 => blink_select,
    probe_out3 => clk_factor_int
);

--ILA Used to monitor signals 
u_ila_0 : ila_0 
port map(
    clk => clk_buf,
    probe0 => clk_led,
    probe1 => clk_variable,
    probe2 => blink_select,
    probe3 => led_out_int
);

end Behavioral;
