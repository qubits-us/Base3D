{ Sample testing hdpi..

 1.16.22 -dm

 be it harm none, do as ye wishes!!

}


unit ufrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics,
  FMX.MaterialSources,FMX.Objects, FMX.Dialogs,FMX.Layers3D,FMX.Objects3D,
  System.UIConsts,dmMaterials,System.SyncObjs, System.Math.Vectors,
  FMX.Controls3D,FMX.Platform{$IFDEF ANDROID},FMX.Platform.Android{$ENDIF}, uWorldAniDlg,
  uDlg3dCtrls,uScene3dMenu,uBorgTestDlg,uCommon3dDlgs,uNumPadDlg,uNumSelectDlg,
  uKeyboardDlg,uDlg3dTextures,uGlobs;






type
  TMainFrm = class(TForm3D)
    im: TImage3D;
    procedure Form3DCreate(Sender: TObject);
    procedure Form3DClose(Sender: TObject; var Action: TCloseAction);
    procedure Scene1Click(Sender:tObject; aBtnNum:integer);
    procedure Scene2Click(Sender:tObject; aBtnNum:integer);
    procedure InitScene1;
    procedure InitScene2;


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainFrm: TMainFrm;



implementation

{$R *.fmx}





function GetScreenScale: Single;var ScreenService: IFMXScreenService;
begin
  Result := 1;
  if TPlatformServices.Current.SupportsPlatformService (IFMXScreenService, IInterface(ScreenService)) then
    Result := ScreenService.GetScreenScale;
end;



procedure TMainFrm.Form3DClose(Sender: TObject; var Action: TCloseAction);
begin



  if Assigned(Scene1) then Scene1.Free;
  if Assigned(Scene2) then Scene2.Free;
  if Assigned(WorldAni) then WorldAni.Free;
  if assigned(SceneBorg) then SceneBorg.Free;

  dlgMaterial.Free;
  dlgMaterial:=nil;

  MaterialsDm.Free;

  Tron.Free;


  {$IFDEF ANDROID}
  MainActivity.finish;
  {$ENDIF}


end;

procedure TMainFrm.Form3DCreate(Sender: TObject);
begin

 //  System.ReportMemoryLeaksOnShutdown:=true;

   MaterialsDm:=TMaterialsDm.Create(self);

   DlgMaterial:=tDlgMaterial.Create(self);

  Scene1:=nil;
  Scene2:=nil;
  WorldAni:=nil;
  SceneBorg:=nil;
  DlgUp:=False;
  Tron:=TTron.Create;
  CurrentTheme:=0;//puple clouds


      //everybody scales!!
      CurrentScale:=GetScreenScale;



    BorderStyle:=TFmxFormBorderStyle.ToolWindow;
    Caption:='3d Dlg Base Test';

    ClientWidth:=Trunc(Screen.Width-(Screen.Width / 2));
    ClientHeight:=Trunc(Screen.Height-(Screen.Height / 2));
    Left:=50;
    Top:=10;


 {$IFDEF ANDROID} //robots
       GoFullScreen:=true;
       Caption:='';
       Width:=Trunc(Screen.Width);
       Height:=Trunc(Screen.Height);
       ClientWidth:=Trunc(Screen.Width);
       ClientHeight:=Trunc(Screen.Height);
       im.Width:=Width;
       im.Height:=Height;
       Left:=0;
       Top:=0;
       BorderStyle:=TFmxFormBorderStyle.None;
       FullScreen:=true;
       StartUpTmr.Enabled:=true;
       //wait 5 secs.. screen will be ready..
 {$ENDIF}

  {$IFDEF MSWINDOWS}  //windows
    GoFullScreen:=false;
    BorderStyle:=TFmxFormBorderStyle.ToolWindow;
    Caption:='3d Dlg Base Test';
    //my 4k phone's res, but it's hdpi
    ClientWidth:=916;
    ClientHeight:=411;
    Left:=Trunc((Screen.Width/2)-(ClientWidth/2));
    Top:=Trunc((Screen.Height/2)-(ClientHeight/2));
    InitWorldAni;
 {$ENDIF}


