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
  
  -- Sinyal Üreticinin ç?kt?lar?n? kaydeder
  ModulK1: eKaydedici
    Generic Map("girdi.txt")
    Port Map(x=>wx, y=>wy, val=>wdata, s=>ws, clk=>clk);
  
  -- Sinyal Üreticiden ald??? koordinat ve de?erleri kaydeder
  -- Ayn? zamanda Taray?c?lardan gelen koordinat de?er isteklerini cevaplar
  -- Taray?c?lar taraf?ndan de?eri istenmeden önce de?i?en koordinatlar? ç?kt? olarak verir
  ModulB1: eBolge
    Generic Map(bellekBoyutu, tarayiciSayisi)
    Port Map(
      wx=>wx, wy=>wy, rx=>rx, ry=>ry,
      wdata=>wdata, ws=>ws, rs=>rs, clk=>clk, rdata=>rdata,
      mx => mx, my => my, ms => ms);
  
  -- Taray?c?lar taraf?ndan kaç?r?lan de?i?iklikleri kaydeder
  ModulK2: eKaydedici
    Generic Map("kacirilan.txt")
    Port Map(x=>mx, y=>my, val=>'1', s=>ms, clk=>clk);
  
  Tarayicilar:
  for i in 0 to tarayiciSayisi - 1 generate
    -- Bölgeye bir koordinat de?er iste?i yollar
    -- E?er ald??? cevap '1' ise bu koordinat? ç?k??a verir
    ModulT: eTarayici
      Generic Map(bellekBoyutu, i)
      Port Map(rx=>rx(i), ry=>ry(i), dx=>dx(i), dy=>dy(i), rs=>rs(i), ds=>ds(i), rdata=>rdata(i), clk=>clk2);
  
    -- De?eri '1' olan koordinatlar? kaydeder
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
  
  -- Taray?c? Saati
  -- Taray?c?lar?n okuma iste?ini sistemin geri kalan?ndan erken göndermesi gerekli
  -- aksi takdirde yanl?? koordinat bilgisini veriyor
  process is
  begin
    clk2 <= not clk2;
    wait for 10 ps;
  end process;
End Bhv;




