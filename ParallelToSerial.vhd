Library IEEE;
use IEEE.std_logic_1164.all;

Entity ePokuSyaz is
  Generic(n: natural := 8);
  Port(
    s, l: in std_logic;
    A: in std_logic_vector(n-1 downto 0);
    f: out std_logic
  );
End Entity ePokuSyaz;
  
Architecture Bhv of ePokuSyaz is
  signal Y: std_logic_vector(n-1 downto 0);
begin
  process (s, l) is
  begin
    if rising_edge(l) then
      Y <= A;
    elsif s'Event and s='1' then -- rising_edge(s)
      f <= Y(n-1);
      Y <= Y(n-2 downto 0) & '0';
    end if;
  end process;  
End Architecture Bhv;
