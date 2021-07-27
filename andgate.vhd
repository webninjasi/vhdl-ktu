Library IEEE;
Use IEEE.std_logic_1164.all;

Entity eVe is
  Port(
    a: in std_logic;
    b: in std_logic;
    f: out std_logic
  );
End eVe;

Architecture Bhv of eVe is
Begin
    f <= a and b;
End Bhv;
