{Screen cam dialog controls for 3d
 Created for Inertia 12.18.19-dm

 1.16.22 - hand draw all text, except for the spot  -dm



 be it harm now, do as ye wish..

 }
unit uDlg3dCtrls;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.UIConsts,
  FMX.Objects,FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, System.Math.Vectors, FMX.Ani, FMX.Controls3D,FMX.Materials,
  FMX.MaterialSources, FMX.Objects3D, FMX.Effects, FMX.Filter.Effects,FMX.Layers3D;



type
  TDlgSelect_Event  = procedure (Sender:TObject; Selected:integer) of object;
  TDlgClick_Event  = procedure (Sender:TObject) of object;
  TDlgDoneClick_Event  = procedure (Sender:TObject) of object;
  TDlgCancelClick_Event  = procedure (Sender:TObject) of object;
  TDlgCheckInClick_Event  = procedure (Sender:TObject; aNumPlayers:integer;aMode:integer) of object;




type
TDlgMaterialStyle=class(TFmxObject)
  private
  fmtButtonImage:TTextureMaterialSource;
  fmtRectImage:TTextureMaterialSource;
  fmtVRectImage:TTextureMaterialSource;
  fTextColor:TColorMaterialSource;
  fColor:byte;
  fBorder:byte;
  fBorderColor:byte;
  public
  constructor create(aowner:TComponent);reintroduce;
  destructor  destroy;override;
  property Button:TTextureMaterialSource read fmtButtonImage write fmtButtonImage;
  property Rect:TTextureMaterialSource read fmtRectImage write fmtRectImage;
  property VRect:TTextureMaterialSource read fmtVRectImage write fmtVRectImage;
  property TextColor:TColorMaterialSource read fTextColor write fTextColor;
  property Color:byte read fColor write fColor;
  property Border:byte read fBorder write fBorder;
  property BorderColor:byte read fBorderColor write fBorderColor;
  end;

type
TDlgMaterial =class(TFmxObject)
  private
  fmtButtons:TDlgMaterialStyle;
  fmtDown:TDlgMaterialStyle;
  fmtSmall:TDlgMaterialStyle;
  fmtLarge:TDlgMaterialStyle;
  fRedTxt:TColorMaterialSource;
  fGreenTxt:TColorMaterialSource;
  fTextColor:TColorMaterialSource;
  fLongRect:TTextureMaterialSource;
  fBigRedRect:TTextureMaterialSource;
  fFontSize:integer;
  fBackIm:TBitmap;
  fBorder:byte;
  fBorderColor:byte;
  public
  constructor create(aowner:TComponent);reintroduce;
  destructor  destroy;override;
  property Small:TDlgMaterialStyle read fmtSmall write fmtSmall;
  property Large:TDlgMaterialStyle read fmtLarge write fmtLarge;
  property Buttons:TDlgMaterialStyle read fmtButtons write fmtButtons;
  property Down:TDlgMaterialStyle read fmtDown write fmtDown;
  property LongRects:TTextureMaterialSource read fLongRect write fLongRect;
  property RedRects:TTextureMaterialSource read fBigRedRect write fBigRedRect;
  property FontSize:integer read fFontSize write fFontSize;
  property BackImage:TBitmap read fBackIm write fBackIm;
  property TextColor:TColorMaterialSource read fTextColor write fTextColor;
  property RedTxt:TColorMaterialSource read fRedTxt write fRedTxt;
  property GreenTxt:TColorMaterialSource read fGreenTxt write fGreenTxt;
  property Border:byte read fBorder write fBorder;
  property BorderColor:byte read fBorderColor write fBorderColor;
  end;

type
TDlgSpot = class(TDummy)
private
fPinNum:integer;
fTxtSpot:TText3D;
fSpot:TSphere;
fClickEvent:TDlgClick_Event;
fSelected:Boolean;
fCleanedUp:Boolean;
procedure DoClick(sender:tObject);
public
constructor Create(aOwner:TComponent; aWidth: single; aHeight: single;ax,ay:single); reintroduce;
destructor Destroy;override;
procedure  CleanUp;
published
property Spot:TSphere read fSpot write fSpot;
property SpotText:TText3d read fTxtSpot write fTxtSpot;
property PinNum:integer read fPinNum write fPinNum;
property OnClick:TDlgClick_Event read fClickEvent write fClickEvent;
property Selected:boolean read fSelected write fSelected;
end;

type
TDlgButton = class(TRectangle3d)
private
fKeyNum:integer;
fClickEvent:TDlgClick_Event;
fSelected:Boolean;
fCleanedUp:Boolean;
fBtnTexture:TTextureMaterialSource;
fBitmapBtn:TBitmap;
fText:String;
fFontSize:Single;
fTxtColor:TAlphaColor;
fTxtFixed:Boolean;
procedure DoClick(sender:tObject);
procedure SetText(aStr:String);
public
procedure DrawText;
constructor Create(aOwner:TComponent; aWidth: single; aHeight: single;ax,ay:single); reintroduce;
destructor Destroy;override;
procedure CleanUp;

