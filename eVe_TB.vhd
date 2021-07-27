Library IEEE;
use IEEE.std_logic_1164.all;
--use work.eVe.all;

Entity eVe_TB is
End;

Architecture bhv of eVe_TB is
  signal ta, tb, tf : std_logic := '0';
  
  Component eVe is
    Port(
      a, b: in std_logic;
      f: out std_logic
    );
  End Component;
begin
  process is
  begin 
    ta <= not(ta);
    wait for 50 ps;
  end process;
  
  process is
  begin 
    tb <= not(tb);
    wait for 100 ps;
  end process;
  
  Modul1: eVe Port Map(
     a=>ta,
     b=>tb,
     f=>tf
    );
  -- eVe Port Map(ta, tb, tf);
  
  --EXAMPLE ONLY (WONT WORK PROPERLY)
  --Assert (tf=(ta and tb))
  --  Report "hatali devre!"
  --Severity failure; -- note/warning/error/failure
  
  --tf <= ta and tb;
End;
