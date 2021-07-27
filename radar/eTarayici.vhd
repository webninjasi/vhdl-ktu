Library IEEE;
Use IEEE.std_logic_1164.all;

Entity eTarayici is
  Generic(
    bellekBoyutu: natural := 128;
    baslangicY: integer := 0
  );
  Port(
    rx, ry, dx, dy: out integer;
    rs, ds: out std_logic;
    rdata, clk: in std_logic
  );
End Entity;

Architecture Bhv of eTarayici is
begin
	process (clk) is
	  variable sayacx: integer := 0; -- Sat?r atlayabilmek için range de?il
	  variable sayacy: integer range 0 to bellekBoyutu - 1 := baslangicY;
	  
	  variable oncekix: integer := 0;
	  variable oncekiy: integer := 0;
	begin
		if rising_edge(clk) then
		  -- Cevap '1' ise koordinat? ç?k??a ver
		  if rdata='1' then
		    dx <= oncekix;
		    dy <= oncekiy;
		    ds <= '1';
		  else
		    ds <= '0';
		  end if;
		  
		  -- Vektör sonuna gelince sat?r atla
		  if sayacx=bellekBoyutu then
		    sayacx := 0;
		    sayacy := sayacy + 1;
		  end if;
		  
		  -- Koordinat de?er iste?i gönder
		  rx <= sayacx;
		  ry <= sayacy;
		  rs <= '1';
		  
		  -- Cevap al?nca kullanmak üzere koordinat? kaydet
		  oncekix := sayacx;
		  oncekiy := sayacy;
		  
		  -- Bir sonraki vektör indeksine geç
		  sayacx := sayacx + 1;
		end if;
	end process;
End Bhv;


