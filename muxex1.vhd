Library ieee;
use ieee.std_logic_1164.all;

entity eCircuit1 is
  port(
    a: in std_logic;
    b: in std_logic;
    c: in std_logic;
    s: in std_logic;
    f: out std_logic
  );
end;

architecture bhv of eCircuit1 is
begin
  f <= a or c when s = '0' else
       b or c when s = '1';
end;
