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
    clk_1hz : out std_logic;
    count_out : out std_logic_vector(7 downto 0);
    clk_halfspeed : out std_logic;
    clk_62p5MHz : out std_logic;
    clk_250MHz : out std_logic
    --Optional:
    --clk_factor : in std_logic;
    --clk_variable : out std_logic
);
end component;


--Source file that controls the LEDs blinking
component led_blinker is
port(
    clk_led : in std_logic;
    led_out : out std_logic_vector(7 downto 0);
    vio_signal: in std_logic
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
    probe0 : in std_logic_vector(7 downto 0);
    probe1 : in std_logic
);
end component;

component ila_1 is
port(
    clk : in std_logic;
    probe0 : in std_logic;
    probe1 : in std_logic;
    probe2 : in std_logic;
    probe3 : in std_logic_vector(7 downto 0);
    probe4 : in std_logic_vector(7 downto 0);
    probe5 : in std_logic_vector(7 downto 0)
);
end component;

component fifo_controller is 
port(
    rd_clk : in std_logic;
    wr_clk : in std_logic;
    data_in : in std_logic_vector(7 downto 0);
    data_out : out std_logic_vector(7 downto 0)
);
end component;
---------------------------------------------------------------------------------------

--Put any signals, variables, or constants needed for the firmware below: 
signal clk_buf : std_logic := 'U';
signal clk_1hz : std_logic := 'U'; -- it will be set equal to output value from clock_controller.vhd
signal clk_halfspeed : std_logic := 'U';
signal clk_62p5MHz : std_logic := 'U';
signal clk_250MHz : std_logic := 'U';

signal vio_reset : std_logic := 'U'; -- it will be controlled by vio default value
signal led_int : std_logic_vector(7 downto 0);

signal count_out_int : std_logic_vector(7 downto 0) := (others => 'U');
signal data_out_probe : std_logic_vector(7 downto 0) := (others => 'U');
signal data_out_probe_halfspeed : std_logic_vector(7 downto 0) := (others => 'U');
signal data_out_probe_half : std_logic_vector(7 downto 0) := (others => 'U');
signal data_out_probe_double : std_logic_vector(7 downto 0) := (others => 'U');

begin


--Instantiation of clock signal
u_clock_controller : clock_controller
port map(
    clk_in_p => clk_in_p,
    clk_in_n => clk_in_n,
    clk_buf => clk_buf,
    clk_1hz => clk_1hz,
    count_out => count_out_int,
    clk_halfspeed => clk_halfspeed,
    clk_62p5MHz => clk_62p5MHz,
    clk_250MHz => clk_250MHz
);

--Instatiation of LED blinker file
u_led_blinker : led_blinker
port map(
    clk_led => clk_1hz,
    led_out => led_out,
    vio_signal => vio_reset
);


u_fifo_controller : fifo_controller
port map(
   rd_clk => clk_buf,
   wr_clk => clk_buf,
   data_in => count_out_int,
   data_out => data_out_probe
);

u_fifo_controller_half : fifo_controller
port map(
   rd_clk => clk_62p5MHz,
   wr_clk => clk_buf,
   data_in => count_out_int,
   data_out => data_out_probe_half
);

u_fifo_controller_double : fifo_controller
port map(
   rd_clk => clk_62p5MHz,
   wr_clk => clk_buf,
   data_in => count_out_int,
   data_out => data_out_probe_double
);


u_fifo_controller_halfspeed : fifo_controller
port map(
   wr_clk => clk_buf,
   rd_clk => clk_halfspeed,
   data_in => count_out_int,
   data_out => data_out_probe_halfspeed
);

--WEEK 1: ADD VIO, ILA, AND FIFO BELOW
u_vio0 : vio_0
port map(
    clk => clk_buf, -- always want to distributed buffered clock
    probe_out0 => vio_reset
);

led_out <= led_int;
u_ila0 : ila_0
port map(
    clk => clk_buf,
    probe0 => led_int,
    probe1 => clk_1hz
);

-- ila to monitor fifos
u_ila1 : ila_1
port map(
    clk => clk_buf,
    probe0 => clk_buf,
    probe1 => clk_halfspeed,
    probe2 => '0',
    probe3 => count_out_int,
    probe4 => data_out_probe,
    probe5 => data_out_probe_halfspeed
);

end Behavioral;