published
property Text:string read fText write SetText;
property FontSize:single read fFontSize write fFontSize;
property TextColor:TAlphaColor read fTxtColor write fTxtColor;
property KeyNum:integer read fKeyNum write fKeyNum;
property Selected:boolean read fSelected write fSelected;
property CleanedUp:boolean read fCleanedUp;
property TextFixed:boolean read fTxtFixed write fTxtFixed;
property BtnBitMap:tBitmap read fBitmapBtn write fBitmapBtn;
end;


type
TDlgInputButton = class(TRectangle3d)
private
fKeyNum:integer;
fLabel:String;
fRecId:integer;
fValByte:byte;
fValInt:integer;
fValStr:string;
fClickEvent:TDlgClick_Event;
fBtnTexture:TTextureMaterialSource;
fBitmapBtn:TBitmap;
fText:String;
fLabelTxt:String;
fTextVAlign:TVerticalAlignment;
fLabelAlign:TAlignment;
fFontSize:Single;
fLblSize:Single;
fTxtColor:TAlphaColor;
fLblColor:TAlphaColor;
fTxtFixed:boolean;
fLblFixed:boolean;

fCleanedUp:Boolean;

procedure SetLabel(value:string);
procedure DoClick(sender:tObject);
procedure SetText(aString:string);
procedure SetLabelTxt(aString:String);
public
constructor Create(aOwner:TComponent; aWidth: single; aHeight: single;ax,ay:single); reintroduce;
destructor Destroy;override;
procedure  CleanUp;
procedure DrawText;
published
property Text:string read fText write SetText;
property TextVAlign:TVerticalAlignment read fTextVAlign write fTextVAlign;
property LabelText:string read fLabelTxt write SetLabelTxt;
property FontSize:single read fFontSize write fFontSize;
property TextColor:TAlphaColor read fTxtColor write fTxtColor;
property LabelColor:TAlphaColor read fLblColor write fLblColor;
property LabelSize:single read fLblSize write fLblSize;
property TextFixed:boolean read fTxtFixed write fTxtFixed;
property LabelFixed:boolean read fLblFixed write fLblFixed;
property LabelAlignment:tAlignment read fLabelAlign write fLabelAlign;
property KeyNum:integer read fKeyNum write fKeyNum;
property KeyLabel:string read fLabel write SetLabel;
property RecordID:integer read fRecID write fRecID;
property ByteValue:byte read fValByte write fValByte;
property IntValue:integer read fValInt write fValInt;
property StrValue:string read fValStr write fValStr;
property CleanedUp:boolean read fCleanedUp;
property BtnBitMap:tBitmap read fBitmapBtn write fBitmapBtn;
end;

type
TDlgImageButton = class(TRectangle3d)
private
fKeyNum:integer;
fIm:TImage3d;
fClickEvent:TDlgClick_Event;
fCleanedUp:boolean;
fBtnTexture:TTextureMaterialSource;
fBitmapBtn:TBitmap;
fText:String;
fFontSize:Single;
fTxtColor:TAlphaColor;
fUseFixed:boolean;

procedure SetText(aStr:String);
public
constructor Create(aOwner:TComponent; aWidth: single; aHeight: single;ax,ay:single); reintroduce;
destructor Destroy;override;
procedure CleanUp;
published
property Text:string read fText write SetText;
property FontSize:single read fFontSize write fFontSize;
property TextColor:TAlphaColor read fTxtColor write fTxtColor;
property BtnIm:TImage3d read fIm write fIm;
property KeyNum:integer read fKeyNum write fKeyNum;
property BtnBitMap:tBitmap read fBitmapBtn write fBitmapBtn;
property UseFixed:boolean read fUseFixed write fUseFixed;
end;



type
TDlgText = class(TRectangle3d)
private
fMsg:String;
fCleanedUp:boolean;
fBtnTexture:TTextureMaterialSource;
fBitmapBtn:TBitmap;
fText:String;
fFontSize:Single;
fTxtColor:TAlphaColor;

procedure SetMsg(aString:String);
function  GetMsg:String;
procedure SetText(aStr:String);
public
constructor Create(aOwner:TComponent; aWidth: single; aHeight: single;ax,ay:single); reintroduce;
destructor Destroy;override;
procedure CleanUp;
published
property Msg:string read GetMSg write SetMsg;
property BtnBitMap:tBitmap read fBitmapBtn write fBitmapBtn;
property Text:string read fText write SetText;
property FontSize:single read fFontSize write fFontSize;
property TextColor:TAlphaColor read fTxtColor write fTxtColor;
end;



