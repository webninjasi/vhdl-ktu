--- script.tcl

--vcom Proje.txt
--vsim work.eRadar
--add wave *
--run 100 ns
--notepad girdi.txt
--notepad kacirilan.txt

--- pBolge.vhd

Library IEEE;
Use IEEE.std_logic_1164.all;

Package pBolge is
  Type tBolgeKoord is array(natural range <>) of integer;
End pBolge;

--- eKaydedici.vhd

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

--- eSinyalUretici.vhd

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
		  -- Rastgele koordinatlari ve degeri olusturur
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

--- eBolge.vhd

Library IEEE;
Use IEEE.std_logic_1164.all;
Use work.pBolge.all;

Entity eBolge is
  Generic(
    boyut: natural := 128;
    tarayiciSayisi: natural := 10
  );
  Port(
    wx, wy: in integer;
    rx, ry: in tBolgeKoord(0 to tarayiciSayisi-1);
    rs: in std_logic_vector(0 to tarayiciSayisi - 1);
    wdata, ws, clk: in std_logic;
    mx, my: out integer;
    ms: out std_logic;
    rdata: out std_logic_vector(0 to tarayiciSayisi - 1)
  );
End Entity;

Architecture Bhv of eBolge is
  Type tRAM is array(0 to boyut-1) of std_logic_vector(0 to boyut-1);
  signal bellek: tRAM := (others => (others => '0'));
  signal okunduMu: tRAM := (others => (others => 'Z'));
begin
	process (clk) is
	begin
		if rising_edge(clk) then
		  ms <= '0'; -- Varsayilan deger
		  
		  -- Yazma islemi
		  if ws='1' then
		    -- Kaçirilan hedefleri tespit et
		    if bellek(wy)(wx)='1' and wdata='0' and okunduMu(wy)(wx)='0' then
		      mx <= wx;
		      my <= wy;
		      ms <= '1';
		    end if;
		    
		    bellek(wy)(wx) <= wdata;
		    okunduMu(wy)(wx) <= '0';
			end if;
			
			-- Okuma islemi
      for i in 0 to tarayiciSayisi - 1 loop
        if rs(i) = '1' then
          rdata(i) <= bellek(ry(i))(rx(i));
        end if;
      end loop;
		end if;
	end process;
End Bhv;

--- eTarayici.vhd

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
	  variable sayacx: integer := 0; -- Satir atlayabilmek için range degil
	  variable sayacy: integer range 0 to bellekBoyutu - 1 := baslangicY;
	  
	  variable oncekix: integer := 0;
	  variable oncekiy: integer := 0;
	begin
		if rising_edge(clk) then
		  -- Cevap '1' ise koordinati çikisa ver
		  if rdata='1' then
		    dx <= oncekix;
		    dy <= oncekiy;
		    ds <= '1';
		  else
		    ds <= '0';
		  end if;
		  
		  -- Vektör sonuna gelince satir atla
		  if sayacx=bellekBoyutu then
		    sayacx := 0;
		    sayacy := sayacy + 1;
		  end if;
		  
		  -- Koordinat deger istegi gönder
		  rx <= sayacx;
		  ry <= sayacy;
		  rs <= '1';
		  
		  -- Cevap alinca kullanmak üzere koordinati kaydet
		  oncekix := sayacx;
		  oncekiy := sayacy;
		  
		  -- Bir sonraki vektör indeksine geç
		  sayacx := sayacx + 1;
		end if;
	end process;
End Bhv;

--- eRadar.vhd

Library IEEE;
Use IEEE.std_logic_1164.all;
Use work.pBolge.all;

Entity eRadar is
  Generic(
    bellekBoyutu: natural := 128;
    tarayiciSayisi: natural := 10
  );
End Entity;

