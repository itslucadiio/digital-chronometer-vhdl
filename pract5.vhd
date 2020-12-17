----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2020 17:25:56
-- Design Name: 
-- Module Name: pract5 - Behavioral
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

entity pract5 is
    Port (
        A, B, C, D: in std_logic;
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        cat : out STD_LOGIC_VECTOR (7 downto 0);
        an : out STD_LOGIC_VECTOR (3 downto 0)
    );
end pract5;

architecture Behavioral of pract5 is

    signal clk_div_count: std_logic;
    signal clk_div: std_logic;
    signal ms_sc : std_logic := '0';
    signal disp0, disp1, disp2, disp3, disp4, disp5 : std_logic_vector(3 downto 0);
    signal c0, c1, s0, s1, m0, m1 : std_logic_vector(3 downto 0);
    signal count_enable : std_logic := '0';
    type lap_rec_type is record
    dm, m, ds, s, dc, c : std_logic_vector(3 downto 0);
    end record;
    signal lap_rec : lap_rec_type;
    signal save_lap, last_lap : std_logic := '0';
    
    -- CLK DIVIDERS
    component clk_divider
    generic(eoc: integer := 1000000);
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_div : out STD_LOGIC);
    end component;
    component div_temps
        port (
           c0, c1, s0, s1, m0, m1 : out std_logic_vector(3 downto 0);
           clk_div, reset, enable  : in  std_logic);
    end component;
    -- END
    
    
    -- BIESTABLE
    component biestable
        Port ( sortida : out std_logic;
               flang, clk, reset : in std_logic);
    end component;
    -- END
    
    
    -- SEG CODER
    component seg7_coder
    Port ( char0 : in STD_LOGIC_VECTOR (3 downto 0);
           char1 : in STD_LOGIC_VECTOR (3 downto 0);
           char2 : in STD_LOGIC_VECTOR (3 downto 0);
           char3 : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           clk_div : in STD_LOGIC;
           cat : out STD_LOGIC_VECTOR (7 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    -- END

begin

-- DIVISOR DE SENYAL DE RELLOTGE
u1: clk_divider
    generic map (eoc => 1000000)
    port map (clk => clk,
              reset => reset,
              clk_div => clk_div_count);
u2: clk_divider
    generic map (eoc => 100000)
    port map (clk => clk,
              reset => reset,
              clk_div => clk_div);
              
-- DIVISIÓ DE LES UNITATS DE TEMPS
u4: div_temps
    port map(c0 => c0,
             c1 => c1,
             s0 => s0,
             s1 => s1,
             m0 => m0,
             m1 => m1,
             clk_div => clk_div_count,
             reset => reset,
             enable => count_enable);
             
-- START/STOP
u5: biestable
    port map(sortida => count_enable,
             flang => A,
             clk => clk,
             reset => reset);
             
-- MODE DE VISUALITZACIO
u6: biestable
    port map(sortida => ms_sc,
             flang => B,
             clk => clk,
             reset => reset);
-- END

-- LAP i LASTLAP
u7: biestable
    port map(sortida => save_lap,
             flang => C,
             clk => clk,
             reset => reset);
             
process(save_lap)
variable count : integer;
begin
if save_lap='1' then
    if count=0 then
        lap_rec.c <= c0;
        lap_rec.dc <= c1;
        lap_rec.s <= s0;
        lap_rec.ds <= s1;
        lap_rec.m <= m0;
        lap_rec.dm <= m1;
    else count := count + 1;
    end if;
else count := 0;
end if;
end process;

u8: biestable
    port map(sortida => last_lap,
             flang => D,
             clk => clk,
             reset => reset);
-- END


-- 08. VISUALITZACIO DEL TEMPS ALS DIPLAYS
process(ms_sc, save_lap) begin
case ms_sc is
    when '0' => 
        if save_lap='1' or last_lap='1' then
            disp0 <= lap_rec.c;
            disp1 <= lap_rec.dc;
            disp2 <= lap_rec.s;
            disp3 <= lap_rec.ds;
        else
            disp0 <= c0;
            disp1 <= c1;
            disp2 <= s0;
            disp3 <= s1;
        end if;
    when others =>
        if save_lap='1' or last_lap='1' then
            disp0 <= lap_rec.s;
            disp1 <= lap_rec.ds;
            disp2 <= lap_rec.m;
            disp3 <= lap_rec.dm;
        else
            disp0 <= s0;
            disp1 <= s1;
            disp2 <= m0;
            disp3 <= m1;
        end if;
end case;
end process;
-- END


-- 09. CODIFICADOR A 7 SGMENTS
u3: seg7_coder
    port map (char0 => disp0,
                char1 => disp1,
                char2 => disp2,
                char3 => disp3,
                clk => clk,
                reset => reset,
                clk_div => clk_div,
                cat => cat,
                an => an);
-- END

end Behavioral;