Function MakeThumb(aBitMap:tBitMap;h,w:integer):tBitmap;


var
DlgMaterial:TDlgMaterial;
CurrentScale:single;



implementation






Function MakeThumb(aBitMap:tBitMap;h,w:integer):tBitmap;
var
aRect,bRect:TRectF;
begin
          aRect:=TRectF.Create(0,0,aBitmap.Width,aBitmap.Height);
          bRect:=TRectF.Create(0,0,w,h);
          result:=tBitmap.Create(w,h);
          //draw also resizes
          result.Canvas.BeginScene;
          result.Canvas.DrawBitmap(aBitmap,aRect,bRect,1,False);
          result.Canvas.EndScene;
end;





{Dialog Materials}
constructor TDlgMaterial.create(aowner: TComponent);
begin
  inherited;
  fmtButtons:=TDlgMaterialStyle.create(self);
  fmtDown:=TDlgMaterialStyle.create(self);
  fmtSmall:=TDlgMaterialStyle.create(self);
  fmtLarge:=TDlgMaterialStyle.create(self);
  fBackIm:=TBitmap.Create;
  fGreenTxt:=TColorMaterialSource.Create(self);
  fGreenTxt.Color:=claGreen;
  fRedTxt:=TColorMaterialSource.Create(self);
  fRedTxt.Color:=claRed;
  fTextColor:=TColorMaterialSource.Create(self);
  fTextColor.Color:=claWhite;
  fLongRect:=TTextureMaterialSource.Create(self);
  fBigRedRect:=TTextureMaterialSource.Create(self);

  fBorder:=0;
  fBorderColor:=17;//black
end;

destructor TDlgMaterial.Destroy;
begin
  try
    fmtButtons.Free;
    fmtButtons:=nil;
    fmtDown.Free;
    fmtDown:=nil;
    fmtSmall.Free;
    fmtLarge.Free;
    fBackIm.Free;
    fBackIm:=nil;
    fGreenTxt.Free;
    fGreenTxt:=nil;
    fRedTxt.Free;
    fRedTxt:=nil;
    fTextColor.Free;
    fLongRect.Free;
    fLongRect:=nil;
    fBigRedRect.Free;
    //fafa
  finally
  inherited;
  end;
end;

{Material Style}
constructor TDlgMaterialStyle.create;
begin
  inherited;
  fmtButtonImage:=TTextureMaterialSource.Create(self);
  fmtRectImage:=TTextureMaterialSource.Create(self);
  fTextColor:=TColorMaterialSource.Create(self);
  fmtVRectImage:=TTextureMaterialSource.Create(self);
  fTextColor.Color:=claBlack;
  fColor:=3;
  fBorder:=0;
  fBorderColor:=17;
end;

destructor TDlgMaterialStyle.Destroy;
begin
  //clean house
  try
    fmtVRectImage.Free;
    fmtVRectImage:=nil;
    fmtButtonImage.Free;
    fmtButtonImage:=nil;
    fmtRectImage.Free;
    fmtRectImage:=nil;
    fTextColor.Free;
    fTextColor:=nil;
  finally
    //fafa
  inherited;
  end;
end;

{Spot used for dotting in ocp config dlg}
{todo: how the frack do i hand draw this text, the pic is going to be layered on a sphere!!??}

constructor TDlgSpot.Create(aOwner: TComponent; aWidth: single; aHeight: single; ax: single; ay: single);
var
aGap:single;
begin
inherited Create(aOwner);
fCleanedUp:=false;

  //set w,h and pos
  Projection:=TProjection.Screen;
  Width:=aWidth;
  Height:=aHeight;
  Position.X:=aX;
  Position.Y:=aY;
  Depth:=1;
  aGap:=2;
  fSelected:=false;
  //create sphere first
  fSpot:=TSphere.Create(self);
  fSpot.Projection:=TProjection.Screen;
  fSpot.Parent:=self;
  fSpot.Depth:=1;
  fSpot.Width:=(aWidth-1 );
  fSpot.Height:=(aHeight-1);
  fSpot.Position.X:=0;
  fSpot.Position.Y:=0;
  fSpot.Position.Z:=0;
  fSpot.HitTest:=false;

  //text is owned by the sphere
  fTxtSpot:=TText3D.Create(self);
  fTxtSpot.Parent:=fSpot;
  fTxtSpot.Projection:=TProjection.Screen;
  fTxtSpot.height:=fSpot.Height-aGap;
  fTxtSpot.Width:=fSpot.Width-aGap;
  fTxtSpot.Position.X:=0;
  fTxtSpot.Position.Y:=0;
  fTxtSpot.Position.Z:=-1;
  fTxtSpot.Depth:=1;
  fTxtSpot.WrapMode:=TMeshWrapMode.Stretch;
  fTxtSpot.WordWrap:=false;
  fTxtSpot.Font.Size:=8;
  fTxtSpot.TwoSide:=false;
  fTxtSpot.Sides:=[TExtrudedShapeSide.Front];
  fTxtSpot.HitTest:=false;



