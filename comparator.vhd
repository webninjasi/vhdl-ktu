Library IEEE;
Use IEEE.std_logic_1164.all;

Entity eComparator is
  Generic(n: natural := 4);
  Port(
    a, c: in std_logic_vector(n-1 downto 0);
    b, e, s: out std_logic
  );
End eComparator;

Architecture Bhv of eComparator is
Begin
    b <= '1' when a > c else '0';
    e <= '1' when a = c else '0';
    s <= '1' when a < c else '0';
End Bhv;
