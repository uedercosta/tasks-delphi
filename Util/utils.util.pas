unit Utils.Util;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

function StrZero(iNumero, iComp: Integer): String;

implementation

function StrZero(iNumero, iComp: Integer): String;
begin
  Result := StringOfChar('0',iComp-Length(IntToStr(iNumero)))+IntToStr(iNumero);
end;

end.

