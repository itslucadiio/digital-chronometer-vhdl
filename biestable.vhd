
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity biestable is
    Port ( sortida : out std_logic;
           flang, clk, reset : in std_logic);
end biestable;

architecture Behavioral of biestable is
signal temp: std_logic;
signal q0, q1, q_out : std_logic;
begin

process(clk) begin
if rising_edge(clk) then
    if reset='1' then 
        q0 <= '0';
        q1 <= '1';
    else
        q0 <= flang;
        q1 <= q0;
    end if;
end if;
end process;
q_out <= q0 and not q1;

process(clk) begin
if rising_edge(clk) then
    if reset='1' then temp <= '0';
    elsif q_out='1' then temp <= NOT temp;
    else temp <= temp;
    end if;
end if;
end process;
sortida <= temp;

end Behavioral;
