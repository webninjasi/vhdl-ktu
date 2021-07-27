Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.std_logic_unsigned.all;
Use IEEE.std_logic_arith.all;
--Use IEEE.numeric_std.all;

Entity eAdd is
  Generic(n: natural := 4); -- const-like / similar to c macros in that sense
  Port(
    a, b: in std_logic_vector(n-1 downto 0);
    sum: out std_logic_vector(n-1 downto 0);
    carry: out std_logic -- output ports are write-only
  );
End eAdd;

Architecture Bhv of eAdd is
  signal overflow: std_logic_vector(n downto 0);
Begin
    overflow <= ('0' & a) + ('0' & b); -- inserts an addition circuit
    sum <= overflow(n-1 downto 0);
    carry <= overflow(n);
End Bhv;