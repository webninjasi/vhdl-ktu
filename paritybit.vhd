Library IEEE;
Use IEEE.std_logic_1164.all;

Entity eParity is
  Port(
    A: in std_logic_vector(7 downto 0); -- vektorler icin buyuk harf standart
    op, ep: out std_logic
  );
End eParity;

Architecture Bhv of eParity is
  signal p: std_logic;
Begin
    p <= A(0) xor
         A(1) xor
         A(2) xor
         A(3) xor
         A(4) xor
         A(5) xor
         A(6) xor
         A(7);
    ep <= p;
    op <= not(p);
End Bhv;