Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;

Library altera;
Use altera.altera_syn_attributes.all;

Entity eTest is
  Port(
    CLOCK_50: in std_logic;
    KEY: in std_logic_vector(1 downto 0);
    LED: out std_logic_vector(7 downto 0)
  );
End eTest;

Architecture Behavioral of eTest is
  Signal ky: std_logic_vector(7 downto 0) := "00000001";
Begin
  Process
    Variable cnt1: integer range 0 to 50000000;
    Variable cnt2: integer range 0 to 50000000;
  Begin
    Wait Until (CLOCK_50'EVENT) AND (CLOCK_50 = '1');
    
    If cnt1 = 50000000 Then
      cnt1 := 0;
    Else
      cnt1 := cnt1 + 1;
    End If;
    
    Case KEY is
      When "11" => -- Yavas dusus
        If cnt1 > 20000000 Then
          cnt2 := cnt2 - 1;
          LED <= std_logic_vector(to_unsigned(cnt2, 8));
          cnt1 := 0;
        End If;
      When "01" => -- Hizli artis
        If cnt1 > 10000000 Then
          cnt2 := cnt2 + 1;
          LED <= std_logic_vector(to_unsigned(cnt2, 8));
          cnt1 := 0;
        End If;
      When "10" => -- Hizli dusus
        If cnt1 > 10000000 Then
          cnt2 := cnt2 - 1;
          LED <= std_logic_vector(to_unsigned(cnt2, 8));
          cnt1 := 0;
        End If;
      When "00" => -- Yavas artis
        If cnt1 > 20000000 Then
          cnt2 := cnt2 + 1;
          LED <= std_logic_vector(to_unsigned(cnt2, 8));
          cnt1 := 0;
        End If;
      When others =>
    End Case;
  End Process;
End Behavioral;
 