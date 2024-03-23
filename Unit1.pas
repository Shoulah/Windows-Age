unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Registry, DateUtils;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
 myReg : TRegistry;
 myResult : DWORD;
begin
{KEY_WOW64_64KEY enable 32-bit applications to access redirected keys in the
64-bit registry view }
  myReg := TRegistry.Create(KEY_READ OR KEY_WOW64_64KEY);
  try
  //Registry root key
  myReg.RootKey := HKEY_LOCAL_MACHINE;
  //open the key
  myReg.OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion', False);
  //target value returned as integer
  myResult := myReg.ReadInteger('InstallDate');
  //convert unix time to datetime
  ShowMessage('Windows was installed in :' + DateTimeToStr(UnixToDateTime(myResult)));
  finally
    myReg.Free;
  end;
end;



end.
