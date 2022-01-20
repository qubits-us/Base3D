{ the Globs!!
  Created:1.16.22 -dm




  be it harm none, do as ye wish
     }
unit uGlobs;

interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics,
  FMX.MaterialSources,FMX.Objects, FMX.Dialogs,FMX.Layers3D,FMX.Objects3D,
  System.UIConsts,dmMaterials,System.SyncObjs, System.Math.Vectors,
  FMX.Controls3D,FMX.Platform{$IFDEF ANDROID},FMX.Platform.Android{$ENDIF}, uWorldAniDlg,
  uDlg3dCtrls,uScene3dMenu,uBorgTestDlg,uCommon3dDlgs,uNumPadDlg,uNumSelectDlg,uComplexDlg,
  uKeyboardDlg,uDlg3dTextures;



   //Tron -in charge of memory defense, kills things..
 type
    TTron = Class(tObject)
    procedure KillWorldAni(sender:tObject);
    procedure KillBorg(sender:tObject);
    procedure KillComplex(sender:tObject);
    procedure KillConfirm(sender:tObject;aYesNo:integer);
    procedure KillInfo(sender:tObject);
    procedure KillGetNumDone(sender:tObject;Selected:integer);
    procedure KillGetQuick(sender:tObject);
    procedure KillGetStr(sender:tObject);
    procedure KillScene1;
    procedure KillScene2;
    End;




    procedure InitWorldAni;
    procedure InitBorg;
    procedure ShowComplex(sender:tObject);
    procedure ShowConfirm(sender:tObject);
    procedure ShowInfo(sender:tObject);
    procedure GetNum(sender:tObject);
    procedure GetQuickNum(sender:tObject);
    procedure GetStr(sender:tObject);







var
  Scene1:TDlgMenu;
  Scene2:TDlgMenu;
  WorldAni:TDlgWorldAni;
  SceneBorg:TDlgBorgTest;
  ConfirmDlg:TDlgConfirmation;
  InfoDlg:TDlgInformation;
  NumPadDlg:TDlgNumPad;
  NumSelDlg:TDlgNumSel;
  KeyboardDlg:tDlgKeyboard;
  ComplexDlg:TComplexDlg;
  DlgUp:Boolean;
  Tron:TTron;


implementation

uses ufrmMain;


procedure InitWorldAni;
var
  newx,newy:single;
 begin
    MainFrm.im.Visible:=false;
    newx:=(MainFrm.ClientWidth/2);
    newy:=(MainFrm.ClientHeight/2);
   WorldAni:=tDlgWorldAni.Create(MainFrm,MainFrm.ClientWidth,MainFrm.ClientHeight,0,0);
   WorldAni.Parent:=MainFrm;
   WorldAni.Position.X:=newx;
   WorldAni.Position.Y:=newy;
   WorldAni.OnClose:=Tron.KillWorldAni;
 end;

 //init borg, resistance is futile!!
