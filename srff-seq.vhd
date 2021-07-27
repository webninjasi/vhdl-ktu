Library IEEE;
Use IEEE.std_logic_1164.all;

Entity eSRFF is
  Port(
    a, b, s: in std_logic;
    f: out std_logic
  );
End eSRFF;

Architecture Bhv of eSRFF is
  -- no variables here
Begin
   process (s)
     variable k : std_logic;
     -- no signals here
   begin
      if falling_edge(s) then -- rising_edge(s)
        k := a or (not(b) and k);
        f <= k;
      end if;
   end process;
End Bhv;
