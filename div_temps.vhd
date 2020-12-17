----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2020 16:12:53
-- Design Name: 
-- Module Name: div_temps - Behavioral
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

entity div_temps is
        port (
           c0, c1, s0, s1, m0, m1 : out std_logic_vector(3 downto 0);
           clk_div, reset, enable  : in  std_logic);
end div_temps;

architecture Behavioral of div_temps is
    signal disp0, disp1, disp2, disp3, disp4, disp5 : std_logic_vector(3 downto 0);
    signal e0, e1, e2, e3, e4 : std_logic;
    component single_count
        generic(count : integer := 9);
        port (
           disp : out std_logic_vector(3 downto 0);
           e : out std_logic;
           reset, enable : in  std_logic);
    end component;
begin

-- CLK
process(clk_div, reset)
variable c : integer range 0 to 9 := 0;
begin
if reset='1' then c := 0;
elsif (rising_edge(clk_div)) then
    if enable='1' then
        if c=9 then 
            c := 0;
            e0 <= '1';
        else 
            c := c + 1;
            e0 <= '0';
        end if;
    end if;
end if;
c0 <= std_logic_vector(to_unsigned(c, 4));
end process;
-- END


-- COUNTERS
u1: single_count
    generic map(count => 5)
    port map(disp => c1,
             e => e1,
             reset => reset,
             enable => e0);
           
u2: single_count
    generic map(count => 9)
    port map(disp => s0,
             e => e2,
             reset => reset,
             enable => e1);   
             
u3: single_count
    generic map(count => 5)
    port map(disp => s1,
             e => e3,
             reset => reset,
             enable => e2);   
            
u4: single_count
    generic map(count => 9)
    port map(disp => m0,
             e => e4,
             reset => reset,
             enable => e3); 
             
u5: single_count
    generic map(count => 5)
    port map(disp => m1,
             e => open,
             reset => reset,
             enable => e4);           
-- END

end Behavioral;
