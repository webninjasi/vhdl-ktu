Library IEEE;
Use IEEE.std_logic_1164.all;
use std.textio.all;
use IEEE.std_logic_textio.all;

Entity eKaydedici is
  Generic(
    dosyaAdi: String
  );
  Port(
    x, y: in integer;
    val, s, clk: in std_logic
  );
End Entity;

Architecture Bhv of eKaydedici is
begin
	process (clk) is
	  variable tick: integer := 0;
	  
    File fCikti: text open WRITE_MODE is dosyaAdi;
    variable satir: line;
	begin
		if rising_edge(clk) then
		  if tick=0 then
		    write(satir, string'("Sayac"), right, 20);
		    write(satir, string'("X"), right, 15);
		    write(satir, string'("Y"), right, 15);
		    write(satir, string'("Deger"), right, 20);
		    writeline(fCikti, satir);
		  end if;
		  
		  if s='1' then
		    write(satir, tick, right, 20);
		    write(satir, x, right, 15);
		    write(satir, y, right, 15);
		    write(satir, val, right, 20);
		    writeline(fCikti, satir);
		  end if;
		  
		  tick := tick + 1;
		end if;
	end process;
End Bhv;
