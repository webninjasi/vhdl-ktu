---
-- eDegil
--
-- returns the logical inverse of the input
---

library IEEE, std;
use IEEE.std_logic_1164.all;

entity eDegil is
  port(
    a: in std_logic;
    f: out std_logic
  );
end;

architecture bhv of eDegil is
begin
  f <= not(a);
end;

-- A: std_logic_vector(7 downto 0);
-- F: std_logic_vector(7 downto 0)
-- F <= not(A)
-- F(0) <= not(A(0))

---
-- eTumlesik1
--
-- returns second input if first input is logic-1, otherwise returns third input
---

library IEEE, std;
use IEEE.std_logic_1164.all;

entity eTumlesik1 is
  port(
    a, b, c: in std_logic;
    f: out std_logic
  );
end;

architecture bhv of eTumlesik1 is
  signal k: std_logic;
begin
  -- concurrent execution
  f <= k or c;
  k <= a and b;
end;
