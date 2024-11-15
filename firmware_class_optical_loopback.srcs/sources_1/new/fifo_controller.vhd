----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/11/2024 10:32:55 AM
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
        clk : in STD_LOGIC;
        clk_double: in STD_LOGIC;
        clk_half : in STD_LOGIC;
        data_in : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0);
        data_out_double : out std_logic_vector(7 downto 0);
        data_out_half : out std_logic_vector(7 downto 0);
        full : out std_logic_vector(2 downto 0);
        empty : out std_logic_vector(2 downto 0)
    );
end fifo_controller;



architecture Behavioral of fifo_controller is


component fifo_generator_0 is 
port(
    rd_clk : in std_logic;
    wr_clk : in std_logic;
    din    : in std_logic_vector(7 downto 0);
    dout   : out std_logic_vector(7 downto 0);
    wr_en  : in std_Logic;
    rd_en  : in std_logic;
    full   : out std_Logic;
    empty  : out std_Logic;
    srst : in std_logic;
    wr_rst_busy : out std_logic;
    rd_rst_busy : out std_logic
);
end component;


begin

u_fifo_generator : fifo_generator_0 
port map(
    rd_clk => clk,
    wr_clk => clk,
    din    => data_in,
    dout   => data_out,
    wr_en  => '1',
    rd_en  => '1',
    full   => full(0),
    empty  => empty(0),
    srst   => '0',
    wr_rst_busy => open,
    rd_rst_busy => open
);

u_fifo_generator_double : fifo_generator_0 
port map(
    rd_clk => clk_double,
    wr_clk => clk,
    din    => data_in,
    dout   => data_out_double,
    wr_en  => '1',
    rd_en  => '1',
    full   => full(1),
    empty  => empty(1),
    srst   => '0',
    wr_rst_busy => open,
    rd_rst_busy => open
);

u_fifo_generator_half : fifo_generator_0 
port map(
    rd_clk => clk_half,
    wr_clk => clk,
    din    => data_in,
    dout   => data_out_half,
    wr_en  => '1',
    rd_en  => '1',
    full   => full(2),
    empty  => empty(2),
    srst   => '0',
    wr_rst_busy => open,
    rd_rst_busy => open
);



end Behavioral;
