Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.std_logic_unsigned.all;
Use IEEE.std_logic_arith.all;

Entity eCounter is
  Generic (n: natural := 8);
  Port(
    s, r: in std_logic;
    F: out std_logic_vector(n-1 downto 0)
  );
End eCounter;

Architecture Bhv of eCounter is
Begin
    process (s, r) is
      variable counter: std_logic_vector(n-1 downto 0) := (others => '0');
    begin
      if rising_edge(r) then
        counter := (others => '0');
      elsif rising_edge(s) then
        counter := counter + 1;
        F <= counter;
      end if;
    end process;
End Bhv;