end;

Destructor TDlgSpot.Destroy;
begin

 if not fCleanedUp then CleanUp;
  inherited;
end;

procedure TDlgSpot.CleanUp;
begin

if fCleanedUp then Exit;


  fTxtSpot.Free;
  fTxtSpot:=nil;
  fSpot.Free;
  fSpot:=nil;
  fClickEvent:=nil;

  Parent:=nil;
  fCleanedUp:=true;

end;

procedure TDlgSpot.DoClick(sender: TObject);
begin
  if assigned(fClickEvent) then
     fClickEvent(nil);
end;




{Dialog button}
constructor TDlgButton.Create(aOwner: TComponent; aWidth: single; aHeight: single; ax: single; ay: single);
var
aGap:single;
begin
inherited Create(aOwner);

  fCleanedUp:=false;

  //set w,h and pos
  Projection:=TProjection.Screen;

  fBitmapBtn:=tBitmap.Create;
  fBtnTexture:=TTextureMaterialSource.Create(self);
  fTxtFixed:=false;

  Width:=aWidth;
  Height:=aHeight;
  Position.X:=aX;
  Position.Y:=aY;
  Depth:=1;
  aGap:=2;
  fSelected:=false;
  Parent:=self;
  Sides:=[TExtrudedShapeSide.Front];
  HitTest:=true;



end;

destructor TDlgButton.Destroy;
begin
if not fCleanedUp then CleanUp;
inherited;
end;


procedure TDlgButton.CleanUp;
begin
if fCleanedUp then exit;



if assigned(fBitmapBtn) then
   fBitmapBtn.Free;

if Assigned(fBtnTexture) then
    fBtnTexture.Free;

Parent:=nil;
fClickEvent:=nil;
fCleanedUp:=true;
end;



procedure TDlgButton.DoClick(sender: TObject);
begin
  if assigned(fClickEvent) then
      fClickEvent(sender);
end;

procedure TDlgButton.SetText(aStr: string);
begin
  if aStr=fText then exit;
    fText:=aStr;
    DrawText;
end;

procedure TDlgButton.DrawText;
var
aGap:single;
aRect,bRect:TRectF;
tmpBmp:tBitmap;
w,h,th,tw,wts,fs:single;
aScaledW,aScaledH:single;
begin

   aGap:=2;

   if Assigned(fBitmapBtn) then
     begin
         fBtnTexture.Texture.Assign(fBitmapBtn);
       if fText='' then
        begin
            MaterialSource:=fBtnTexture;
        end
          else
          begin

           aScaledW:=Width*CurrentScale;
           aScaledH:=Height*CurrentScale;


          aRect:=TRectF.Create(0,0,fBitmapBtn.Width,fBitmapBtn.Height);
          bRect:=TRectF.Create(0,0,Trunc(aScaledW),Trunc(aScaledH));

          tmpBmp:=tBitmap.Create(Trunc(aScaledW),Trunc(aScaledH));
          tmpBmp.Clear(claNull);
          //draw also resizes
          tmpBmp.Canvas.BeginScene;
          tmpBmp.Canvas.DrawBitmap(fBitmapBtn,aRect,bRect,1,False);
          tmpBmp.Canvas.EndScene;

          w:=tmpBmp.Width;
          h:=tmpBmp.Height;
          wts:=h/1.5;//wanted text size a 1.5 for buttons should give 1/4 space
          fs:=fFontSize*CurrentScale;//multiply fontsize by scale??
          tmpBmp.Canvas.Font.Size:=fs;
          tmpBmp.Canvas.Font.Style:=[TFontStyle.fsBold];
          tmpBmp.Canvas.Fill.Color:=fTxtColor;
          tmpBmp.Canvas.Stroke.Color:=fTxtColor;
          if not fTxtFixed then
           begin
          //reduce height if needed
          th:=tmpBmp.Canvas.TextHeight(fText);
           if th>wts then
            begin
              while th>wts do
                begin
                fs:=fs-2;
                tmpBmp.Canvas.Font.Size:=fs;
                th:=tmpBmp.Canvas.TextHeight(fText);
                end;
            end;

          //reduce if width too big
          tw:=tmpBmp.Canvas.TextWidth(fText);
          if tw>(w-(aGap*2)) then
            begin
              while tw>(w-(aGap*2)) do
                begin
                fs:=fs-2;
                tmpBmp.Canvas.Font.Size:=fs;
                tw:=tmpBmp.Canvas.TextWidth(fText);
                end;
            end;
           end else
              begin
                th:=tmpBmp.Canvas.TextHeight(fText);
              end;



           if (h>0) and (w>0) then
           begin
           aRect:=TRectF.Create(aGap,aGap,w-agap,h-agap);
           tmpBmp.Canvas.BeginScene;
           tmpBmp.Canvas.FillText(aRect, fText, false, 1,[], TTextAlign.Center, TTextAlign.Center);
           tmpBmp.Canvas.EndScene;
           fBtnTexture.Texture.Assign(tmpBmp);
           MaterialSource:=fBtnTexture;
           end;
           tmpBmp.Free;
          end;
     end;









