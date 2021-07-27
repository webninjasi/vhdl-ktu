Library IEEE;
use IEEE.std_logic_1164.all;

-- Chocolate machine of some sort?

Entity eCikolata is
  Port(
    s: in std_logic; -- clock
    g: in std_logic;
    f: out std_logic
  );
End Entity eCikolata;

Architecture bhv of eCikolata is
  Type tState is (BSL, K25, K50, K75);
  signal durum: tState := BSL;
begin
  process (s) is
  begin
    if rising_edge(s) then
      case durum is
      when BSL =>
        if g='0' then
          f <= '0';
          durum <= K25;
        elsif g='1' then
          f <= '0';
          durum <= K50;
        end if;
      when K25 =>
        if g='0' then
          f <= '0';
          durum <= K50;
        elsif g='1' then
          f <= '0';
          durum <= K75;
        end if;
      when K50 =>
        if g='0' then
          f <= '0';
          durum <= K75;
        elsif g='1' then
          f <= '1';
          durum <= BSL;
        end if;
      when K75 =>
        if g='0' then
          f <= '1';
          durum <= BSL;
        elsif g='1' then
          f <= '1';
          durum <= K25;
        end if;
      end case;
    end if;
  end process;
End Architecture bhv;
