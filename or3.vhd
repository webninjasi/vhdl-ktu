Library IEEE;
Use IEEE.std_logic_1164.all;

Entity eOr3 is
  Port (
    a, b, c: in std_logic;
    f: out std_logic
  );
End Entity eOr3;

Architecture Bhv of eOr3 is 
Begin
  f <= a or b or c;
End Architecture Bhv;
