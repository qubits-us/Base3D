{ Spinning our beautiful earth, moon in orbit, have to wait for it..
  all good things come to those that wait.. i put some lights on the moon and you can spin it, bit of an easter egg..
  don't tell no one it can spin, see if they find out, stupid i know, but it's these little things that make you smile..

  don't remember orig creation..
  have had this spinning for a few years at least..
  1.16.22 -dm

  be it harm none, do as ye wishes!!

}
unit uWorldAniDlg;

interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.UIConsts,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, System.Math.Vectors, FMX.Ani, FMX.Controls3D,
  FMX.MaterialSources, FMX.Objects3D, FMX.Effects, FMX.Filter.Effects,FMX.Layers3D,
  FMX.Objects,uDlg3dCtrls,uInertiaTimer;



  type
    TDlgWorldAni= class(TDummy)
      private
       fIm:TImage3d;
       fTxt:TText3d;
    //   fClockTxt:TText3d;
     //  fBorg:TCube;
       fWebTxt:TText3d;
       fGlobe:TSphere;
       fMoon:TSphere;
       fDownx:single;
       bDownx:single;
       fCloseOnce:boolean;
       fAniSpin:TFloatAnimation;
     //  fClockTmr:tInertiaTimer;
       fAniMoonSpin:TFloatAnimation;
     //  fBorgSpin:TFLoatAnimation;
       fCloseEvent:TDlgDoneClick_Event;
       fCleanedUp:boolean;
      protected

       procedure DoClose(sender:tObject);
       procedure MoonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos,
                               RayDir: TVector3D);
       procedure MoonMouseup(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos,
                               RayDir: TVector3D);
       procedure BorgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos,
                               RayDir: TVector3D);
       procedure BorgMouseup(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos,
                               RayDir: TVector3D);


      public
       Constructor Create(Sender: TComponent;aWidth,aHeight,aX,aY:single);Reintroduce;
       Destructor Destroy;override;
       procedure  CleanUp;
       property  OnClose:TDlgDoneClick_Event read fCloseEvent write fCloseEvent;
       property CleanedUp:boolean read fCleanedUp;
    end;



implementation

uses dmMaterials;



