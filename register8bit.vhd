Library IEEE;
use IEEE.std_logic_1164.all;

Entity eRegister is
  Generic(n: natural := 8);
  Port(
    D: in std_logic_vector(n-1 downto 0);
    s: in std_logic;
    F: out std_logic_vector(n-1 downto 0)
  );
End Entity eRegister;

Architecture Bhv of eRegister is
begin
  process (s) is
  begin
    if rising_edge(s) then
      F <= D;
    End if;
  End Process;
End Architecture Bhv;
