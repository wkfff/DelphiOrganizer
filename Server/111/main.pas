unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, TrayIcon, StdCtrls, DB, IBDatabase,
  IBCustomDataSet, IBStoredProc;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    CNT_USERS: TLabel;
    Image1: TImage;
    Image2: TImage;
    tray_fmserv: TTrayIcon;
    Popup_serv: TPopupMenu;
    show_: TMenuItem;
    hide_: TMenuItem;
    close_: TMenuItem;
    Timer1: TTimer;
    t_norm_task: TTimer;
    ibsp_norm_task: TIBStoredProc;
    IBTransaction1: TIBTransaction;
    IBDatabase1: TIBDatabase;
    procedure show_Click(Sender: TObject);
    procedure hide_Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure t_norm_taskTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  img_id: integer;
  count_user: integer;

implementation

uses
     Remote_Data;

{$R *.dfm}

procedure TForm1.show_Click(Sender: TObject);
begin
Form1.Show;
end;

procedure TForm1.hide_Click(Sender: TObject);
begin
Form1.Hide;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
img_id := img_id xor $1;

case img_id of
  0: tray_fmserv.Icon := image1.Picture.Icon;   //image1.Picture.Bitmap.SaveToStream(stream_img);
  1: tray_fmserv.Icon := image2.Picture.Icon; 
end;

end;

procedure TForm1.t_norm_taskTimer(Sender: TObject);
begin
  ibsp_norm_task.ExecProc;
  IBTransaction1.Commit;
end;

end.