end;



procedure TMainFrm.InitScene1;
var
  newx,newy:single;
  tmpBitmap:tBitmap;
  aColGap,aRowGap:single;
  aButtonHeight,aButtonWidth:single;
 begin

   MainFrm.im.Visible:=false;


  DlgMaterial.GreenTxt.Color:=claGreen;
  DlgMaterial.RedTxt.Color:=claRed;

   MaterialsDm.LoadTheme;

   newx:=(MainFrm.ClientWidth/2);
   newy:=(MainFrm.ClientHeight/2);
   Scene1:=tDlgMenu.Create(MainFrm,DlgMaterial,MainFrm.ClientWidth,MainFrm.ClientHeight,0,0);
   Scene1.Parent:=MainFrm;
   Scene1.Position.X:=newx;
   Scene1.Position.Y:=newy;
   Scene1.OnSelect:=Scene1Click;
   case CurrentTheme of
   0:begin
      Scene1.AniType:=1;
      Scene1.StartAni;
     end;
   1:begin
     Scene1.AniType:=2;
     Scene1.StartAni;
     end;
   2:begin
      Scene1.AniType:=3;
      Scene1.StartAni;
     end;
   3:begin
      Scene1.AniType:=2;
      Scene1.StartAni;
     end;

   end;



 end;


procedure TMainFrm.Scene1Click(Sender: TObject; aBtnNum:integer);
 begin
    if DlgUp then exit;

   if aBtnNum<>3 then
   begin
   if not (aBtnNum in [5,6,8,9,10]) then
     begin
       Tron.KillScene1;
      end;

       if aBtnNum>10 then CurrentTheme:=aBtnNum-11;

       case aBtnNum of
       1:InitBorg;
       2:ShowComplex(self);
       5:ShowConfirm(nil);
       6:ShowInfo(nil);
       8:GetNum(nil);
       9:GetQuickNum(nil);
       10:GetStr(nil);
       14:InitScene2;
       else InitScene2;
       end;


   end else Close;


 end;


procedure TMainFrm.InitScene2;
var
  tmpBitmap:TBitmap;
  newx,newy:single;
  aColGap,aRowGap:single;
  aButtonHeight,aButtonWidth:single;

 begin
  DlgMaterial.GreenTxt.Color:=claGreen;
  DlgMaterial.RedTxt.Color:=claRed;

   MaterialsDm.LoadTheme;


   newx:=(MainFrm.ClientWidth/2);
   newy:=(MainFrm.ClientHeight/2);
   Scene2:=tDlgMenu.Create(MainFrm,DlgMaterial,MainFrm.ClientWidth,MainFrm.ClientHeight,0,0);
   Scene2.Parent:=MainFrm;
   Scene2.Position.X:=newx;
   Scene2.Position.Y:=newy;
   Scene2.OnSelect:=Scene2Click;
   case CurrentTheme of
   0:begin
      Scene2.AniType:=1;
      Scene2.StartAni;
     end;
   1:begin
     Scene2.AniType:=2;
     Scene2.StartAni;
     end;
   2:begin
      Scene2.AniType:=3;
      Scene2.StartAni;
     end;
   3:begin
      Scene2.AniType:=2;
      Scene2.StartAni;
     end;

   end;


 end;





procedure TMainFrm.Scene2Click(Sender: TObject; aBtnNum:integer);
 begin
   if DlgUp then exit;

  if aBtnNum<>3 then
   begin
    if Assigned(Scene2) then
      begin
       if not (aBtnNum in [5,6,8,9,10]) then
        begin
          Tron.KillScene2;
        end;

       if aBtnNum>10 then CurrentTheme:=aBtnNum-11;



       case aBtnNum of
       1:InitBorg;
       2:ShowComplex(self);
       5:ShowConfirm(nil);
       6:ShowInfo(nil);
       8:GetNum(nil);
       9:GetQuickNum(nil);
       10:GetStr(nil);
       14:InitScene1;
       else InitScene1;
       end;


      end;
   end else Close;


 end;




end.