end;



{Dialog input button contains a small label in top left corner}
constructor TDlgInputButton.Create(aOwner: TComponent; aWidth: single; aHeight: single; ax: single; ay: single);
var
aGap:single;
begin
inherited Create(aOwner);
  fCleanedUp:=false;
  //set w,h and pos
  Projection:=TProjection.Screen;
  Width:=aWidth;
  Height:=aHeight;
  Position.X:=aX;
  Position.Y:=aY;
  Depth:=1;
  aGap:=2;
  fBitmapBtn:=tBitmap.Create;
  fBtnTexture:=TTextureMaterialSource.Create(self);
   fTxtFixed:=false;
   fLblFixed:=false;
   fLblColor:=claBlack;
   fTxtColor:=claBlack;
   fLabelAlign:=TAlignment.taLeftJustify;
   fTextVAlign:=TVerticalAlignment.taVerticalCenter;

   fLblSize:=0;
   fFontSize:=12;

fRecId:=0;
fValByte:=0;
fValInt:=0;
fValStr:='';
  Parent:=self;
  Sides:=[TExtrudedShapeSide.Front];
  HitTest:=true;

end;

destructor TDlgInputButton.Destroy;
begin

if not fCleanedUp then CleanUp;

inherited;

end;

procedure TDlgInputButton.CleanUp;
begin

if fCleanedUp then Exit;


try
if assigned(fBitmapBtn) then
   fBitmapBtn.Free;

if Assigned(fBtnTexture) then
    fBtnTexture.Free;


fLabel:='';
fValStr:='';
fClickEvent:=nil;

Parent:=nil;
finally
fCleanedUp:=true;
end;
end;



procedure TDlgInputButton.SetLabel(value: string);
begin
  if fLabel=value then exit;

  fLabel:=value;

end;


procedure TDlgInputButton.DoClick(sender: TObject);
begin
  if Assigned(fClickEvent) then
       fClickEvent(self);
end;


procedure TDlgInputButton.SetText(aString: string);
begin
  if aString=fText then exit;
     fText:=aString;
       DrawText;
end;
procedure TDlgInputButton.SetLabelTxt(aString: string);
begin
  if aString=fLabelTxt then exit;
     fLabelTxt:=aString;
       DrawText;
end;


procedure TDlgInputButton.DrawText;
var
aGap:single;
aRect,bRect:TRectF;
tmpBmp:tBitmap;
w,h,th,tw,wts,wls,fs,ls:single;
aScaledW,aScaledH:single;

