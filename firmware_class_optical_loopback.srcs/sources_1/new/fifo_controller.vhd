----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2024 10:33:54 AM
-- Design Name: 
-- Module Name: fifo_controller - Behavioral
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

entity fifo_controller is
    Port (
        clk: in std_logic;
        data_in : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0)
    );
end fifo_controller;

architecture Behavioral of fifo_controller is

component fifo_generator_0 is
    Port (
        rd_clk : in std_logic;
        wr_clk : in std_logic;
        din : in std_logic_vector(7 downto 0);
        dout : out std_logic_vector(7 downto 0);
        wr_en : in std_logic;
        rd_en : in std_logic;
        full : out std_logic;
        empty : out std_logic
    );
end component;

begin

u_fifo_generator_0 : fifo_generator_0
    port map (
        rd_clk => clk,
        wr_clk => clk,
        din => data_in,
        dout => data_out,
        wr_en => '1',
        rd_en => '1',
        full => open,
        empty => open
    );

end Behavioral;
