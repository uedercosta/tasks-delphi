unit Factory.Query;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Models.Query;

type

  iFactoryQuery = interface
    function Query: iQuery;
  end;

  { TQueryFactory }

  TQueryFactory = class(TInterfacedObject, iFactoryQuery)
  private
    FQuery: iQuery;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iFactoryQuery;

    function Query: iQuery;

  end;

implementation

{ TQueryFactory }

constructor TQueryFactory.Create;
begin
  FQuery := TQuery.New(nil);
end;

destructor TQueryFactory.Destroy;
begin
  inherited Destroy;
end;

class function TQueryFactory.New: iFactoryQuery;
begin
  Result := self.Create;
end;

function TQueryFactory.Query: iQuery;
begin
  Result := FQuery;
end;

end.