begin

    fs:=10;
    ls:=8;


   aGap:=2;

   if Assigned(fBitmapBtn) then
     begin
         fBtnTexture.Texture.Assign(fBitmapBtn);
       if (fText='') and (fLabelTxt='') then
        begin
            MaterialSource:=fBtnTexture;
        end
          else
          begin
           aScaledW:=Width*CurrentScale;
           aScaledH:=Height*CurrentScale;

          aRect:=TRectF.Create(0,0,fBitmapBtn.Width,fBitmapBtn.Height);
          bRect:=TRectF.Create(0,0,Trunc(aScaledW),Trunc(aScaledH));

          tmpBmp:=tBitmap.Create(Trunc(aScaledW),Trunc(aScaledH));
          tmpBmp.Clear(claNull);
          tmpBmp.Canvas.BeginScene;
          tmpBmp.Canvas.DrawBitmap(fBitmapBtn,aRect,bRect,1,False);
          tmpBmp.Canvas.EndScene;
          w:=tmpBmp.Width;
          h:=tmpBmp.Height;
          wts:=h/1.3;//wanted text size a half for buttons
             if not fTxtFixed then
             begin
               if fText <> '' then
               begin
                 fs := fFontSize*CurrentScale; // starting point
                 tmpBmp.Canvas.Font.Size := fs;
                 tmpBmp.Canvas.Font.Style := [TFontStyle.fsBold];
                 tmpBmp.Canvas.Fill.Color := fTxtColor;
                 // reduce height if needed
                 th := tmpBmp.Canvas.TextHeight(fText);
                 if th > wts then
                 begin
                   while th > wts do
                   begin
                     fs := fs - 5;
                     tmpBmp.Canvas.Font.Size := fs;
                     th := tmpBmp.Canvas.TextHeight(fText);
                   end;
                 end;

                 // reduce if width too big
                 tw := tmpBmp.Canvas.TextWidth(fText);
                 if tw > (w - (aGap * 4)) then
                 begin
                   while tw > (w - (aGap * 4)) do
                   begin
                     fs := fs - 5;
                     tmpBmp.Canvas.Font.Size := fs;
                     tw := tmpBmp.Canvas.TextWidth(fText);
                   end;
                 end;
               end;
             end else
                begin
                 if fText<>'' then
                  begin
                    //using fixed font size
                    fs:=fFontSize*CurrentScale;//??
                   tmpBmp.Canvas.Font.Size := fs;
                   tmpBmp.Canvas.Font.Style := [TFontStyle.fsBold];
                   tmpBmp.Canvas.Fill.Color := fTxtColor;
                   // reduce height if needed
                   th := tmpBmp.Canvas.TextHeight(fText);
                  end;

                end;


                 //now the label
                if fLabelTxt <> '' then
                begin
                  //if label font size not set..
                  if fLblSize=0 then
                     fLblSize:=(fFontSize-(fFontSize/4))*CurrentScale;

                 if not fLblFixed then
                  begin
                  wts := h / 2.7;
                  ls := fLblSize*CurrentScale; // do it again..
                  // reduce height if needed
                  th := tmpBmp.Canvas.TextHeight(fLabelTxt);
                  if th > wts then
                  begin
                    while th > wts do
                    begin
                      ls := ls - 5;
                      tmpBmp.Canvas.Font.Size := ls;
                      th := tmpBmp.Canvas.TextHeight(fLabelTxt);
                    end;
                  end;

                  // reduce if width too big
                  tw := tmpBmp.Canvas.TextWidth(fLabelTxt);
                  if tw > (w - (aGap * 4)) then
                  begin
                    while tw > (w - (aGap * 4)) do
                    begin
                      ls := ls - 5;
                      tmpBmp.Canvas.Font.Size := ls;
                      tw := tmpBmp.Canvas.TextWidth(fLabelTxt);
                    end;
                  end;
                  end else
                     begin
                       ls:=fLblSize*CurrentScale;
                        //no zero's please..
                       if ls=0 then ls:=10;

                     end;
                end;


                tmpBmp.Canvas.Font.Size:=fs;
                tmpBmp.Canvas.Font.Style := [TFontStyle.fsBold];
                tmpBmp.Canvas.Fill.Color := fTxtColor;
                th:=tmpBmp.Canvas.TextHeight(fText);


           if (h>0) and (w>0) then //no tall skinnys
           begin

           aRect:=TRectF.Create(aGap,Trunc((h/2)-th),w-agap,Trunc((h/2)+th));
           tmpBmp.Canvas.BeginScene;
           if fText<>'' then
              begin
              if fTextVAlign=tVerticalAlignment.taAlignTop then
               tmpBmp.Canvas.FillText(aRect, fText, false, 1,[], TTextAlign.Center, TTextAlign.Leading) else
              if fTextVAlign=tVerticalAlignment.taVerticalCenter then
               tmpBmp.Canvas.FillText(aRect, fText, false, 1,[], TTextAlign.Center, TTextAlign.Center) else
              if fTextVAlign=tVerticalAlignment.taAlignBottom then
               tmpBmp.Canvas.FillText(aRect, fText, false, 1,[], TTextAlign.Center, TTextAlign.Trailing);
              end;

           tmpBmp.Canvas.Font.Size:=ls;
           th:=tmpBmp.Canvas.TextHeight(fLabelTxt);
           aRect:=TRectF.Create(aGap,aGap,w-agap,th+aGap);
           tmpBmp.Canvas.Fill.Color := fLblColor;


           if fLabelTxt<>'' then
             begin
             if fLabelAlign=TAlignment.taLeftJustify then
              tmpBmp.Canvas.FillText(aRect, fLabelTxt, false, 1,[], TTextAlign.Leading, TTextAlign.Leading) else
             if fLabelAlign=TAlignment.taCenter then
              tmpBmp.Canvas.FillText(aRect, fLabelTxt, false, 1,[], TTextAlign.Center, TTextAlign.Leading) else
             if fLabelAlign=TAlignment.taRightJustify then
              tmpBmp.Canvas.FillText(aRect, fLabelTxt, false, 1,[], TTextAlign.Trailing, TTextAlign.Leading);
             end;

           tmpBmp.Canvas.EndScene;

             fBtnTexture.Texture.Assign(tmpBmp);
             MaterialSource:=fBtnTexture;
           end;
           tmpBmp.Free;
          end;
     end;







end;



