Library IEEE;
Use IEEE.std_logic_1164.all;

Entity eEncoder_4_2 is
  Port(
    A: in std_logic_vector(3 downto 0);
    F: out std_logic_vector(1 downto 0)
  );
End eEncoder_4_2;

Architecture Bhv of eEncoder_4_2 is
Begin
    -- only concurrent vvv
    F <= "00" when A = "0001" else
         "01" when A = "0010" else
         "10" when A = "0100" else
         "11" when A = "1000" else
         "ZZ";
End Bhv;