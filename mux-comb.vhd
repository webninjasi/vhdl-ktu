Library IEEE;
Use IEEE.std_logic_1164.all;

Entity eMux is
  Port(
    a, b: in std_logic;
    s: in std_logic;
    f: out std_logic
  );
End eMux;

Architecture Bhv of eMux is
Begin
    f <= a when s = '0' else
         b when s = '1' else
         'Z';
End Bhv;

Architecture Bhv2 of eMux is
Begin
    with s select f <= a when '0', b when '1', 'Z' when others; -- Z = open circuit
End Bhv2;

-- Sequential
Architecture Bhv3Seq of eMux is
Begin
    process (a, b, s) is
    begin
      if s='1' then
        f <= a;
      elsif s='0' then
        f <= b;
      else
        f <= 'Z';
      end if;
    end process;
End Bhv3Seq;

