----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/06/2024 06:34:00 PM
-- Design Name: 
-- Module Name: slow_clock - Behavioral
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

entity slow_clock is
    Generic( count_max_width : integer := 26);
    Port ( clk_in : in STD_LOGIC;
           count_max : in unsigned(count_max_width downto 0); --Count max is based off of the fact that clk_in is expecting a 125 MHz clock
           clk_out_slow : out STD_LOGIC);
end slow_clock;

architecture Behavioral of slow_clock is

signal count : unsigned(26 downto 0) := (others => '0');
signal clk_out_slow_int : std_logic := '0';

begin

clk_out_slow <= clk_out_slow_int;

count_to_max : process(clk_in)
begin
if(rising_edge(clk_in)) then
    if( count < count_max) then
        count <= count + 1;
    else 
        count <= (others => '0');
        clk_out_slow_int <= not clk_out_slow_int;
    end if;
end if;

end process;




end Behavioral;
