Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

Entity eXNor is
  Generic (n: natural := 8);
  Port(
    A: in std_logic_vector(n-1 downto 0);
    B: in std_logic_vector(n-1 downto 0);
    F: out std_logic_vector(n-1 downto 0)
  );
End Entity;

Architecture Bhv of eXNor is
begin
  F <= A xnor B;
End Architecture;
