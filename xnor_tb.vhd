Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

Entity eXNor_TB is
  Generic(tn: natural := 8);
End Entity;

Architecture Bhv of eXNor_TB is
  signal TA: std_logic_vector(tn-1 downto 0) := (others => '0');
  signal TB: std_logic_vector(tn-1 downto 0) := (others => '1');
  signal TF: std_logic_vector(tn-1 downto 0);
  
  Component eXNor is
    Generic(n: natural);
    Port(
      A: in std_logic_vector(n-1 downto 0);
      B: in std_logic_vector(n-1 downto 0);
      F: out std_logic_vector(n-1 downto 0)
    );
  End Component;
begin
  Modul1: eXNor
    Generic Map(n => tn)
    Port Map(TA, TB, TF);
  
  TAInc: process is
  begin
    TA <= TA + 1;
    wait for 10 ns;
  end process;
  
  TBDec: process is
  begin
    TB <= TB - 1;
    wait for 15 ns;
  end process;
End Architecture;
