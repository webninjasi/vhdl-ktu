Library IEEE;
Use IEEE.std_logic_1164.all;

Entity eDeMux is
  Generic (n: natural := 8);
  Port(
    A: in std_logic_vector(n-1 downto 0);
    S: in std_logic_vector(1 downto 0); -- 2 bits
    F0, F1, F2, F3: out std_logic_vector(n-1 downto 0)
  );
End eDeMux;

Architecture Bhv of eDeMux is
Begin
    F0 <= A when S="00" else "ZZ";
    F1 <= A when S="01" else "ZZ";
    F2 <= A when S="10" else "ZZ";
    F3 <= A when S="11" else "ZZ";
End Bhv;
