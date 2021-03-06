unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGrids, Menus, StdCtrls, ComCtrls,
  ExtCtrls, DBCtrls, Cr_task, jpeg, ImgList, TrayIcon;

type
  TTasks = class(TForm)
    cds_tasks_v: TClientDataSet;
    dbg_tasks_v: TDBGrid;
    ds_tasks_v: TDataSource;
    re_task: TRichEdit;
    re_answer: TRichEdit;
    MainMenu1: TMainMenu;
    my_tasks: TMenuItem;
    tasks_for_me: TMenuItem;
    show_all_my: TMenuItem;
    today_my: TMenuItem;
    show_all_for_me: TMenuItem;
    today_for_me: TMenuItem;
    New_my: TMenuItem;
    show_performed: TMenuItem;
    week_my: TMenuItem;
    tomorrow_my: TMenuItem;
    month_my: TMenuItem;
    Cancel: TMenuItem;
    Complete: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    Button1: TButton;
    cds_task_tbl: TClientDataSet;
    img_content: TImage;
    Imglist_Content: TImageList;
    Label3: TLabel;
    pm_content: TPopupMenu;
    N13: TMenuItem;
    N14: TMenuItem;
    time_task: TTimer;
    cds_time: TClientDataSet;
    tray_nazn: TTrayIcon;
    tm_nazn: TTimer;
    tm_vipoln: TTimer;
    tray_vipoln: TTrayIcon;
    pm_show_hide: TPopupMenu;
    N15: TMenuItem;
    N16: TMenuItem;
    img_nazn0: TImage;
    Img_nazn1: TImage;
    img_vip0: TImage;
    img_vip1: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure dbg_tasks_vCellClick(Column: TColumn);
    procedure dbg_tasks_vKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure my_tasksClick(Sender: TObject);
    procedure tasks_for_meClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure New_myClick(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure show_all_myClick(Sender: TObject);
    procedure show_all_for_meClick(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure CompleteClick(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure show_performedClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure time_taskTimer(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure tm_naznTimer(Sender: TObject);
    procedure tm_vipolnTimer(Sender: TObject);
    Procedure WindowMessage (Var Msg:TMessage); message WM_SYSCOMMAND;
    procedure today_myClick(Sender: TObject);
    procedure tomorrow_myClick(Sender: TObject);
    procedure week_myClick(Sender: TObject);
    procedure month_myClick(Sender: TObject);
    procedure today_for_meClick(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Tasks: TTasks;
  user_id, CNT_NAZN, CNT_VIPOLN: integer;
  Passw: String;
  task_id, task_id_old, flag_dorab: integer;
  img_nazn_id: integer;
  img_vipoln_id: integer;
  Now_srw: TDateTime;

implementation

uses menu;

{$R *.dfm}

procedure TTasks.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Login.Show;
end;

procedure TTasks.FormShow(Sender: TObject);
begin
flag_dorab := 0;

dbg_tasks_v.Columns.Items[2].FieldName := 'FIO_SLAVE';

re_answer.ReadOnly := true;
re_task.ReadOnly := false;
cds_tasks_v.Close;
cds_tasks_v.CommandText := 'select tv.* from task_v tv, task ts where tv.code = ts.code and TS.MASTER_USER = ' + IntToStr(user_id) + ' order by ts.impotant desc';
cds_tasks_v.Open;
//img_content.Canvas.FillRect(ClientRect);
//ImgList_Content.GetBitmap(1,img_content.Picture.Bitmap);
img_content.Picture := nil;
img_content.Picture.Bitmap.Canvas.CleanupInstance;

N12.Visible := true;
Complete.Visible := true;
Cancel.Visible := true;

N1.Visible := false;
N3.Visible := false;
N2.Visible := false;
N7.Visible := false;
//ImgList_Content.Draw(img_content.Canvas,0,0,1,tdrawingstyle);
end;

procedure TTasks.dbg_tasks_vCellClick(Column: TColumn);
var
bStreamA, bStreamT, bStreamC: TStream;
begin
// cds_spr_tovar.First;
// cds_spr_tovar.FetchBlobs;

task_id := cds_tasks_v.FieldByName('code').Value;

 bStreamT := cds_tasks_v.CreateBlobStream(cds_tasks_v.FieldByName('TEXT_TASK'),bmRead);
  re_task.plaintext := false;
  re_task.Lines.Loadfromstream(bStreamT);
  bStreamT.Free;

  bStreamA := cds_tasks_v.CreateBlobStream(cds_tasks_v.FieldByName('TEXT_ANSWER'),bmRead);
  re_answer.plaintext := false;
  re_answer.Lines.Loadfromstream(bStreamA);
  bStreamA.Free;

  bStreamC := cds_tasks_v.CreateBlobStream(cds_tasks_v.FieldByName('CONTENT'),bmRead);
  img_content.Picture := nil;
  if bStreamC.Size = 0 then ImgList_Content.GetBitmap(0,img_content.Picture.Bitmap)
         else ImgList_Content.GetBitmap(1,img_content.Picture.Bitmap);
  bStreamC.Free;
end;

procedure TTasks.dbg_tasks_vKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
bStreamA, bStreamT, bStreamC: TStream;
begin
// cds_spr_tovar.First;
// cds_spr_tovar.FetchBlobs;

task_id := cds_tasks_v.FieldByName('code').Value;

 bStreamT := cds_tasks_v.CreateBlobStream(cds_tasks_v.FieldByName('TEXT_TASK'),bmRead);
  re_task.plaintext := false;
  re_task.Lines.Loadfromstream(bStreamT);
  bStreamT.Free;

  bStreamA := cds_tasks_v.CreateBlobStream(cds_tasks_v.FieldByName('TEXT_ANSWER'),bmRead);
  re_answer.plaintext := false;
  re_answer.Lines.Loadfromstream(bStreamA);
  bStreamA.Free;

  bStreamC := cds_tasks_v.CreateBlobStream(cds_tasks_v.FieldByName('CONTENT'),bmRead);
  img_content.Picture := nil;
  if bStreamC.Size = 0 then ImgList_Content.GetBitmap(0,img_content.Picture.Bitmap)
         else ImgList_Content.GetBitmap(1,img_content.Picture.Bitmap);
  bStreamC.Free;
end;

procedure TTasks.my_tasksClick(Sender: TObject);
begin
re_answer.ReadOnly := true;
re_task.ReadOnly := false;
dbg_tasks_v.Columns.Items[2].FieldName := 'FIO_SLAVE';
end;

procedure TTasks.tasks_for_meClick(Sender: TObject);
begin
re_task.ReadOnly := true;
re_answer.ReadOnly := false;
dbg_tasks_v.Columns.Items[2].FieldName := 'FIO_MASTER';
end;

procedure TTasks.Button1Click(Sender: TObject);
var
bStreamA, bStreamT: TMemoryStream;
begin
cds_task_tbl.Active := false;
cds_task_tbl.Filtered := false;
cds_task_tbl.Filter := 'code = ' + IntToStr(task_id);
cds_task_tbl.Filtered := true;
cds_task_tbl.Active := true;

  re_task.plaintext := false;
  re_answer.plaintext := false;

  bStreamT :=  TMemoryStream.Create;
  bStreamA :=  TMemoryStream.Create;


  cds_task_tbl.Edit;
  re_task.Lines.SaveToStream(bStreamT);
  re_answer.Lines.SaveToStream(bStreamA);
  TBlobField(cds_task_tbl.FieldByName('TEXT_TASK')).LoadFromStream(bStreamT);
  TBlobField(cds_task_tbl.FieldByName('TEXT_ANSWER')).LoadFromStream(bStreamA);

  cds_task_tbl.ApplyUpdates(0);



  bStreamT.Free;
  bStreamA.Free;

  cds_tasks_v.Active := false;
  cds_tasks_v.Active := true;
end;

procedure TTasks.New_myClick(Sender: TObject);
begin 
master_task_id := null;
tasks.Hide;
create_task.Show;
end;

procedure TTasks.N9Click(Sender: TObject);
begin
re_answer.ReadOnly := true;
re_task.ReadOnly := true;
cds_tasks_v.Active := false;
cds_tasks_v.Close;
cds_tasks_v.CommandText := 'Commit';
cds_tasks_v.Execute;
cds_tasks_v.Close;
cds_tasks_v.CommandText := 'select * from TREE_TASK (' + IntToStr(task_id) + ')';
cds_tasks_v.Open;

N12.Visible := false;
Complete.Visible := false;
Cancel.Visible := false;

N1.Visible := false;
N3.Visible := false;
N2.Visible := false;
N7.Visible := false;
end;

procedure TTasks.show_all_myClick(Sender: TObject);
begin
re_answer.ReadOnly := true;
re_task.ReadOnly := false;
cds_tasks_v.Close;
cds_tasks_v.CommandText := 'select tv.* from task_v tv, task ts where tv.code = ts.code and TS.MASTER_USER = ' + IntToStr(user_id);
cds_tasks_v.Open;

N12.Visible := true;
Complete.Visible := true;
Cancel.Visible := true;

N1.Visible := false;
N3.Visible := false;
N2.Visible := false;
N7.Visible := false;
end;

procedure TTasks.show_all_for_meClick(Sender: TObject);
begin
re_answer.ReadOnly := false;
re_task.ReadOnly := true;
cds_tasks_v.Close;
cds_tasks_v.CommandText := 'select tv.* from task_v tv, task ts where tv.code = ts.code and TS.SLAVE_USER = ' + IntToStr(user_id);
cds_tasks_v.Open;

N12.Visible := false;
Complete.Visible := false;
Cancel.Visible := false;

N1.Visible := true;
N3.Visible := true;
N2.Visible := true;
N7.Visible := true;
end;

procedure TTasks.N13Click(Sender: TObject);
var
openDialog: TOpenDialog;
begin

cds_task_tbl.Active := false;
cds_task_tbl.Filtered := false;
cds_task_tbl.Filter := 'code = ' + IntToStr(task_id);
cds_task_tbl.Filtered := true;
cds_task_tbl.Active := true;

 openDialog := TOpenDialog.Create(self);

 openDialog.Filter := 'Winrar|*.rar';

 if openDialog.Execute then
 begin
 cds_task_tbl.Edit;

// bStreamP := cds_v_tovar.CreateBlobStream(cds_v_tovar.FieldByName('FOTO'),bmWrite);
// img_spr_tovar.Picture.Bitmap.SaveToStream(bStreamP);


 // SavePictureToBLOB(img_spr_tovar.Picture, cds_v_tovar.FieldByName('FOTO') as TBLOBField);
  TBlobField(cds_task_tbl.FieldByName('CONTENT')).LoadFromFile(openDialog.FileName);

  cds_task_tbl.ApplyUpdates(0);

  cds_tasks_v.Refresh;
  end;
end;

procedure TTasks.N14Click(Sender: TObject);
var
saveDialog: TSaveDialog;
begin
 saveDialog := TsaveDialog.Create(self);


 if saveDialog.Execute then
 begin

 //bStreamC := cds_tasks_v.CreateBlobStream(cds_tasks_v.FieldByName('CONTENT'),bmRead);
// img_spr_tovar.Picture.Bitmap.SaveToStream(bStreamP);
  TBlobField(cds_tasks_v.FieldByName('CONTENT')).SaveToFile(saveDialog.FileName);


 // SavePictureToBLOB(img_spr_tovar.Picture, cds_v_tovar.FieldByName('FOTO') as TBLOBField);
  end;
end;

procedure TTasks.CompleteClick(Sender: TObject);
var
  sqltxt: AnsiString;
  btn : Integer;
begin
btn := MessageDlg('�� �������?',mtConfirmation, [mbYes, mbNo], 0);

if btn = mrYes    then
  begin
    sqltxt := cds_tasks_v.CommandText;
    cds_tasks_v.Close;
    cds_tasks_v.CommandText := 'update task ts set ts.status = 7 where code = ' + IntToStr(task_id);
    cds_tasks_v.Execute;
    cds_tasks_v.CommandText := 'Commit';
    cds_tasks_v.Execute;
    //cds_tasks_v.ApplyUpdates(0);
    cds_tasks_v.Close;
    cds_tasks_v.Active := false;
    cds_tasks_v.CommandText := sqltxt;
    cds_tasks_v.Open;
  end;
end;

procedure TTasks.CancelClick(Sender: TObject);
var
  sqltxt: AnsiString;
  btn : Integer;
begin
btn := MessageDlg('�� �������?',mtConfirmation, [mbYes, mbNo], 0);

if btn = mrYes    then
  begin
    sqltxt := cds_tasks_v.CommandText;
    cds_tasks_v.Close;
    cds_tasks_v.CommandText := 'update task ts set ts.status = 5 where code = ' + IntToStr(task_id);
    cds_tasks_v.Execute;
    cds_tasks_v.CommandText := 'Commit';
    cds_tasks_v.Execute;
    //cds_tasks_v.ApplyUpdates(0);
    cds_tasks_v.Close;
    cds_tasks_v.Active := false;
    cds_tasks_v.CommandText := sqltxt;
    cds_tasks_v.Open;
  end;
end;

procedure TTasks.N1Click(Sender: TObject);
var
  sqltxt: AnsiString;
  btn : Integer;
begin
btn := MessageDlg('�� �������?',mtConfirmation, [mbYes, mbNo], 0);

if btn = mrYes    then
  begin
    sqltxt := cds_tasks_v.CommandText;
    cds_tasks_v.Close;
    cds_tasks_v.CommandText := 'update task ts set ts.status = 1 where code = ' + IntToStr(task_id);
    cds_tasks_v.Execute;
    cds_tasks_v.CommandText := 'Commit';
    cds_tasks_v.Execute;
    //cds_tasks_v.Open;
    //cds_tasks_v.Edit;
    //cds_tasks_v.ApplyUpdates(0);
    cds_tasks_v.Close;
    cds_tasks_v.Active := false;
    cds_tasks_v.CommandText := sqltxt;
    cds_tasks_v.Open;
  end;

end;

procedure TTasks.N2Click(Sender: TObject);
var
  sqltxt: AnsiString;
  btn : Integer;
begin
btn := MessageDlg('�� �������?',mtConfirmation, [mbYes, mbNo], 0);

if btn = mrYes    then
  begin
    sqltxt := cds_tasks_v.CommandText;
    cds_tasks_v.Close;
    cds_tasks_v.CommandText := 'update task ts set ts.status = 4 where code = ' + IntToStr(task_id);
    cds_tasks_v.Execute;
    cds_tasks_v.CommandText := 'Commit';
    cds_tasks_v.Execute;
    //cds_tasks_v.ApplyUpdates(0);
    cds_tasks_v.Close;
    cds_tasks_v.Active := false;
    cds_tasks_v.CommandText := sqltxt;
    cds_tasks_v.Open;
  end;
end;

procedure TTasks.N7Click(Sender: TObject);
var
  sqltxt: AnsiString;
  btn : Integer;
begin
btn := MessageDlg('�� �������?',mtConfirmation, [mbYes, mbNo], 0);

if btn = mrYes    then
  begin
    sqltxt := cds_tasks_v.CommandText;
    cds_tasks_v.Close;
    cds_tasks_v.CommandText := 'update task ts set ts.status = 6 where code = ' + IntToStr(task_id);
    cds_tasks_v.Execute;
    cds_tasks_v.CommandText := 'Commit';
    cds_tasks_v.Execute;
    //cds_tasks_v.ApplyUpdates(0);
    cds_tasks_v.Close;
    cds_tasks_v.Active := false;
    cds_tasks_v.CommandText := sqltxt;
    cds_tasks_v.Open;
  end;
end;

procedure TTasks.show_performedClick(Sender: TObject);
begin
re_answer.ReadOnly := true;
re_task.ReadOnly := false;
cds_tasks_v.Close;
cds_tasks_v.CommandText := 'select tv.* from task_v tv, task ts where tv.code = ts.code and ts.status = 6 and TS.MASTER_USER = ' + IntToStr(user_id);
cds_tasks_v.Open;
end;

procedure TTasks.N3Click(Sender: TObject);
begin
master_task_id := task_id;
tasks.Hide;
create_task.Show;
end;

procedure TTasks.N12Click(Sender: TObject);
begin
flag_dorab := 1;
master_task_id := cds_tasks_v.FieldByName('CODE_MASTER').Value;
task_id_old := task_id;
tasks.Hide;
create_task.Show;
end;

procedure TTasks.time_taskTimer(Sender: TObject);
begin 
cds_time.Close;
cds_time.CommandText := 'select * from TIME_TASK_MSG(' + IntToStr(user_id) + ')';
cds_time.Open;
Now_srw := cds_time.FieldByName('CUR_TIME').Value;
CNT_NAZN := cds_time.FieldByName('CNT_NAZN').Value;
CNT_VIPOLN := cds_time.FieldByName('CNT_VIPOLN').Value;
cds_time.Close;
cds_time.CommandText := 'Commit';
cds_time.Execute;

if CNT_NAZN > 0 then
begin
  tm_nazn.Enabled := true;
  tray_nazn.Active := true;
end
else
begin
  tm_nazn.Enabled := false;
  tray_nazn.Active := false;

end;

if CNT_VIPOLN > 0 then
begin
  tm_vipoln.Enabled := true;
  tray_vipoln.Active := true;
end
else
begin
  tm_vipoln.Enabled := false;
  tray_vipoln.Active := false;
end;

end;

procedure TTasks.N15Click(Sender: TObject);
begin
Tasks.Show;
end;

procedure TTasks.N16Click(Sender: TObject);
begin
Tasks.Hide;
end;

procedure TTasks.tm_naznTimer(Sender: TObject);
begin
img_nazn_id := img_nazn_id xor $1;
//img_nazn.Picture := nil;
case img_nazn_id of
  0: tray_nazn.Icon := img_nazn0.Picture.Icon; //il_nazn.GetBitmap(0,img_nazn.Picture.Bitmap);   //image1.Picture.Bitmap.SaveToStream(stream_img);
  1: tray_nazn.Icon := img_nazn1.Picture.Icon; //il_nazn.GetBitmap(1,img_nazn.Picture.Bitmap);
end;
//tray_nazn.Icon := img_nazn.Picture.Icon;
end;

procedure TTasks.tm_vipolnTimer(Sender: TObject);
begin
img_vipoln_id := img_vipoln_id xor $1;
//img_nazn.Picture := nil;
case img_vipoln_id of
  0: tray_vipoln.Icon := img_vip0.Picture.Icon; //il_nazn.GetBitmap(0,img_nazn.Picture.Bitmap);   //image1.Picture.Bitmap.SaveToStream(stream_img);
  1: tray_vipoln.Icon := img_vip1.Picture.Icon; //il_nazn.GetBitmap(1,img_nazn.Picture.Bitmap);
end;
end;


Procedure TTasks.WindowMessage (Var Msg:TMessage);
Begin
IF Msg.WParam=SC_MINIMIZE then
Begin
Tasks.Hide;
End else
inherited;
End;

procedure TTasks.today_myClick(Sender: TObject);
begin
re_answer.ReadOnly := true;
re_task.ReadOnly := false;
cds_tasks_v.Close;
cds_tasks_v.CommandText := 'select tv.* from task_v tv, task ts where tv.code = ts.code and TS.MASTER_USER = ' + IntToStr(user_id) + ' and (ts.time_end - current_timestamp) < 1';
cds_tasks_v.Open;

N12.Visible := true;
Complete.Visible := true;
Cancel.Visible := true;

N1.Visible := false;
N3.Visible := false;
N2.Visible := false;
N7.Visible := false;
end;

procedure TTasks.tomorrow_myClick(Sender: TObject);
begin
re_answer.ReadOnly := true;
re_task.ReadOnly := false;
cds_tasks_v.Close;
cds_tasks_v.CommandText := 'select tv.* from task_v tv, task ts where tv.code = ts.code and TS.MASTER_USER = ' + IntToStr(user_id) + ' and (ts.time_end - current_timestamp) <= 2';
cds_tasks_v.Open;

N12.Visible := true;
Complete.Visible := true;
Cancel.Visible := true;

N1.Visible := false;
N3.Visible := false;
N2.Visible := false;
N7.Visible := false;
end;

procedure TTasks.week_myClick(Sender: TObject);
begin
re_answer.ReadOnly := true;
re_task.ReadOnly := false;
cds_tasks_v.Close;
cds_tasks_v.CommandText := 'select tv.* from task_v tv, task ts where tv.code = ts.code and TS.MASTER_USER = ' + IntToStr(user_id) + ' and (ts.time_end - current_timestamp) <= 7';
cds_tasks_v.Open;

N12.Visible := true;
Complete.Visible := true;
Cancel.Visible := true;

N1.Visible := false;
N3.Visible := false;
N2.Visible := false;
N7.Visible := false;
end;

procedure TTasks.month_myClick(Sender: TObject);
begin
re_answer.ReadOnly := true;
re_task.ReadOnly := false;
cds_tasks_v.Close;
cds_tasks_v.CommandText := 'select tv.* from task_v tv, task ts where tv.code = ts.code and TS.MASTER_USER = ' + IntToStr(user_id) + ' and (ts.time_end - current_timestamp) <= 30';
cds_tasks_v.Open;

N12.Visible := true;
Complete.Visible := true;
Cancel.Visible := true;

N1.Visible := false;
N3.Visible := false;
N2.Visible := false;
N7.Visible := false;
end;

procedure TTasks.today_for_meClick(Sender: TObject);
begin
re_answer.ReadOnly := false;
re_task.ReadOnly := true;
cds_tasks_v.Close;
cds_tasks_v.CommandText := 'select tv.* from task_v tv, task ts where tv.code = ts.code and TS.SLAVE_USER = ' + IntToStr(user_id) + ' and (ts.time_end - current_timestamp) < 1';
cds_tasks_v.Open;

N12.Visible := false;
Complete.Visible := false;
Cancel.Visible := false;

N1.Visible := true;
N3.Visible := true;
N2.Visible := true;
N7.Visible := true;
end;

procedure TTasks.N4Click(Sender: TObject);
begin
re_answer.ReadOnly := false;
re_task.ReadOnly := true;
cds_tasks_v.Close;
cds_tasks_v.CommandText := 'select tv.* from task_v tv, task ts where tv.code = ts.code and TS.SLAVE_USER = ' + IntToStr(user_id) + ' and (ts.time_end - current_timestamp) <= 2';
cds_tasks_v.Open;

N12.Visible := false;
Complete.Visible := false;
Cancel.Visible := false;

N1.Visible := true;
N3.Visible := true;
N2.Visible := true;
N7.Visible := true;
end;

procedure TTasks.N5Click(Sender: TObject);
begin
re_answer.ReadOnly := false;
re_task.ReadOnly := true;
cds_tasks_v.Close;
cds_tasks_v.CommandText := 'select tv.* from task_v tv, task ts where tv.code = ts.code and TS.SLAVE_USER = ' + IntToStr(user_id) + ' and (ts.time_end - current_timestamp) <= 7';
cds_tasks_v.Open;

N12.Visible := false;
Complete.Visible := false;
Cancel.Visible := false;

N1.Visible := true;
N3.Visible := true;
N2.Visible := true;
N7.Visible := true;
end;

procedure TTasks.N6Click(Sender: TObject);
begin
re_answer.ReadOnly := false;
re_task.ReadOnly := true;
cds_tasks_v.Close;
cds_tasks_v.CommandText := 'select tv.* from task_v tv, task ts where tv.code = ts.code and TS.SLAVE_USER = ' + IntToStr(user_id) + ' and (ts.time_end - current_timestamp) <= 30';
cds_tasks_v.Open;

N12.Visible := false;
Complete.Visible := false;
Cancel.Visible := false;

N1.Visible := true;
N3.Visible := true;
N2.Visible := true;
N7.Visible := true;
end;

end.
