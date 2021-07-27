Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
--use work.eAdd.all;

Entity eAdd_TB is
    Generic(tn: natural := 8);
End;

Architecture bhv of eAdd_TB is
  signal ta : std_logic_vector(tn-1 downto 0) := "11111111";
  signal tb : std_logic_vector(tn-1 downto 0) := "00000000";
  signal tsum : std_logic_vector(tn-1 downto 0) := (others => '0');
  signal tcarry : std_logic := '0';
  
  Component eAdd is
    Generic(n: natural);
    Port(
      a, b: in std_logic_vector(tn-1 downto 0);
      sum: out std_logic_vector(tn-1 downto 0);
      carry: out std_logic
    );
  End Component;
begin
  Modul1: eAdd
    Generic Map(n => tn)
    Port Map(ta, tb, tsum, tcarry);
  
  process is
  begin
    ta <= (ta - 1);
    wait for 2 ns;
  end process;
  
  process is
  begin
    tb <= (tb + 1);
    wait for 3 ns;
  end process;
End;

