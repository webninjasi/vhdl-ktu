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
		  ms <= '0'; -- Varsay?lan de?er
		  
		  -- Yazma i?lemi
		  if ws='1' then
		    -- Kaç?r?lan hedefleri tespit et
		    if bellek(wy)(wx)='1' and wdata='0' and okunduMu(wy)(wx)='0' then
		      mx <= wx;
		      my <= wy;
		      ms <= '1';
		    end if;
		    
		    bellek(wy)(wx) <= wdata;
		    okunduMu(wy)(wx) <= '0';
			end if;
			
			-- Okuma i?lemi
      for i in 0 to tarayiciSayisi - 1 loop
        if rs(i) = '1' then
          rdata(i) <= bellek(ry(i))(rx(i));
        end if;
      end loop;
		end if;
	end process;
End Bhv;