{Dialog image button contains image and a small label}
constructor TDlgImageButton.Create(aOwner: TComponent; aWidth: single; aHeight: single; ax: single; ay: single);
var
aGap:single;
aPicWidth,aPicHeight:single;
tmpBitmap:tBitmap;
begin
inherited Create(aOwner);
fCleanedUp:=False;
  //set w,h and pos
  Projection:=TProjection.Screen;
  fBitmapBtn:=tBitmap.Create;
  fBtnTexture:=TTextureMaterialSource.Create(self);
  fUseFixed:=False;

  Width:=aWidth;
  Height:=aHeight;
  Depth:=1;
  aGap:=2;
  aPicHeight:=(aHeight/3)*2;
  aPicHeight:=aPicHeight-(aGap*8);
  aPicWidth:=aWidth-(aGap*10);
  Position.X:=aX;
  Position.Y:=aY;
  Parent:=self;
  HitTest:=true;
  Sides:=[TExtrudedShapeSide.Front];



   tmpBitmap:=tBitmap.Create(Trunc(aPicWidth),Trunc(aPicHeight));
   tmpBitmap.Clear(claNull);

  fIm:=TImage3d.Create(self);
  fIm.Projection:=TProjection.Screen;
  fIm.HitTest:=false;
  fIm.Width:=aPicWidth;
  fIm.Height:=aPicHeight;
  fIm.HitTest:=false;
  fIm.Parent:=Self;
  fIm.Position.X:=0;
  fIm.Position.Y:=(Height/2)-(Height/3);
  fIm.Position.Z:=-1;
  fIm.WrapMode:=TImageWrapMode.Stretch;
  fIm.Bitmap.Assign(tmpBitmap);


  tmpBitmap.Free;






end;

destructor TDlgImageButton.Destroy;
begin
try
if not fCleanedUp then CleanUp;

finally
inherited;
end;
end;

procedure TDlgImageButton.CleanUp;
begin
if fCleanedUp then Exit;

try
fIm.Free;
fIm:=nil;

if assigned(fBitmapBtn) then
   fBitmapBtn.Free;

if Assigned(fBtnTexture) then
    fBtnTexture.Free;
fClickEvent:=nil;
Parent:=nil;
finally
fCleanedUp:=true;
end;
end;



procedure TDlgImageButton.SetText(aStr: string);
var
aGap:single;
aRect,bRect:TRectF;
tmpBmp:tBitmap;
w,h,th,tw,wts,fs:single;
aScaledW,aScaledH:single;

begin

   if aStr=fText then exit;//nothing to do

   fText:=aStr;
   aGap:=2;

   if Assigned(fBitmapBtn) then
     begin
         fBtnTexture.Texture.Assign(fBitmapBtn);
       if fText='' then
        begin
            MaterialSource:=fBtnTexture;
        end
          else
          begin
           aScaledW:=Width*CurrentScale;
           aScaledH:=Height*CurrentScale;

          aRect:=TRectF.Create(0,0,fBitmapBtn.Width,fBitmapBtn.Height);
          bRect:=TRectF.Create(0,0,Trunc(aScaledW),Trunc(aScaledH));

          tmpBmp:=tBitmap.Create(Trunc(aScaledW),Trunc(aScaledH));
          tmpBmp.Clear(claNull);
          tmpBmp.Canvas.BeginScene;
          tmpBmp.Canvas.DrawBitmap(fBitmapBtn,aRect,bRect,1,False);
          tmpBmp.Canvas.EndScene;

          w:=tmpBmp.Width;
          h:=tmpBmp.Height;
          wts:=h/3;//wanted text size a half for buttons

          if not fUseFixed then
           begin
          fs:=fFontSize*CurrentScale;
          tmpBmp.Canvas.Font.Size:=fs;
          tmpBmp.Canvas.Font.Style:=[TFontStyle.fsBold];
          tmpBmp.Canvas.Fill.Color:=fTxtColor;
          tmpBmp.Canvas.Stroke.Color:=fTxtColor;

          //reduce height if needed
          th:=tmpBmp.Canvas.TextHeight(fText);
           if th>wts then
            begin
              while th>wts do
                begin
                fs:=fs-1;
                tmpBmp.Canvas.Font.Size:=fs;
                th:=tmpBmp.Canvas.TextHeight(fText);
                end;
            end;

          //reduce if width too big
          tw:=tmpBmp.Canvas.TextWidth(fText);
          if tw>(w-(aGap*2)) then
            begin
              while tw>(w-(aGap*2)) do
                begin
                fs:=fs-1;
                tmpBmp.Canvas.Font.Size:=fs;
                tw:=tmpBmp.Canvas.TextWidth(fText);
                end;
            end;
           end else
              begin
              fs:=fFontSize*CurrentScale;
              tmpBmp.Canvas.Font.Size:=fs;
              tmpBmp.Canvas.Font.Style:=[TFontStyle.fsBold];
              tmpBmp.Canvas.Fill.Color:=fTxtColor;
              tmpBmp.Canvas.Stroke.Color:=fTxtColor;
                th:=tmpBmp.Canvas.TextHeight(fText);

              end;


           if (h>0) and (w>0) then //write some text
           begin
           aRect:=TRectF.Create(aGap,aGap,w-agap,th+aGap);

           tmpBmp.Canvas.BeginScene;
           tmpBmp.Canvas.FillText(aRect, fText, false, 1,
                [], TTextAlign.Center, TTextAlign.Center);
           tmpBmp.Canvas.EndScene;

           fBtnTexture.Texture.Assign(tmpBmp);

           MaterialSource:=fBtnTexture;


           end;
           tmpBmp.Free;
          end;
     end;

