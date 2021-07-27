Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.numeric_bit.all;

entity eCaesarEncoder is
  port(
    enable: in std_logic;
    shift: in std_logic_vector(5 downto 0);
    char: in std_logic_vector(6 downto 0); -- character
    result: out std_logic_vector(6 downto 0)
  );
end entity;

architecture bhv of eCaesarEncoder is
  --type shiftNum is range -26 to 26;
begin
  process (enable)
    variable inp: std_logic_vector(6 downto 0);
  begin
    if enable='1' then
      inp := char;
      
      -- 65-90 97-122
      if inp(6) = '1'
        and inp /= "1000000"
        and inp /= "1011011"
        and inp /= "1011100"
        and inp /= "1011101"
        and inp /= "1011110"
        and inp /= "1011111"
        and inp /= "1100000"
        and inp /= "1111011"
        and inp /= "1111100"
        and inp /= "1111101"
        and inp /= "1111110"
        and inp /= "1111111"
        then
        if inp(5) = '1' then
          inp := std_logic_vector(to_unsigned(97 + (to_integer(unsigned(inp)) - 97 + to_integer(signed(shift))) mod 26, 7));
          result <= inp;
        else
          inp := std_logic_vector(to_unsigned(65 + (to_integer(unsigned(inp)) - 65 + to_integer(signed(shift))) mod 26, 7));
          result <= inp;
          
          --result(0) <= inp(0) xor shift(0);
          --result(1) <= inp(1);
          --result(2) <= inp(2);
          --result(3) <= inp(3);
          --result(4) <= inp(4);
          --result(5) <= inp(5);
          --result(6) <= inp(6);
        end if;
      else
        result <= inp;
      end if;
    end if;
  end process;
end architecture;
