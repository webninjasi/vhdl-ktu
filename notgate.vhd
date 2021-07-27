Library IEEE;
Use IEEE.std_logic_1164.all;

Entity eDegil is
  Port(
    a: in std_logic;
    f: out std_logic
  );
End eDegil;

Architecture Bhv of eDegil is
  signal b: std_logic;
Begin
    b <= not(a);
    f <= b;
End Bhv;