end;




{Dialog Text Contains a rect and some text}
constructor TDlgText.Create(aOwner: TComponent; aWidth: single; aHeight: single; ax: single; ay: single);
var
aBorder:single;
begin
inherited Create(aOwner);
fCleanedUp:=false;
  //set w,h and pos
  Projection:=TProjection.Screen;

  fBitmapBtn:=tBitmap.Create;
  fBtnTexture:=TTextureMaterialSource.Create(self);

  Width:=aWidth;
  Height:=aHeight;
  Position.X:=aX;
  Position.Y:=aY;
  Depth:=1;
  aBorder:=20;
  Parent:=self;
  Sides:=[TExtrudedShapeSide.Front];

end;

destructor TDlgText.Destroy;
begin
try
if not fCleanedUp then  CleanUp;
finally
inherited;
end;
end;

procedure TDlgText.CleanUp;
begin
  if fCleanedUp then Exit;

try

if assigned(fBitmapBtn) then
   fBitmapBtn.Free;

if Assigned(fBtnTexture) then
    fBtnTexture.Free;


Parent:=nil;
fCleanedUp:=true;
finally
end;
end;


procedure TDlgText.SetMsg(aString: string);
begin

  fMsg:=aString;
    SetText(aString);
end;


function TDlgText.GetMsg:string;
begin
 result:=fMsg;


end;



procedure TDlgText.SetText(aStr: string);
var
aGap:single;
aRect,bRect:TRectF;
tmpBmp:tBitmap;
w,h,th,tw,wts,fs:single;
aScaledW,aScaledH:single;

begin

   if aStr=fText then exit;//nothing to do

   fText:=aStr;
   aGap:=2;

   if Assigned(fBitmapBtn) then
     begin
         fBtnTexture.Texture.Assign(fBitmapBtn);
       if fText='' then
        begin
            MaterialSource:=fBtnTexture;
        end
          else
          begin
           aScaledW:=Width*CurrentScale;
           aScaledH:=Height*CurrentScale;


          aRect:=TRectF.Create(0,0,fBitmapBtn.Width,fBitmapBtn.Height);
          bRect:=TRectF.Create(0,0,Trunc(aScaledW),Trunc(aScaledH));

          tmpBmp:=tBitmap.Create(Trunc(aScaledW),Trunc(aScaledH));
          tmpBmp.Clear(claNull);
          //draw also resizes, nice job too.. :)
          tmpBmp.Canvas.BeginScene;
          tmpBmp.Canvas.DrawBitmap(fBitmapBtn,aRect,bRect,1,False);
          tmpBmp.Canvas.EndScene;

          w:=tmpBmp.Width;
          h:=tmpBmp.Height;
          wts:=h/1.5;//wanted text size a half for buttons
          fs:=fFontSize*CurrentScale;
          tmpBmp.Canvas.Font.Size:=fs;
          tmpBmp.Canvas.Font.Style:=[TFontStyle.fsBold];
          tmpBmp.Canvas.Fill.Color:=fTxtColor;
          tmpBmp.Canvas.Stroke.Color:=fTxtColor;

          //reduce height if needed
          th:=tmpBmp.Canvas.TextHeight(fText);
           if th>wts then
            begin
              while th>wts do
                begin
                fs:=fs-5;
                tmpBmp.Canvas.Font.Size:=fs;
                th:=tmpBmp.Canvas.TextHeight(fText);
                end;
            end;

          //reduce if width too big
          tw:=tmpBmp.Canvas.TextWidth(fText);
          if tw>(w-(aGap*2)) then
            begin
              while tw>(w-(aGap*2)) do
                begin
                fs:=fs-5;
                tmpBmp.Canvas.Font.Size:=fs;
                tw:=tmpBmp.Canvas.TextWidth(fText);
                end;
            end;



           if (h>0) and (w>0) then
           begin
           aRect:=TRectF.Create(aGap,aGap,w-agap,h-agap);
           tmpBmp.Canvas.BeginScene;
           tmpBmp.Canvas.FillText(aRect, fText, false, 1,[], TTextAlign.Center, TTextAlign.Center);
           tmpBmp.Canvas.EndScene;
            fBtnTexture.Texture.Assign(tmpBmp);
            MaterialSource:=fBtnTexture;
           end;
           tmpBmp.Free;
          end;
     end;









end;







end.
