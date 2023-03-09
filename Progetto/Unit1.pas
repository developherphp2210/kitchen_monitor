unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,Vcl.Forms,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.ODBCBase, IPPeerClient;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    dbserver: TFDConnection;
    comande: TFDQuery;
    consegnato: TFDQuery;
    TrayIcon1: TTrayIcon;
    Timer2: TTimer;
    del_trans: TFDCommand;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    comandeprep: TFMTBCDField;
    comandenComanda: TIntegerField;
    comandeUpdated: TSQLTimeStampField;
    consegnatoConsegnato: TIntegerField;
    consegnatonComanda: TIntegerField;
    consegnatoUpdated: TSQLTimeStampField;
    procedure Timer1Timer(Sender: TObject);
    Function log(tipo:integer;msg:string):boolean;
    procedure dbserverBeforeConnect(Sender: TObject);
    procedure CreateExistFileLog();
    procedure FormCreate(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Zmenu;
  private
    nomedb,user,psw,url,server,path,datalog,ultima_preparazione,ultima_consegna: string;
    timer:integer;
    oraini,orafin:Ttime;
    anno,mese,giorno:word;
    Filelog: Textfile;
  public

    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

Uses Inifiles;



Function TForm1.log(tipo:integer;msg:string):boolean;
var hh,mm,ss,sss:word;
    formatodata:string;
Begin
  CreateExistFilelog();
  decodetime(time,hh,mm,ss,sss);
  formatodata:=format('%2.2d'+'/'+'%2.2d'+'/'+'%4.4d',[giorno,mese,anno])+' '+format('%2.2d'+'.'+'%2.2d'+'.'+'%2.2d',[hh,mm,ss]);
  case tipo of
    1:begin
        writeln(Filelog,'[ ERROR '+formatodata+' ] - '+msg);
        result:=false;
      end;
    2:begin
        writeln(Filelog,'[ INFO '+formatodata+' ] - '+msg);
        result:=true;
      end;
  end;
  Closefile(Filelog);
end;

procedure TForm1.CreateExistFileLog();
var filename:string;
begin
  decodedate(date,anno,mese,giorno);
  datalog:=format('Service'+'%4.4d%2.2d%2.2d',[anno,mese,giorno]);
  filename:=ExtractFilePath(paramstr(0))+'\log\'+datalog+'.log';
  if (not fileexists(filename)) then
    begin
      AssignFile(Filelog, filename);
      Rewrite(Filelog);
      Append(Filelog);
    end
    else begin
            AssignFile(Filelog, filename);
            Append(Filelog);
          end;
end;

procedure TForm1.dbserverBeforeConnect(Sender: TObject);
begin
  dbserver.Params.Values['Database']:=nomedb;
  dbserver.Params.Values['Server']:=server;
  dbserver.Params.Values['User_Name']:=user;
  dbserver.Params.Values['Password']:=psw;
end;

procedure TForm1.FormCreate(Sender: TObject);
var iniparametri:Tinifile;

begin
  Iniparametri := nil;
  try
    iniparametri := Tinifile.Create(ExtractFilePath(paramstr(0))+'config.ini');
    nomedb := iniparametri.ReadString('PARAMETRI', 'NAMEDB','0');
    user:=Iniparametri.ReadString('PARAMETRI','USER','0');
    psw:=Iniparametri.ReadString('PARAMETRI','PASSWORD','0');
    url:=Iniparametri.ReadString('PARAMETRI','URL','0');
    server:=Iniparametri.ReadString('PARAMETRI','SERVER','0');
    oraini:=strtotime(Iniparametri.ReadString('PARAMETRI','ORAINI','0'));
    orafin:=strtotime(Iniparametri.ReadString('PARAMETRI','ORAFIN','0'));
  finally
    iniparametri.free;
  end;
  Timer2.Enabled:=true;
end;



procedure TForm1.Timer1Timer(Sender: TObject);
begin
  TIMER1.Enabled:=false;
  if ((time>oraini) and (time<orafin)) then
     begin
      zmenu;
     end;
  Timer1.Enabled:=true;
end;


procedure TForm1.Timer2Timer(Sender: TObject);
var dt:string;
begin
  Timer2.Enabled:=false;
  Form1.Hide;
  dt := datetostr(now);
  dt := copy(dt,4,2)+'/'+copy(dt,1,2)+'/'+copy(dt,7,4);
  ultima_consegna:= dt+' 00:00:01';
  ultima_preparazione := dt+' 00:00:01';
  Timer1.Enabled:=true;
end;

procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin
  Form1.Show;
end;

procedure TForm1.Zmenu;
var sql,dati,stato:string;
Var YY,MM,DD : Word;
begin
  try
    dbserver.Connected;
  except on e:Exception do
    Log(1,e.Message);
  end;
  try
    comande.SQL.Clear;
    sql := 'select ( sum(quantita) - sum(QtaFatta) ) as prep , nComanda, Updated from Comande where Consegnato=0 and Updated > '+''''+ultima_preparazione+''''+' group by nComanda,Updated order by Updated';
    comande.SQL.Add(sql);
    comande.Open;
    comande.First;
  except on e:Exception do
    Log(1,e.Message);
  end;
  while (not comande.Eof) do
   begin
     log(2,'CONTROLLO COMANDE DA PREPARARE');
     if comandeprep.AsInteger=0 then stato:='1'
                                else stato:='0';
     try
       Restclient1.BaseURL:=url+'?comanda='+comandenComanda.asstring+'&stato='+stato;
       restRequest1.Execute;
       log(2, RestResponse1.Content);
     except on e:Exception do
       Log(1,e.Message);
     end;
     ultima_preparazione := copy(datetimetostr(comandeUpdated.AsDateTime),4,2)+'/'+copy(datetimetostr(comandeUpdated.AsDateTime),1,2)+'/'+copy(datetimetostr(comandeUpdated.AsDateTime),7,4)+' '+copy(datetimetostr(comandeUpdated.AsDateTime),11,9);
     comande.Next;
   end;
   comande.Close;
   try
    consegnato.SQL.Clear;
    sql := 'select distinct Consegnato , nComanda , Updated from Comande where Consegnato=1 and Updated > '+''''+ultima_consegna+'''';
    consegnato.SQL.Add(sql);
    consegnato.Open;
    consegnato.First;
  except on e:Exception do
    Log(1,e.Message);
  end;
  while (not consegnato.Eof) do
    begin
      log(2,'CONTROLLO COMANDE CONSEGNATE');
      stato:='2';
      try
       Restclient1.BaseURL:=url+'?comanda='+consegnatonComanda.asstring+'&stato='+stato;
       restRequest1.Execute;
       log(2, RestResponse1.Content);
     except on e:Exception do
       Log(1,e.Message);
     end;
     ultima_consegna:=copy(datetimetostr(consegnatoUpdated.AsDateTime),4,2)+'/'+copy(datetimetostr(consegnatoUpdated.AsDateTime),1,2)+'/'+copy(datetimetostr(consegnatoUpdated.AsDateTime),7,4)+' '+copy(datetimetostr(consegnatoUpdated.AsDateTime),11,9);
     consegnato.Next;
    end;
  dbserver.Connected:=false;
end;

end.
