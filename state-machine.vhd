Library IEEE;
use IEEE.std_logic_1164.all;

Entity eStateMac is
  Port(
    s: in std_logic;
    I: in std_logic_vector(1 downto 0);
    f: out std_logic
  );
End Entity eStateMac;

Architecture bhv of eStateMac is
  Type tStates is (START, WASH, DRY, SQZ);
  signal state : tStates := START;
begin
  process (s) is
  begin
    if rising_edge(s) then
      case state is
        when START =>
          if I="00" then
            f <= '0';
            state <= WASH;
          elsif I="01" then
            f <= '0';
            state <= DRY;
          elsif I="10" then
            f <= '0';
            state <= SQZ;
          end if;
        when WASH =>
          if I="01" then
            f <= '0';
            state <= DRY;
          elsif I="10" then
            f <= '0';
            state <= SQZ;
          end if;
        when DRY =>
          if I="10" then
            f <= '0';
            state <= SQZ;
          end if;
        when SQZ =>
          f <= '1';
        end case;
    end if;
  end process;
End Architecture bhv;
