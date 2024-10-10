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
--library UNISIM;
--use UNISIM.VComponents.all;

entity led_blinker is
  Port ( 
    clk_state_handler : in std_logic;
    clk_led : in std_logic;
    blink_select : in std_logic;
    led_out : out std_logic_vector(7 downto 0) 
  );
end led_blinker;

architecture Behavioral of led_blinker is

--Blinking variables used to control the state.
type blink_state is (blink_uniform, blink_counter, idle_state, reset_state);
signal current_blinker_state : blink_state := idle_state;
signal next_blinker_state : blink_state := idle_state;

--Signals used in counting logic for blinking counter
signal current_count : std_logic_vector(7 downto 0) := (others => '0');
signal counter_reset : std_logic := '0';

begin

--Add one to the current_count if it is the rising edge of the led_clock
count : process(clk_led)
begin
    if(rising_edge(clk_led)) then
        if(counter_reset='1') then
            current_count <= (others => '0');
        else 
            current_count <= std_logic_vector(unsigned(current_count) + 1); 
        end if;
    end if;
end process;

--Logic that changes the state each clock cycle. 
--Synchronous part of the FSM 
blink_state_controller : process(clk_led)
begin
  if(rising_edge(clk_state_handler)) then 
    current_blinker_state <= next_blinker_state;
  end if;
end process;

--Controls the behavior of the blinking LED states
--Asynchronous part of the FSM
blink_state_logic : process(clk_state_handler)
begin
  --If no other state isi selected the current state will be maintained 
  next_blinker_state <= current_blinker_state;

  case current_blinker_state is
  when idle_state =>
    --Hold the counter at 0 by pulling reset high
    counter_reset <= '1';
  
    --Use blink_select to go to blink_uniform when '0' and blink_counter when '1'
    if(blink_select = '0') then 
      next_blinker_state <= blink_uniform;
    else
      next_blinker_state <= blink_counter;
      --counter_reset <= '0';
    end if;
    
  --Set behavior to have leds blink uniformly
  when blink_uniform =>
    --Set the LEDs to blink uniformly
    led_out <= (others => clk_led);
    counter_reset <= '1';
    
    --Move to the next state if the blink_select variable goes from '0' -> '1'
    if(blink_select='1') then
      next_blinker_state <= blink_counter;
    end if;
    
  --Set behavior to have LEDs blink a counter
  when blink_counter =>
    --Set the LED to blink according to the current count
    led_out <= current_count;  
    counter_reset <= '0';
    
    --Move to the next state if the blink_select variable goes from '1' -> '0'
    if(blink_select = '0') then
        next_blinker_state <= blink_uniform;
        counter_reset <= '1';
    end if; 
    
    --In case any other type is set for the next_blinker_state variable, go to the idle_state
    when others =>
        next_blinker_state <= idle_state;
        
    end case;
end process;

end Behavioral;
