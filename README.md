<h2 align="center">Digital Chronometer in VHDL</h2>

The aim of this project is to describe and implement a digital chronometer in the FPGA of the Basys 3 card. The main characteristics of this project are described below:

- We will use the built-in 100 Mhz oscillator as the clock signal source.
- The count value will be shown on the 4 7-segment displays of the Basys III.
- There will be two possible formats to show the counting value for the displays, of which we will choose one using one of the switches on the card: MM:SS or SS:CC.
- Another push-button will have the function of LAP, with which we will be able to visualize a partial time while internally the chronometer is advancing. When this button is pressed, the display will stop until we press it again, at which point we will display the current moving time again.
- Finally, a button will allow us to view the last part-time stored. This value will be displayed on the displays as long as the pushbutton remains on.

## Table of contents

- [Main Project](#Main-project)

## Main Project

This is the the top-level entity of the project. In other words, it is the central project of the digital chronometer. The entity will have the following description of its inputs and outputs:

````VHDL
entity pract5 is 
  Port (A, B, C, D: in std_logic; 
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        cat : out STD_LOGIC_VECTOR (7 downto 0); 
        an : out STD_LOGIC_VECTOR (3 downto 0)
       );
end pract5;
````

It is necessary to emphasize a process whose function will be to save in an internal signal the value corresponding to the current account of the chronometer when the LAP button is pressed and the bistable enables the process.

````VHDL
process(save_lap)
  variable count : integer;
begin
if save_lap=’1’ then
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
````

We can see that this process saves the chronometer values into a variable named lap_rec. This variable is defined as follows:

````VHDL
type lap_rec_type is record
dm, m, ds, s, dc, c : std_logic_vector (3 downto 0); 
end record;
signal lap_rec : lap_rec_type;
````

For the display of time on the displays, another process will be used that will determine the values of the count to be displayed on each display depending on whether you want to display in MM:SS, SS:CC or you want to display an LAP or LAST LAP stored.

````VHDL
process(ms_sc, save_lap) begin 
case ms_sc is
  when ’0’ =>
    if save_lap=’1’ or last_lap =’1’ then
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
    if save_lap=’1’ or last_lap =’1’ then 
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
````

## Copyright and license

Code and documentation copyright 2020–2030 of Luca Di Iorio. Docs released under [Creative Commons](https://creativecommons.org/licenses/by/3.0/).


