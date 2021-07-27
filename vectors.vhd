Library IEEE;
Use IEEE.std_logic_1164.all;

Entity eVect1 is
  Generic(n: natural := 8);
  Port(
    a: in std_logic_vector(1 to 8) := "10000000";
    --_s: in std_logic; -- invalid variable name
    s: in std_logic;
    f: out std_logic
  );
End eVect1;

Architecture Bhv of eVect1 is
Begin
   f <= a(1);
   process 
     constant zzz : integer := 1;
   begin
     wait on s;
   end process;
End Bhv;

