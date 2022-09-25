unit Interfaces.iConexao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  iConexaoConfig = interface;

  iConexao = interface
    function Close: iConexao;
    function Open: iConexao;
    function Commit: iConexao;
    function RollBack: iConexao;
    function AddParams(aValue: iConexaoConfig): iConexao;
    function EndConexao: iConexao;
  end;

  iConexaoConfig = interface
    function Catalog(aValue: string): iConexaoConfig; overload;
    function Catalog: String; overload;
    function DataBase(aValue: string): iConexaoConfig; overload;
    function DataBase: String; overload;
    function HostName(aValue: string): iConexaoConfig; overload;
    function HostName: String; overload;
    function PassWord(aValue: string): iConexaoConfig; overload;
    function PassWord: String; overload;
    function Port(aValue: Integer): iConexaoConfig; overload;
    function Port: Integer; overload;
    function Protocol(aValue: string): iConexaoConfig; overload;
    function Protocol: String; overload;
    function User(aValue: string): iConexaoConfig; overload;
    function User: String; overload;
    function EndParams: iConexao;
  end;

implementation

end.
