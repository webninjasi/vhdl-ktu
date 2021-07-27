
-- Library work
-- Use work.all;
-- std ve work standart kutuphanedir

Package pAdiPaket is
  Constant sabit1: integer := 61;
  Constant gckme: time := 20 ns;
  Type tMod is (dYavas, dNormal, DHizli);
  Function fMin(constant a, b: integer)
    return integer;
End pAdiPaket;

Package Body pAdiPaket is
  -- local definitions
  Function fMin(constant a, b: integer)
    return integer is
  begin
    if a < b then
      return a;
    end if;
    return b;
  End Function;
End pAdiPaket;
