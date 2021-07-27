Library IEEE;
Use IEEE.std_logic_1164.all;

Entity eDecoder_2_4 is
  Port(
    A: in std_logic_vector(1 downto 0);
    F: out std_logic_vector(3 downto 0)
  );
End eDecoder_2_4;

Architecture Bhv of eDecoder_2_4 is
Begin
    -- only concurrent
    F <= "0001" when A = "00" else
         "0010" when A = "01" else
         "0100" when A = "10" else
         "1000" when A = "11" else
         "ZZZZ";
End Bhv;

