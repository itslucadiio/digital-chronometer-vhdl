----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2020 12:17:26
-- Design Name: 
-- Module Name: single_count_2 - Behavioral
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

entity single_count_2 is
        port (
           disp : out std_logic_vector(3 downto 0);
           e : out std_logic;
           reset, enable : in  std_logic);
end single_count_2;

architecture Behavioral of single_count_2 is
begin

process(enable, reset)
variable c : integer range 0 to 9 := 0;
begin
if (reset='1') then c := 0;
elsif rising_edge(enable) then
    if c=5 then 
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