procedure InitBorg;
var
  newx,newy:single;
 begin
    MainFrm.im.Visible:=false;
    newx:=(MainFrm.ClientWidth/2);
    newy:=(MainFrm.ClientHeight/2);
   SceneBorg:=tDlgBorgTest.Create(MainFrm,MainFrm.ClientWidth,MainFrm.ClientHeight,0,0);
   SceneBorg.Parent:=MainFrm;
   SceneBorg.Position.X:=newx;
   SceneBorg.Position.Y:=newy;
   SceneBorg.OnClose:=Tron.KillBorg;
 end;

   // kill the borg tron!! :P
  procedure TTron.KillBorg(sender: TObject);
 begin
   if Assigned(SceneBorg) then
      begin
        SceneBorg.Visible:=false;
       TThread.CreateAnonymousThread(
        procedure
         begin
          TThread.Queue(nil,
           procedure
            begin
              SceneBorg.CleanUp;
              SceneBorg.Free;
              SceneBorg:=nil;
              MainFrm.InitScene1;
             end);
         end).Start;
      end;
 end;




 procedure TTron.KillWorldAni(sender: TObject);
 begin
   if Assigned(WorldAni) then
      begin
        WorldAni.Visible:=false;
       TThread.CreateAnonymousThread(
        procedure
         begin
          TThread.Queue(nil,
           procedure
            begin
              WorldAni.CleanUp;
              WorldAni.Free;
              WorldAni:=nil;
              MainFrm.InitScene1;
             end);
         end).Start;
      end;
 end;



 procedure TTron.KillScene1;
 begin
     if Assigned(Scene1) then
      begin
        Scene1.Visible:=false;
       TThread.CreateAnonymousThread(
        procedure
         begin
          TThread.Queue(nil,
           procedure
            begin
              Scene1.CleanUp;
              Scene1.Free;
              Scene1:=nil;
             end);
         end).Start;
      end;
 end;

 procedure TTron.KillScene2;
 begin
     if Assigned(Scene2) then
      begin
        Scene2.Visible:=false;
       TThread.CreateAnonymousThread(
        procedure
         begin
          TThread.Queue(nil,
           procedure
            begin
              Scene2.CleanUp;
              Scene2.Free;
              Scene2:=nil;
             end);
         end).Start;
      end;
 end;


 procedure ShowComplex(sender: TObject);
 var
 newx,newy:single;
 begin

   if not Assigned(ComplexDlg) then
      begin
       newx:=(MainFrm.ClientWidth/2);
       newy:=(MainFrm.ClientHeight/2);
      ComplexDlg:=tComplexDlg.Create(MainFrm,DlgMaterial,MainFrm.CLientwidth,MainFrm.Clientheight,newx,newy);
      ComplexDlg.Parent:=MainFrm;
      ComplexDlg.Position.Z:=-1;
      ComplexDlg.OnDone:=Tron.KillComplex;
      ComplexDlg.OnCancel:=Tron.KillComplex;
      //ComplexDlg.Opacity:=0.95;
      DlgUp:=true;
      end;

 end;

  procedure TTron.KillComplex(sender: TObject);
 begin


   if Assigned(ComplexDlg) then
      begin
        ComplexDlg.Visible:=false;
       TThread.CreateAnonymousThread(
        procedure
         begin
          TThread.Queue(nil,
           procedure
            begin
              ComplexDlg.CleanUp;
              ComplexDlg.Free;
              ComplexDlg:=nil;
              DlgUp:=False;
              MainFrm.InitScene1;
             end);
         end).Start;
      end;
 end;




 procedure ShowConfirm(sender: TObject);
 var
 newx,newy:single;
 begin

   if not Assigned(ConfirmDlg) then
      begin
       newx:=(MainFrm.ClientWidth/2);
       newy:=(MainFrm.ClientHeight/2);
      ConfirmDlg:=tDlgConfirmation.Create(MainFrm,DlgMaterial,MainFrm.width/1.5,MainFrm.height/2,newx,newy);
      ConfirmDlg.DlgText.Text:='Yes and No prompt';
      ConfirmDlg.Parent:=MainFrm;
      ConfirmDlg.Position.Z:=-10;
      ConfirmDlg.OnButtonClick:=Tron.KillConfirm;
      ConfirmDlg.Opacity:=0.95;
      DlgUp:=true;
      end;

 end;


 procedure TTron.KillConfirm(sender: TObject;aYesNo:integer);
 begin


   if Assigned(ConfirmDlg) then
      begin
        ConfirmDlg.Visible:=false;
       TThread.CreateAnonymousThread(
        procedure
         begin
          TThread.Queue(nil,
           procedure
            begin
              ConfirmDlg.CleanUp;
              ConfirmDlg.Free;
              ConfirmDlg:=nil;
              DlgUp:=False;
             end);
         end).Start;
      end;
 end;

 procedure ShowInfo(sender: TObject);
 var
 newx,newy:single;

 begin
   if not Assigned(InfoDlg) then
      begin
       newx:=(MainFrm.ClientWidth/2);
       newy:=(MainFrm.ClientHeight/2);
      InfoDlg:=tDlgInformation.Create(MainFrm,DlgMaterial,MainFrm.width/1.5,MainFrm.height/2,newx,newy);
      InfoDlg.DlgText.Text:='H:'+FloatToStr(MainFrm.ClientHeight)+' W:'+FloatToStr(MainFrm.ClientWidth)+' Scale:'+FloatToStr(CurrentScale);
      InfoDlg.Parent:=MainFrm;
      InfoDlg.Position.Z:=-10;
      InfoDlg.OnClick:=Tron.KillInfo;
      DlgUp:=true;

      end;

 end;


 procedure TTron.KillInfo(sender: TObject);
 begin
   if Assigned(InfoDlg) then
      begin
        InfoDlg.Visible:=false;
       TThread.CreateAnonymousThread(
        procedure
         begin
          TThread.Queue(nil,
           procedure
            begin
              InfoDlg.CleanUp;
              InfoDlg.Free;
              InfoDlg:=nil;
              DlgUp:=False;
             end);
         end).Start;
      end;
 end;

 procedure GetNum(sender: TObject);
 var
 newx,newy:single;
 begin

   if not Assigned(NumPadDlg) then
      begin
       newx:=(MainFrm.ClientWidth/2);
       newy:=(MainFrm.ClientHeight/2);

      NumPadDlg:=tDlgNumPad.Create(MainFrm,DlgMaterial,MainFrm.height/1.25,MainFrm.height/1.25,newx,newy);
      NumPadDlg.Number:=100;
      NumPadDlg.NumBtn.Text:='100';
      NumPadDlg.Parent:=MainFrm;
      NumPadDlg.Position.Z:=-10;
      NumPadDlg.OnDone:=Tron.KillGetNumDone;
      NumPadDlg.BackIm.Visible:=true;
      NumPadDlg.Opacity:=0.95;
      DlgUp:=true;

      end;

 end;


 procedure TTron.KillGetNumDone(sender: TObject;Selected:integer);
 begin
   if Assigned(NumPadDlg) then
      begin
        NumPadDlg.Visible:=false;
       TThread.CreateAnonymousThread(
        procedure
         begin
          TThread.Queue(nil,
           procedure
            begin
              NumPadDlg.CleanUp;
              NumPadDlg.Free;
              NumPadDlg:=nil;
              DlgUp:=False;
             end);
         end).Start;
      end;
 end;


 procedure GetQuickNum(sender: TObject);
 var
 newx,newy:single;
 begin

   if not Assigned(NumSelDlg) then
      begin
       newx:=(MainFrm.ClientWidth/2);
       newy:=(MainFrm.ClientHeight/2);

      NumSelDlg:=tDlgNumSel.Create(MainFrm,DlgMaterial,MainFrm.height/1.2,MainFrm.height/1.2,newx,newy);
      NumSelDlg.Parent:=MainFrm;
      NumSelDlg.Position.Z:=-10;
      NumSelDlg.OnDone:=Tron.KillGetQuick;
      NumSelDlg.Opacity:=0.90;
      DlgUp:=true;

      end;

 end;


 procedure TTron.KillGetQuick(sender: TObject);
 begin


   if Assigned(NumSelDlg) then
      begin
        NumSelDlg.Visible:=false;
       TThread.CreateAnonymousThread(
        procedure
         begin
          TThread.Queue(nil,
           procedure
            begin
              NumSelDlg.CleanUp;
              NumSelDlg.Free;
              NumSelDlg:=nil;
              DlgUp:=False;
             end);
         end).Start;
      end;



 end;

 procedure GetStr(sender: TObject);
 var
 newx,newy:single;
 begin

   if not Assigned(KeyboardDlg) then
      begin
       newx:=(MainFrm.ClientWidth/2);
       newy:=(MainFrm.ClientHeight/2);

      KeyboardDlg:=tDlgKeyboard.Create(MainFrm,DlgMaterial,MainFrm.ClientWidth,MainFrm.ClientHeight,newx,newy);
      KeyboardDlg.Parent:=MainFrm;
      KeyboardDlg.Position.Z:=-10;
      KeyboardDlg.OnDone:=Tron.KillGetStr;
      KeyboardDlg.BackIm.Visible:=true;
      KeyboardDlg.StrGet:='Jupiter';
      KeyboardDlg.Opacity:=0.90;
      DlgUp:=true;

      end;

 end;


 procedure TTron.KillGetStr(sender: TObject);
 begin
    //do something with string
    //KeyboardDlg.StrGet;

   if Assigned(KeyboardDlg) then
      begin
        KeyboardDlg.Visible:=false;
       TThread.CreateAnonymousThread(
        procedure
         begin
          TThread.Queue(nil,
           procedure
            begin
              KeyboardDlg.CleanUp;
              KeyboardDlg.Free;
              KeyboardDlg:=nil;
              DlgUp:=False;
             end);
         end).Start;
      end;



 end;









end.
