Library IEEE;
use IEEE.std_logic_1164.all;

Entity eRotator is
  Generic(N: natural := 8);
  Port(
    A: in std_logic_vector(N-1 downto 0);
    l: in std_logic;
    rotleft: in std_logic;
    rotright: in std_logic;
    s: in std_logic;
    F: out std_logic_vector(N-1 downto 0)
  );
End Entity eRotator;

Architecture bhv of eRotator is
begin
  process (s, l)
    variable Y : std_logic_vector(N-1 downto 0) := (others => 'Z');
  begin
    if rising_edge(l) then
      Y := A;
    elsif rising_edge(s) then
      if rotleft = '1' then
        Y := Y(N-2 downto 0) & Y(N-1);
      end if;
      if rotright = '1' then
        Y := Y(0) & Y(N-1 downto 1);
      end if;
    end if;
    
    F <= Y;
  end process;
End Architecture bhv;