Constructor TDlgWorldAni.Create(Sender: TComponent;aWidth,aHeight,aX,aY:single);
var
aGap:Single;
begin
  //create
  Inherited Create(nil);
  fCleanedUp:=false;
  //set our cam first always!!!
  Projection:=TProjection.Screen;
  Parent:=TForm3d(sender);
  HitTest:=True;
  Width:=aWidth;
  Height:=aHeight;
  Position.X:=aX;
  Position.Y:=aY;
  OnClick:=DoClose;
  aGap:=10;
  fCloseOnce:=false;

  fIm:=TImage3d.Create(nil);
  fIm.Projection:=tProjection.Screen;
  fIm.Bitmap:=MaterialsDm.tmStarsImg.Texture;
  fIm.Position.Z:=1500;
  fIm.Width:=aWidth+1500;
  if GoFullScreen then
  fIm.Height:=aHeight+1700 else
  fIm.Height:=aHeight+1500;
  fIm.HitTest:=true;
  fIm.OnClick:=DoClose;
  fIm.Position.X:=aX;
  fIm.Position.Y:=aY;

  fIm.Parent:=self;
  //fIm.Opacity:=0.85;




  fGlobe:=TSphere.Create(nil);
  fGlobe.Projection:=TProjection.Screen;
  fGlobe.Parent:=self;
  fGlobe.Height:=(Height/1.25);
  fGlobe.Width:=(Height/1.25);
  fGlobe.Depth:=(Height/1.25);
  fGlobe.Position.X:=0;
  fGlobe.Position.Y:=0;
  fGlobe.Position.Z:=fGlobe.Width+100;
  fGlobe.SubdivisionsAxes:=32;
  fGlobe.SubdivisionsHeight:=24;
  fGlobe.Opacity:=1;
  fGlobe.Opaque:=false;
  fGlobe.MaterialSource:=MaterialsDm.tmGlobeImg;
  fGlobe.OnClick:=DoClose;

  fMoon:=TSphere.Create(nil);
  fMoon.Projection:=TProjection.Screen;
  fMoon.Parent:=fGlobe;
  fMoon.Height:=Height-(Height/1.2);
  fMoon.Width:=Height-(Height/1.2);
  fMoon.Depth:=Height-(Height/1.2);
  fMoon.Position.Y:=0;//((Height/2)*-1)+(fElip.Height/2);
  fMoon.Position.X:=0;//((Width/2)*-1)+(fElip.Width/2);
  fMoon.Position.Z:=(fGlobe.Height+2);
  fMoon.MaterialSource:=MaterialsDm.tmMoonImg;
  fMoon.HitTest:=true;
  fMoon.OnMouseDown:=MoonMouseDown;//save the x
  fMoon.OnMouseUp:=MoonMouseUp;//spin the moon
 {
  fBorg:=TCube.Create(nil);
  fBorg.Projection:=tProjection.Screen;
  fBorg.Parent:=self;
  fBorg.Depth:=Height-(Height/1.1);
  fBorg.Width:=Height-(Height/1.1);
  fBorg.Height:=Height-(Height/1.1);
  fBorg.Position.X:=((Width/2)*-1)+(fBorg.Width/2)+(aGap*10);
  fBorg.Position.Y:=((Height/2)*-1)+(fBorg.Height/2)+(aGap*10);
  fBorg.Position.Z:=50;
  fBorg.MaterialSource:=MaterialsDm.tmBorgImg;
  fBorg.OnClick:=nil;
  fBorg.OnMouseDown:=BorgMouseDown;//save the x
  fBorg.OnMouseUp:=BorgMouseUp;//spin the borg
  fBorg.Visible:=true;      }
{
  fClockTxt:=TText3d.Create(self);
  fClockTxt.Projection:=tProjection.Screen;
  fClockTxt.Parent:=self;//TDummy(sender);
  fClockTxt.Depth:=2;
  fClockTxt.Stretch:=false;
  fClockTxt.Width:=(Width/50)*10;
  fClockTxt.Height:=Height/12;
  fClockTxt.Position.X:=((Width/2))-(fClockTxt.Width/2)-(aGap*4);
//  if GoFullScreen then
//  fTxt.Position.Y:=((Height/2)-(fTxt.Height))+40 else
{
  fClockTxt.Position.Y:=((Height/2)*-1)+(fClockTxt.Height/2)+(aGap*4);
  fClockTxt.Position.Z:=-1;//((Height+400)/4)*-1;
  fClockTxt.Text:='12:00 P';
  fClockTxt.Font.Size:=48;
  fClockTxt.Font.Style:=[TFontStyle.fsBold];
  fClockTxt.MaterialSource:=StylesDm.tmGold;
  fClockTxt.MaterialBackSource:=stylesDm.cmWhiteTxt;
  fClockTxt.MaterialShaftSource:=stylesDm.cmWhiteTxt;
  fClockTxt.OnClick:=DoClose;
  fClockTxt.Visible:=true;
 }



  fTxt:=TText3d.Create(nil);
  fTxt.Projection:=tProjection.Screen;
  fTxt.Parent:=self;
  fTxt.Depth:=2;
  fTxt.Stretch:=true;
  fTxt.WordWrap:=false;
  fTxt.Width:=Width/8;
  fTxt.Height:=Height/55;
  fTxt.Position.X:=((Width/2)*-1)+(fTxt.Width/2)+(aGap);
  fTxt.Position.Y:=((Height/2))-(fTxt.Height);
  fTxt.Position.Z:=-1;//((Height+400)/4)*-1;
  fTxt.Text:='Delphi -The future coded now..';
  fTxt.MaterialSource:=DlgMaterial.TextColor;
  fTxt.MaterialBackSource:=DlgMaterial.TextColor;
  fTxt.MaterialShaftSource:=DlgMaterial.TextColor;
  fTxt.OnClick:=DoClose;
  fTxt.Visible:=true;

  fWebTxt:=TText3d.Create(nil);
  fWebTxt.Projection:=tProjection.Screen;
  fWebTxt.Parent:=self;//TDummy(sender);
  fWebTxt.Depth:=2;
  fWebTxt.Stretch:=true;
  fWebTxt.Width:=Width/10;
  fWebTxt.Height:=Height/55;
  fWebTxt.WordWrap:=false;
  fWebTxt.Position.X:=((Width/2)-(fWebTxt.Width/2))-aGap;
  fWebTxt.Position.Y:=((Height/2))-(fWebTxt.Height);
  fWebTxt.Position.Z:=-1;
  fWebTxt.Text:='www.qubits.us';
  fWebTxt.MaterialSource:=DlgMaterial.TextColor;
  fWebTxt.MaterialBackSource:=DlgMaterial.TextColor;
  fWebTxt.MaterialShaftSource:=DlgMaterial.TextColor;
  fWebTxt.OnClick:=DoClose;
  fWebTxt.Visible:=true;






  fAniSpin:=TFloatAnimation.Create(nil);
  fAniSpin.Duration:=180;
  fAniSpin.StartValue:=0;
  fAniSpin.StopValue:=360;
  fAniSpin.Loop:=true;
  fAniSpin.Parent:=fGlobe;
  fAniSpin.PropertyName:='RotationAngle.Y';
  fAniSpin.Enabled:=true;

  fAniMoonSpin:=TFloatAnimation.Create(nil);
  fAniMoonSpin.Duration:=45;
  fAniMoonSpin.StartValue:=0;
  fAniMoonSpin.StopValue:=360;
  fAniMoonSpin.Loop:=true;
  fAniMoonSpin.Parent:=fMoon;
  fAniMoonSpin.PropertyName:='RotationAngle.Y';
  fAniMoonSpin.Enabled:=false;
 {
  fBorgSpin:=TFloatAnimation.Create(nil);
  fBorgSpin.Duration:=180;
  fBorgSpin.StartValue:=0;
  fBorgSpin.StopValue:=360;
  fBorgSpin.Loop:=true;
  fBorgSpin.Parent:=fBorg;
  fBorgSpin.PropertyName:='RotationAngle.Y';
  fBorgSpin.Enabled:=False;  }

end;

Destructor TDlgWorldAni.Destroy;
begin

  if not fCleanedUp then CleanUp;


  Inherited;
end;

procedure TDlgWorldAni.CleanUp;
var
i:integer;
begin
  //destroy

  fAniSpin.Stop;
  fAniSpin.Parent:=nil;
  fAniSpin.free;
  fAniSpin:=nil;
  fAniMoonSpin.Stop;
  fAniMoonSpin.Parent:=nil;
  fAniMoonSpin.free;
  fAniMoonSpin:=nil;
  {
  fBorgSpin.Stop;
  fBorgSpin.Parent:=nil;
  fBorgSpin.free;
  fBorgSpin:=nil;    }

  fMoon.MaterialSource:=nil;
  fMoon.Parent:=nil;
  fMoon.OnMouseDown:=nil;
  fMoon.OnMouseUp:=nil;
  fMoon.free;
  fMoon:=nil;

  fIm.Parent:=nil;
  fIm.OnClick:=nil;
  fIm.Bitmap:=nil;

  fIm.Free;
  fIm:=nil;

  {
  fBorg.MaterialSource:=nil;
  fBorg.OnClick:=nil;
  fBorg.Parent:=nil;
  fBorg.Free;
  fBorg:=nil;    }

  fGlobe.MaterialSource:=nil;
  fGlobe.Parent:=nil;
  fGlobe.OnClick:=nil;
  fGlobe.Free;
  fGlobe:=nil;

  fWebTxt.Text:='';
  fWebTxt.MaterialBackSource:=nil;
  fWebTxt.MaterialShaftSource:=nil;
  fWebTxt.MaterialSource:=nil;
  fWebTxt.Parent:=nil;
  fWebTxt.OnClick:=nil;
  fWebTxt.Free;
  fWebTxt:=nil;

  fTxt.Text:='';
  fTxt.MaterialBackSource:=nil;
  fTxt.MaterialShaftSource:=nil;
  fTxt.MaterialSource:=nil;
  fTxt.Parent:=nil;
  fTxt.OnClick:=nil;
  fTxt.Free;
  fTxt:=nil;

  fCloseEvent:=nil;
  Parent:=nil;
  fCleanedUp:=true;

end;


procedure TDlgWorldAni.DoClose(sender: TObject);
begin
if fCloseOnce then exit;//only one time please
  fCloseOnce:=true;

  if Assigned(fCloseEvent) then
      fCloseEvent(nil);
end;


procedure TDlgWorldAni.MoonMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Single; Y: Single; RayPos: TVector3D; RayDir: TVector3D);
begin
  fDownx:=X;
