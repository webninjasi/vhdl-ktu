Library IEEE, std;
Use IEEE.std_logic_1164.all;
Use IEEE.std_logic_unsigned.all;
Use IEEE.std_logic_arith.all;

Entity eROM is
  Port(
    s, r, oku: in std_logic;
    Addr: in std_logic_vector(4 downto 0);
    F: out std_logic_vector(7 downto 0)
  );
End Entity eROM;

Architecture bhv of eROM is
  Type ROMArray is array(0 to 31) of std_logic_vector(7 downto 0);
  Constant ROMMem: ROMArray := (
    0 => "01000001",
    1 => "01000010",
    2 => "01000011",
    3 => "01000100",
    4 => "01000101",
    5 => "01000110",
    6 => "01000111",
    7 => "01001000",
    8 => "01001001",
    9 => "01001010",
    others => "00000000"
  );
begin
  process (s, r, oku) is
  begin
    if r='1' then
      F <= "ZZZZZZZZ";
    elsif rising_edge(s) then
      if oku='1' then
        F <= ROMMem(conv_integer(Addr));
      else
        F <= "ZZZZZZZZ";
      end if;
    end if;
  end process;
End Architecture bhv;