Architecture Bhv of eRadar is
  Component eKaydedici is
    Generic(
      dosyaAdi: String
    );
    Port(
      x, y: in integer;
      val, s, clk: in std_logic
    );
  End Component;
  
  Component eSinyalUretici is
    Generic(
     bolgeBoyutu: natural
    );
    Port(
      wx, wy: out integer;
      wdata, ws: out std_logic;
      clk: in std_logic
    );
  End Component;
  
  Component eBolge is
    Generic(
      boyut: natural;
      tarayiciSayisi: natural
    );
    Port(
      wx, wy: in integer;
      rx, ry: in tBolgeKoord(0 to tarayiciSayisi - 1);
      rs: in std_logic_vector(0 to tarayiciSayisi - 1);
      wdata, ws, clk: in std_logic;
      mx, my: out integer;
      ms: out std_logic;
      rdata: out std_logic_vector(0 to tarayiciSayisi - 1)
    );
  End Component;

  Component eTarayici is
    Generic(
      bellekBoyutu: natural;
      baslangicY: integer
    );
    Port(
      rx, ry, dx, dy: out integer;
      rs, ds: out std_logic;
      rdata, clk: in std_logic
    );
  End Component;
  
  signal wx, wy, mx, my: integer;
  signal rx, ry, dx, dy: tBolgeKoord(0 to tarayiciSayisi - 1);
  signal rdata, rs, ds: std_logic_vector(0 to tarayiciSayisi - 1);
  signal wdata, ws, ms: std_logic;
  signal clk, clk2: std_logic := '0';
begin
  -- "Rastgele" koordinat ve 1/0 de?eri üretir
  ModulU1: eSinyalUretici
    Generic Map(bellekBoyutu)
    Port Map(wx=>wx, wy=>wy, wdata=>wdata, ws=>ws, clk=>clk);
  
  -- Sinyal Üreticinin çiktilarini kaydeder
  ModulK1: eKaydedici
    Generic Map("girdi.txt")
    Port Map(x=>wx, y=>wy, val=>wdata, s=>ws, clk=>clk);
  
  -- Sinyal Üreticiden aldigi koordinat ve degerleri kaydeder
  -- Ayni zamanda Tarayicilardan gelen koordinat deger isteklerini cevaplar
  -- Tarayicilar tarafindan de?eri istenmeden önce degisen koordinatlari çikti olarak verir
  ModulB1: eBolge
    Generic Map(bellekBoyutu, tarayiciSayisi)
    Port Map(
      wx=>wx, wy=>wy, rx=>rx, ry=>ry,
      wdata=>wdata, ws=>ws, rs=>rs, clk=>clk, rdata=>rdata,
      mx => mx, my => my, ms => ms);
  
  -- Tarayicilar tarafindan kaçirilan degisiklikleri kaydeder
  ModulK2: eKaydedici
    Generic Map("kacirilan.txt")
    Port Map(x=>mx, y=>my, val=>'1', s=>ms, clk=>clk);
  
  Tarayicilar:
  for i in 0 to tarayiciSayisi - 1 generate
    -- Bölgeye bir koordinat deger istegi yollar
    -- Eger aldigi cevap '1' ise bu koordinat? çikisa verir
    ModulT: eTarayici
      Generic Map(bellekBoyutu, i)
      Port Map(rx=>rx(i), ry=>ry(i), dx=>dx(i), dy=>dy(i), rs=>rs(i), ds=>ds(i), rdata=>rdata(i), clk=>clk2);
  
    -- Degeri '1' olan koordinatlari kaydeder
    ModulK3: eKaydedici
      Generic Map("cikti" & integer'image(i) & ".txt")
      Port Map(x=>dx(i), y=>dy(i), val=>'1', s=>ds(i), clk=>clk2);
  end generate Tarayicilar;
  
  -- Sistem saati
  process is
  begin
    wait for 10 ps;
    clk <= not clk;
  end process;
  
  -- Tarayici Saati
  -- Tarayicilarin okuma istegini sistemin geri kalanindan erken göndermesi gerekli
  -- aksi takdirde yanlis koordinat bilgisini veriyor
  process is
  begin
    clk2 <= not clk2;
    wait for 10 ps;
  end process;
End Bhv;
