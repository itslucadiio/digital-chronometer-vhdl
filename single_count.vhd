----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2020 17:46:13
-- Design Name: 
-- Module Name: single_count - Behavioral
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

entity single_count is
        generic( count : integer := 9);
        port (
           disp : out std_logic_vector(3 downto 0);
           e : out std_logic;
           reset, enable : in  std_logic);
end single_count;

architecture Behavioral of single_count is
begin

process(enable, reset)
variable c : integer range 0 to 9 := 0;
begin
if (reset='1') then c := 0;
elsif rising_edge(enable) then
    if c=count then 
        c := 0;
        e <= '1';
    else 
        c := c + 1;
        e <= '0';
    end if;
end if;
disp <= std_logic_vector(to_unsigned(c, 4));
end process;

end Behavioral;