end;

procedure TDlgWorldAni.MoonMouseup(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Single; Y: Single; RayPos,
                                   RayDir: TVector3D);
begin

  if x>fDownX then
     begin
       //spin left
      fAniMoonSpin.Stop;
      fAniMoonSpin.StartValue:=360;
      fAniMoonSpin.StopValue:=0;
      fAniMoonSpin.Start;
     end else
        begin
          //spin right
        fAniMoonSpin.Stop;
        fAniMoonSpin.StartValue:=0;
        fAniMoonSpin.StopValue:=360;
        fAniMoonSpin.Start;

        end;
end;

procedure TDlgWorldAni.BorgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Single; Y: Single; RayPos: TVector3D; RayDir: TVector3D);
begin
  bDownx:=X;
end;

procedure TDlgWorldAni.BorgMouseup(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Single; Y: Single; RayPos,
                                   RayDir: TVector3D);
begin

{
  if x>bDownX then
     begin
       //spin left
      fBorgSpin.Stop;
      fBorgSpin.StartValue:=360;
      fBorgSpin.StopValue:=0;
      fBorgSpin.Start;
     end else
        begin
          //spin right
        fBorgSpin.Stop;
        fBorgSpin.StartValue:=0;
        fBorgSpin.StopValue:=360;
        fBorgSpin.Start;
        end;    }
end;





end.
