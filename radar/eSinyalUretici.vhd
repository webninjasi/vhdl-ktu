Library IEEE;
Use IEEE.std_logic_1164.all;
use std.textio.all;
use IEEE.std_logic_textio.all;
use IEEE.math_real.all;

Entity eSinyalUretici is
  Generic(
    bolgeBoyutu: natural := 128
  );
  Port(
    wx, wy: out integer;
    wdata, ws: out std_logic;
    clk: in std_logic
  );
End Entity;

Architecture Bhv of eSinyalUretici is
  procedure rastgele(
    variable s1, s2: inout positive;
    variable val: inout real;
    constant max: in real;
    variable ret: out integer) is
  begin
    uniform(s1, s2, val);
    ret := integer(val*max);
  end procedure;
begin
	process (clk) is
	  variable cx: integer := 0;
	  variable cy: integer := 0;
	  variable cval: integer;
	  
    variable s1, s2: positive := 1 + (now / 1 ns);
    variable val: real;
	begin
		if rising_edge(clk) then
		  -- Rastgele koordinatlar? ve de?eri olu?turur
		  rastgele(s1, s2, val, real(bolgeBoyutu-1), cx);
		  rastgele(s1, s2, val, real(bolgeBoyutu-1), cy);
		  rastgele(s1, s2, val, real(1.0), cval);
		  
		  wx <= cx;
		  wy <= cy;
		  
		  if cval=1 then
		    wdata <= '1';
		  else
		    wdata <= '0';
		  end if;
		  
		  ws <= '1';
		end if;
	end process;
End Bhv;
