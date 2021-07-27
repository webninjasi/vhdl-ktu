Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.std_logic_unsigned.all;
Use IEEE.std_logic_arith.all;

Entity eALU is
  Generic(n: natural := 4);
  Port(
    A, B: in std_logic_vector(n-1 downto 0);
    cmd: in std_logic_vector(1 downto 0);
    F: out std_logic_vector(n-1 downto 0)
  );
End Entity eALU;

Architecture Bhv of eALU is
Begin
  with cmd select
    F <= (A + B) when "00",
         (A - B) when "01",
         (A and B) when "10",
         (A or B) when "11",
         (others => 'Z') when others;
  
  -- Alternative
--  F <= (A + B) when cmd="00" else
--       (A - B) when cmd="01" else
--       (A and B) when cmd="10" else
--       (A or B) when cmd="11" else
--       (others => 'Z');
End Architecture Bhv;
