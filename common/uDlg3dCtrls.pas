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
TDlgPinSpot = class(TDummy)
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

//basic button 1 line of text..

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
fRotated:boolean;
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
property Rotated:boolean read fRotated write fRotated;
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
fFontSize:Single;
fLblSize:Single;
fLabelAlign:TAlignment;
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
procedure DoClick(sender:tObject);
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
//fTxt:TText3D;
//fRectTxt:TRectangle3D;
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


//Grid cell
  TGridCell = Class(TRectangle3d)
  private
    fKeyNum: integer;
    fLabel: String;
    fRecId: integer;
    fValByte: byte;
    fValInt: integer;
    fValStr: string;
    fClickEvent: tDlgClick_Event;
    fBtnTexture: TTextureMaterialSource;
    fUpBtnTexture: TTextureMaterialSource;
    fBitmapBtn: TBitmap;
    fUpBitmap:tBitmap;

    fText: String;
    fText2:string;
    fText4:string;
    fLabelTxt: String;
    fTextVAlign: TVerticalAlignment;
    fFontSize: single;
    fLblSize: single;
    fLabelAlign: TAlignment;
    fTxtColor: TAlphaColor;
    fLblColor: TAlphaColor;
    fTxtFixed: boolean;
    fLblFixed: boolean;
    fCleanedUp: boolean;
    fUp:boolean;
    procedure SetLabel(value:string);
    procedure DoClick(sender:tObject);
    procedure SetText(aString:string);
    procedure SetText2(aString:string);
    procedure SetText4(aString:string);
    procedure SetLabelTxt(aString:String);
    procedure SetUp(aValue:boolean);
    procedure SetBtnBitmap(aValue:tBitmap);
    procedure SetUpBitmap(aValue:tBitmap);
  public
    constructor Create(aowner: TComponent; aWidth: single; aHeight: single; ax, ay: single); reintroduce;
    destructor Destroy; override;
    procedure CleanUp;
    procedure DrawText;
  published
    property Text: string read fText write SetText;
    property Text2: string read fText write SetText2;
    property Text4: string read fText write SetText4;
    property TextVAlign: TVerticalAlignment read fTextVAlign write fTextVAlign;
    property LabelText: string read fLabelTxt write SetLabelTxt;
    property FontSize: single read fFontSize write fFontSize;
    property TextColor: TAlphaColor read fTxtColor write fTxtColor;
    property LabelColor: TAlphaColor read fLblColor write fLblColor;
    property LabelSize: single read fLblSize write fLblSize;
    property TextFixed: boolean read fTxtFixed write fTxtFixed;
    property LabelFixed: boolean read fLblFixed write fLblFixed;
    property LabelAlignment: TAlignment read fLabelAlign write fLabelAlign;
    property KeyNum: integer read fKeyNum write fKeyNum;
    property KeyLabel: string read fLabel write SetLabel;
    property RecordID: integer read fRecId write fRecId;
    property ByteValue: byte read fValByte write fValByte;
    property IntValue: integer read fValInt write fValInt;
    property StrValue: string read fValStr write fValStr;
    property CleanedUp: boolean read fCleanedUp;
    property BtnBitMap: TBitmap read fBitmapBtn write SetBtnBitmap;
    property UpBitMap: TBitmap read fUpBitmap write SetUpBitmap;
    property Up:Boolean read fUp write SetUp;
  End;








Function MakeThumb(aBitMap:tBitMap;h,w:integer):tBitmap;


var
DlgMaterial:TDlgMaterial;
CurrentScale:single;



implementation

uses dmMaterials;




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

{Pin Spot used for dotting pins in ocp config dlg}

constructor TDlgPinSpot.Create(aOwner: TComponent; aWidth: single; aHeight: single; ax: single; ay: single);
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

Destructor TDlgPinSpot.Destroy;
begin

 if not fCleanedUp then CleanUp;
  inherited;
end;

procedure TDlgPinSpot.CleanUp;
begin

if fCleanedUp then Exit;



//  fTxtSpot.Parent:=nil;
 // fTxtSpot.Text:='';
 // fTxtSpot.MaterialBackSource:=nil;
//  fTxtSpot.MaterialShaftSource:=nil;
 // fTxtSpot.MaterialSource:=nil;
  fTxtSpot.Free;
  fTxtSpot:=nil;
 // fSpot.Parent:=nil;
 // fSpot.MaterialSource:=nil;
  fSpot.Free;
  fSpot:=nil;
  fClickEvent:=nil;

  Parent:=nil;
  fCleanedUp:=true;

end;

procedure TDlgPinSpot.DoClick(sender: TObject);
begin
  if assigned(fClickEvent) then
     fClickEvent(nil);
end;




{Dialog button contains a rect and 3dtext}
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
          if tmpBmp.Canvas.BeginScene then
          try
          tmpBmp.Canvas.DrawBitmap(fBitmapBtn,aRect,bRect,1,False);
          finally
          tmpBmp.Canvas.EndScene;
          end;
           //if text rotated, rotate image now..
           if fRotated then
             tmpBmp.Rotate(90);

          w:=tmpBmp.Width;
          h:=tmpBmp.Height;
          wts:=h/1.25;//wanted text size a 1.5 for buttons should give 1/4 space
          fs:=fFontSize*CurrentScale;
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
                tmpBmp.Canvas.Font.Size:=fs;//fTxtButton.Font.Size;
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
                tmpBmp.Canvas.Font.Size:=fs;//fTxtButton.Font.Size;
                tw:=tmpBmp.Canvas.TextWidth(fText);
                end;
            end;
           end else
              begin
                th:=tmpBmp.Canvas.TextHeight(fText);
              end;



           if (h>0) and (w>0) then //no tall skinnys
           begin
           aRect:=TRectF.Create(aGap,aGap,w-agap,h-agap);
            if tmpBmp.Canvas.BeginScene then
             try
             tmpBmp.Canvas.FillText(aRect, fText, false, 1,[], TTextAlign.Center, TTextAlign.Center);
             finally
             tmpBmp.Canvas.EndScene;
             end;

            if fRotated then
               tmpBmp.Rotate(-90);
            fBtnTexture.Texture.Assign(tmpBmp);
            MaterialSource:=fBtnTexture;


           end;
           tmpBmp.Free;
          end;
     end;









end;



{Dialog input button contains a rect and 3dtext and a small label in top left corner}
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
   fLblSize:=0;
   fFontSize:=12;
   fLabelAlign:=TAlignment.taLeftJustify;
   fTextVAlign:=TVerticalAlignment.taVerticalCenter;

fRecId:=0;
fValByte:=0;
fValInt:=0;
fValStr:='';

  //create rectangle first
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
          if tmpBmp.Canvas.BeginScene then
           try
            tmpBmp.Canvas.DrawBitmap(fBitmapBtn,aRect,bRect,1,False);
           finally
            tmpBmp.Canvas.EndScene;
           end;
          w:=tmpBmp.Width;
          h:=tmpBmp.Height;
          fs := fFontSize * CurrentScale; // start high
          wts:=h/1.5;//wanted text size a half for buttons
             if not fTxtFixed then
             begin
               if fText <> '' then
               begin
                 fs := fFontSize * CurrentScale; // start high
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
                     tmpBmp.Canvas.Font.Size := fs; // fTxtButton.Font.Size;
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
                     tmpBmp.Canvas.Font.Size := fs; // fTxtButton.Font.Size;
                     tw := tmpBmp.Canvas.TextWidth(fText);
                   end;
                 end;
               end;
             end else
                begin
                 if fText<>'' then
                  begin
                    //using fixed font size
                    fs:=fFontSize * CurrentScale;
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
                     fLblSize:=fFontSize/1.25;

                 if not fLblFixed then
                  begin
                  if fLabelAlign=TAlignment.taLeftJustify then
                  wts := h / 2.8 else
                  wts := h / 2.5;
                  ls := fLblSize * CurrentScale; // do it again..
                  // reduce height if needed
                  th := tmpBmp.Canvas.TextHeight(fLabelTxt);
                  if th > wts then
                  begin
                    while th > wts do
                    begin
                      ls := ls - 1;
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
                      ls := ls - 1;
                      tmpBmp.Canvas.Font.Size := ls;
                      tw := tmpBmp.Canvas.TextWidth(fLabelTxt);
                    end;
                  end;
                  end else
                     begin
                       ls:=fLblSize * CurrentScale;
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

           aRect:=TRectF.Create(aGap,Trunc((h/2)-(th))+(aGap*4),w-agap,Trunc((h/2)+(th))-aGap);
           if tmpBmp.Canvas.BeginScene then
             try
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
             finally
              tmpBmp.Canvas.EndScene;
             end;


             fBtnTexture.Texture.Assign(tmpBmp);
             MaterialSource:=fBtnTexture;
           end;
           tmpBmp.Free;
          end;
     end;







end;



{Dialog image button contains a rect and image and a small label in top left corner}
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
  //create rectangle first
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
aScaledH,aScaledW:single;
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
          if tmpBmp.Canvas.BeginScene then
           try
           tmpBmp.Canvas.DrawBitmap(fBitmapBtn,aRect,bRect,1,False);
           finally
            tmpBmp.Canvas.EndScene;
           end;

          w:=tmpBmp.Width;
          h:=tmpBmp.Height;
          wts:=h/3;//wanted text size a half for buttons

          if not fUseFixed then
           begin
          fs:=fFontSize * CurrentScale;
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
                tmpBmp.Canvas.Font.Size:=fs;//fTxtButton.Font.Size;
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
                tmpBmp.Canvas.Font.Size:=fs;//fTxtButton.Font.Size;
                tw:=tmpBmp.Canvas.TextWidth(fText);
                end;
            end;
           end else
              begin
              fs:=fFontSize * CurrentScale;
              tmpBmp.Canvas.Font.Size:=fs;
              tmpBmp.Canvas.Font.Style:=[TFontStyle.fsBold];
              tmpBmp.Canvas.Fill.Color:=fTxtColor;
              tmpBmp.Canvas.Stroke.Color:=fTxtColor;
                th:=tmpBmp.Canvas.TextHeight(fText);

              end;


           if (h>0) and (w>0) then //write some text
           begin
           aRect:=TRectF.Create(aGap,aGap,w-agap,th+aGap);

           if tmpBmp.Canvas.BeginScene then
            try
             tmpBmp.Canvas.FillText(aRect, fText, false, 1,
                 [], TTextAlign.Center, TTextAlign.Center);
            finally
             tmpBmp.Canvas.EndScene;

            end;

           fBtnTexture.Texture.Assign(tmpBmp);

           MaterialSource:=fBtnTexture;


           end;
           tmpBmp.Free;
          end;
     end;

end;








procedure TDlgImageButton.DoClick(sender: TObject);
begin
  if Assigned(fClickEvent) then
       fClickEvent(sender);
end;











{Dialog Text Contains a rect and some 3d text}
constructor TDlgText.Create(aOwner: TComponent; aWidth: single; aHeight: single; ax: single; ay: single);
begin
inherited Create(aOwner);
fCleanedUp:=false;
  //set w,h and pos
  Projection:=TProjection.Screen;

  fBitmapBtn:=tBitmap.Create;
  fBtnTexture:=TTextureMaterialSource.Create(self);
  fFontSize:=18;
  fTxtColor:=claBlack;

  Width:=aWidth;
  Height:=aHeight;
  Position.X:=aX;
  Position.Y:=aY;
  Depth:=1;
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
finally
fCleanedUp:=true;
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
          //draw also resizes
          if tmpBmp.Canvas.BeginScene then
           try
           tmpBmp.Canvas.DrawBitmap(fBitmapBtn,aRect,bRect,1,False);
           finally
           tmpBmp.Canvas.EndScene;
           end;

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
                tmpBmp.Canvas.Font.Size:=fs;//fTxtButton.Font.Size;
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
                tmpBmp.Canvas.Font.Size:=fs;//fTxtButton.Font.Size;
                tw:=tmpBmp.Canvas.TextWidth(fText);
                end;
            end;



           if (h>0) and (w>0) then //no tall skinnys
           begin
           aRect:=TRectF.Create(aGap,aGap,w-agap,h-agap);
           if tmpBmp.Canvas.BeginScene then
            try
            tmpBmp.Canvas.FillText(aRect, fText, false, 1,
                [], TTextAlign.Center, TTextAlign.Center);
            finally
            tmpBmp.Canvas.EndScene;
            end;


            fBtnTexture.Texture.Assign(tmpBmp);
            MaterialSource:=fBtnTexture;


           end;
           tmpBmp.Free;
          end;
     end;









end;



//TGridCell
Constructor TGridCell.Create(aowner: TComponent; aWidth: Single; aHeight: Single; ax: Single; ay: Single);
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
  fUpBitmap:=tBitmap.Create;
  fBtnTexture:=TTextureMaterialSource.Create(self);
  fUpBtnTexture:=TTextureMaterialSource.Create(self);
   fTxtFixed:=false;
   fLblFixed:=false;
   fLblColor:=claBlack;
   fTxtColor:=claBlack;
   fLblSize:=0;
   fFontSize:=12;
   fLabelAlign:=TAlignment.taLeftJustify;
   fTextVAlign:=TVerticalAlignment.taVerticalCenter;
   fUp:=false;

   fRecId:=0;
   fValByte:=0;
   fValInt:=0;
   fValStr:='';

  //create rectangle first
  Parent:=self;
  Sides:=[TExtrudedShapeSide.Front];
  HitTest:=true;

end;

destructor TGridCell.Destroy;
begin

if not fCleanedUp then CleanUp;

inherited;

end;

procedure TGridCell.CleanUp;
begin

if fCleanedUp then Exit;


try
if assigned(fBitmapBtn) then
   fBitmapBtn.Free;

if Assigned(fBtnTexture) then
    fBtnTexture.Free;

if Assigned(fUpBtnTexture) then
    fUpBtnTexture.Free;

if assigned(fUpBitmap) then
   fUpBitmap.Free;

fLabel:='';
fValStr:='';
fClickEvent:=nil;

Parent:=nil;
finally
fCleanedUp:=true;
end;
end;



procedure TGridCell.SetLabel(value: string);
begin
  if fLabel=value then exit;

  fLabel:=value;

end;


procedure TGridCell.DoClick(sender: TObject);
begin
  if Assigned(fClickEvent) then
       fClickEvent(self);
end;


procedure TGridCell.SetText(aString: string);
begin
  if aString=fText then exit;
     fText:=aString;
       DrawText;
end;

procedure TGridCell.SetText2(aString: string);
begin
  if aString=fText2 then exit;
     fText2:=aString;
       DrawText;
end;
procedure TGridCell.SetText4(aString: string);
begin
  if aString=fText4 then exit;
     fText4:=aString;
       DrawText;
end;


procedure TGridCell.SetLabelTxt(aString: string);
begin
  if aString=fLabelTxt then exit;
     fLabelTxt:=aString;
       DrawText;
end;

procedure TGridCell.SetUp(aValue: Boolean);
begin
  if fUp=aValue then exit;
  fUp:=aValue;
    if fUp then
      MaterialSource:=fUpBtnTexture else
       MaterialSource:=fBtnTexture;
end;

procedure TGridCell.SetBtnBitmap(aValue: TBitmap);
begin
  if assigned(aValue) then
   fBitmapBtn.Assign(aValue);
  fBtnTexture.Texture.Assign(fBitmapBtn);
end;
procedure TGridCell.SetUpBitmap(aValue: TBitmap);
begin
  if assigned(aValue) then
   fUpBitmap.Assign(aValue);
  fUpBtnTexture.Texture.Assign(fUpBitmap);
end;


procedure TGridCell.DrawText;
var
aGap:single;
aRect,bRect:TRectF;
tmpBmp,tmp2Bmp:tBitmap;
w,h,th,tw,wts,wls,fs,ls,lth:single;
aHowMany:byte;//how many lines..
aScaledW,aScaledH:single;

begin

    fs:=10;
    ls:=8;
    lth:=0;//label text height
    aHowMany:=0;
    aGap:=2;


       if (fText <> '') then
         Inc(aHowMany);
       if (fLabelTxt <> '') then
         Inc(aHowMany);
       if (fText2 <> '') then
         Inc(aHowMany);
       if (fText4 <> '') then
         Inc(aHowMany);

           //get our scale
           aScaledW:=Width*CurrentScale;
           aScaledH:=Height*CurrentScale;




   if Assigned(fBitmapBtn) then
     begin

         fUpBtnTexture.Texture.Assign(fUpBitmap);
         fBtnTexture.Texture.Assign(fBitmapBtn);

       if aHowMany=0 then
        begin
          if fUp then
             MaterialSource:=fUpBtnTexture else
            MaterialSource:=fBtnTexture;
        end
          else
          if aHowMany<3 then
          begin
          aRect:=TRectF.Create(0,0,fBitmapBtn.Width,fBitmapBtn.Height);
          bRect:=TRectF.Create(0,0,Trunc(aScaledW),Trunc(aScaledH));

          tmpBmp:=tBitmap.Create(Trunc(aScaledW),Trunc(aScaledH));
          tmpBmp.Clear(claNull);
          if tmpBmp.Canvas.BeginScene then
            try
            tmpBmp.Canvas.DrawBitmap(fBitmapBtn,aRect,bRect,1,False);
            finally
            tmpBmp.Canvas.EndScene;
            end;

          aRect:=TRectF.Create(0,0,fUpBitmap.Width,fUpBitmap.Height);
          tmp2Bmp:=tBitmap.Create(Trunc(aScaledW),Trunc(aScaledH));
          tmp2Bmp.Clear(claNull);
          if tmp2Bmp.Canvas.BeginScene then
            try
            tmp2Bmp.Canvas.DrawBitmap(fUpBitmap,aRect,bRect,1,False);
            finally
            tmp2Bmp.Canvas.EndScene;
            end;

          tmp2Bmp.Canvas.Font.Style := [TFontStyle.fsBold];
          tmp2Bmp.Canvas.Fill.Color := fTxtColor;
           //both bitmaps should now be the same
          w:=tmpBmp.Width;
          h:=tmpBmp.Height;
          fs := fFontSize * CurrentScale; //scale font size
          if fLabelTxt='' then
          wts:=h/1.2 else //half if no label
          wts:=h/1.5;// else a bit less
             if not fTxtFixed then
             begin
               if fText <> '' then
               begin
                 fs := fFontSize * CurrentScale; // scale
                 tmpBmp.Canvas.Font.Size := fs;
                 tmpBmp.Canvas.Font.Style := [TFontStyle.fsBold];
                 tmpBmp.Canvas.Fill.Color := fTxtColor;
                 // reduce height if needed
                 th := tmpBmp.Canvas.TextHeight(fText);
                 if th > wts then
                 begin
                   while th > wts do
                   begin
                     fs := fs - 1;
                     tmpBmp.Canvas.Font.Size := fs; // fTxtButton.Font.Size;
                     th := tmpBmp.Canvas.TextHeight(fText);
                   end;
                 end;

                 // reduce if width too big
                 tw := tmpBmp.Canvas.TextWidth(fText);
                 if tw > (w - (aGap * 2)) then
                 begin
                   while tw > (w - (aGap * 2)) do
                   begin
                     fs := fs - 1;
                     tmpBmp.Canvas.Font.Size := fs; // fTxtButton.Font.Size;
                     tw := tmpBmp.Canvas.TextWidth(fText);
                   end;
                 end;
               end;
             end else
                begin
                 if fText<>'' then
                  begin
                    //using fixed font size
                    fs:=fFontSize * CurrentScale; //scale
                   tmp2Bmp.Canvas.Font.Size := fs;
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
                     fLblSize:=(fFontSize/1.25) * CurrentScale;  //scale

                 if not fLblFixed then
                  begin
                  if fLabelAlign=TAlignment.taLeftJustify then
                  wts := h / 2.8 else
                  wts := h / 2.5;
                  ls := fLblSize * CurrentScale; // scale
                  // reduce height if needed
                  th := tmpBmp.Canvas.TextHeight(fLabelTxt);
                  if th > wts then
                  begin
                    while th > wts do
                    begin
                      ls := ls - 1;
                      tmpBmp.Canvas.Font.Size := ls;
                      th := tmpBmp.Canvas.TextHeight(fLabelTxt);
                    end;
                  end;

                  lth:=th;//save this

                  // reduce if width too big
                  tw := tmpBmp.Canvas.TextWidth(fLabelTxt);
                  if tw > (w - (aGap * 2)) then
                  begin
                    while tw > (w - (aGap * 2)) do
                    begin
                      ls := ls - 1;
                      tmpBmp.Canvas.Font.Size := ls;
                      tw := tmpBmp.Canvas.TextWidth(fLabelTxt);
                    end;
                  end;
                  end else
                     begin
                       ls:=fLblSize * CurrentScale;
                        //no zero's please..
                       if ls=0 then ls:=10;

                     end;
                end;


                tmp2Bmp.Canvas.Font.Size:=fs;
                tmpBmp.Canvas.Font.Size:=fs;
                tmpBmp.Canvas.Font.Style := [TFontStyle.fsBold];
                tmpBmp.Canvas.Fill.Color := fTxtColor;
                th:=tmpBmp.Canvas.TextHeight(fText);


           if (h>0) and (w>0) then //no tall skinnys
           begin

           //Main Text first
           aRect:=TRectF.Create(aGap,Trunc(lth)+(aGap),w-agap,Trunc(h)-aGap);
            if tmpBmp.Canvas.BeginScene then
             try
           if fText<>'' then
            begin
            if fTextVAlign=tVerticalAlignment.taAlignTop then
             begin
             tmpBmp.Canvas.FillText(aRect, fText, false, 1,[], TTextAlign.Center, TTextAlign.Leading);
             end else
            if fTextVAlign=tVerticalAlignment.taVerticalCenter then
             begin
             tmpBmp.Canvas.FillText(aRect, fText, false, 1,[], TTextAlign.Center, TTextAlign.Center);
             end else
            if fTextVAlign=tVerticalAlignment.taAlignBottom then
             begin
             tmpBmp.Canvas.FillText(aRect, fText, false, 1,[], TTextAlign.Center, TTextAlign.Trailing);
             end;
            end;

           //now the label at the top
           tmpBmp.Canvas.Font.Size:=ls;
           th:=tmpBmp.Canvas.TextHeight(fLabelTxt);
           aRect:=TRectF.Create(aGap,aGap,w-agap,th+aGap);
           tmpBmp.Canvas.Fill.Color := fLblColor;
           if fLabelTxt<>'' then
             begin
             if fLabelAlign=TAlignment.taLeftJustify then
              begin
              tmpBmp.Canvas.FillText(aRect, fLabelTxt, false, 1,[], TTextAlign.Leading, TTextAlign.Leading);
              end else
             if fLabelAlign=TAlignment.taCenter then
              begin
              tmpBmp.Canvas.FillText(aRect, fLabelTxt, false, 1,[], TTextAlign.Center, TTextAlign.Leading);
              end else
             if fLabelAlign=TAlignment.taRightJustify then
              begin
              tmpBmp.Canvas.FillText(aRect, fLabelTxt, false, 1,[], TTextAlign.Trailing, TTextAlign.Leading);
              end;

             end;
             finally
              tmpBmp.Canvas.EndScene;
             end;

             //now the next bitmap
                tmp2Bmp.Canvas.Font.Size:=fs;
                tmp2Bmp.Canvas.Fill.Color := fTxtColor;
                th:=tmp2Bmp.Canvas.TextHeight(fText);


           //Main Text first
           aRect:=TRectF.Create(aGap,Trunc(lth)+(aGap),w-agap,Trunc(h)-aGap);
           if tmp2Bmp.Canvas.BeginScene then
             try
           if fText<>'' then
            begin
            if fTextVAlign=tVerticalAlignment.taAlignTop then
             begin
             tmp2Bmp.Canvas.FillText(aRect, fText, false, 1,[], TTextAlign.Center, TTextAlign.Leading);
             end else
            if fTextVAlign=tVerticalAlignment.taVerticalCenter then
             begin
             tmp2Bmp.Canvas.FillText(aRect, fText, false, 1,[], TTextAlign.Center, TTextAlign.Center);
             end else
            if fTextVAlign=tVerticalAlignment.taAlignBottom then
             begin
             tmp2Bmp.Canvas.FillText(aRect, fText, false, 1,[], TTextAlign.Center, TTextAlign.Trailing);
             end;
            end;

           //now the label at the top
           tmp2Bmp.Canvas.Font.Size:=ls;
           th:=tmp2Bmp.Canvas.TextHeight(fLabelTxt);
           aRect:=TRectF.Create(aGap,aGap,w-agap,th+aGap);
           tmp2Bmp.Canvas.Fill.Color := fLblColor;
           if fLabelTxt<>'' then
             begin
             if fLabelAlign=TAlignment.taLeftJustify then
              begin
              tmp2Bmp.Canvas.FillText(aRect, fLabelTxt, false, 1,[], TTextAlign.Leading, TTextAlign.Leading);
              end else
             if fLabelAlign=TAlignment.taCenter then
              begin
              tmp2Bmp.Canvas.FillText(aRect, fLabelTxt, false, 1,[], TTextAlign.Center, TTextAlign.Leading);
              end else
             if fLabelAlign=TAlignment.taRightJustify then
              begin
              tmp2Bmp.Canvas.FillText(aRect, fLabelTxt, false, 1,[], TTextAlign.Trailing, TTextAlign.Leading);
              end;

             end;
             finally
             tmp2Bmp.Canvas.EndScene;
             end;


              fUpBtnTexture.Texture.Assign(tmp2Bmp);
             fBtnTexture.Texture.Assign(tmpBmp);
            if fUp then
             MaterialSource:=fUpBtnTexture else
             MaterialSource:=fBtnTexture;
           end;
           tmpBmp.Free;
           tmp2Bmp.Free;
          end else
               begin
                 // 3 or more..
                 aRect := TRectF.create(0, 0, fBitmapBtn.Width,fBitmapBtn.Height);
                 bRect := TRectF.create(0, 0, Trunc(aScaledW), Trunc(aScaledH));

                 tmpBmp := TBitmap.create(Trunc(aScaledW), Trunc(aScaledH));
                 tmpBmp.Clear(claNull);
                 if tmpBmp.Canvas.BeginScene then
                   try
                   tmpBmp.Canvas.DrawBitmap(fBitmapBtn, aRect, bRect, 1, False);
                   finally
                   tmpBmp.Canvas.EndScene;

                   end;

                 aRect := TRectF.create(0, 0, fUpBitmap.Width,fUpBitmap.Height);
                 tmp2Bmp := TBitmap.create(Trunc(aScaledW), Trunc(aScaledH));
                 tmp2Bmp.Clear(claNull);
                 if tmp2Bmp.Canvas.BeginScene then
                   try
                   tmp2Bmp.Canvas.DrawBitmap(fUpBitmap, aRect, bRect, 1, False);
                   finally
                   tmp2Bmp.Canvas.EndScene;
                   end;
                 fs := fFontSize * CurrentScale; // start high
                 tmp2Bmp.Canvas.Font.Size := fs;
                 tmp2Bmp.Canvas.Font.Style := [TFontStyle.fsBold];
                 tmp2Bmp.Canvas.Fill.Color := fTxtColor;
                 w := tmpBmp.Width;
                 h := tmpBmp.Height;
                 wts := h / 1.5;
                 th:=wts;
                 if not fTxtFixed then
                 begin
                   if fText <> '' then
                   begin
                     fs := fFontSize * CurrentScale; // start high
                     tmpBmp.Canvas.Font.Size := fs;
                     tmpBmp.Canvas.Font.Style := [TFontStyle.fsBold];
                     tmpBmp.Canvas.Fill.Color := fTxtColor;
                     // reduce height if needed
                     th := tmpBmp.Canvas.TextHeight(fText);
                     if th > wts then
                     begin
                       while th > wts do
                       begin
                         fs := fs - 1;
                         tmpBmp.Canvas.Font.Size := fs; // fTxtButton.Font.Size;
                         th := tmpBmp.Canvas.TextHeight(fText);
                       end;
                     end;

                     // reduce if width too big
                     tw := tmpBmp.Canvas.TextWidth(fText);
                     if tw > (w - (aGap * 2)) then
                     begin
                       while tw > (w - (aGap * 2)) do
                       begin
                         fs := fs - 1;
                         tmpBmp.Canvas.Font.Size := fs; // fTxtButton.Font.Size;
                         tw := tmpBmp.Canvas.TextWidth(fText);
                       end;
                     end;
                   end;
                 end
                 else
                 begin
                   if fText <> '' then
                   begin
                     // using fixed font size
                     fs := fFontSize * CurrentScale;
                     tmpBmp.Canvas.Font.Size := fs;
                     tmpBmp.Canvas.Font.Style := [TFontStyle.fsBold];
                     tmpBmp.Canvas.Fill.Color := fTxtColor;
                     // reduce height if needed
                     th := tmpBmp.Canvas.TextHeight(fText);
                   end;

                 end;

                 if aHowMany < 4 then
                 begin

                   // middle
                   aRect := TRectF.create(aGap, ((h / 2) - th), w - aGap,
                     Trunc((h / 2) + th));
                 if tmpBmp.Canvas.BeginScene then
                  try
                   if fText <> '' then
                    begin
                     tmpBmp.Canvas.FillText(aRect, fText, False, 1, [],
                       TTextAlign.Center, TTextAlign.Center);
                    end;

                   // bottom
                   if fText4 <> '' then
                   begin
                     th := tmpBmp.Canvas.TextHeight(fText4);
                     aRect := TRectF.create(aGap, (h - (th + aGap)), w - aGap,
                       h - aGap);
                     tmpBmp.Canvas.FillText(aRect, fText4, False, 1, [],
                       TTextAlign.Center, TTextAlign.Leading);
                   end;

                   // top
                   if fText2 <> '' then
                   begin
                     th := tmpBmp.Canvas.TextHeight(fText2);
                     aRect := TRectF.create(aGap, aGap, w - aGap, th + aGap);
                     tmpBmp.Canvas.FillText(aRect, fText2, False, 1, [],
                       TTextAlign.Center, TTextAlign.Leading);
                   end;

                  finally
                   tmpBmp.Canvas.EndScene;
                  end;


                   th := tmp2Bmp.Canvas.TextHeight(fText);

                   // middle
                   aRect := TRectF.create(aGap, ((h / 2) - th), w - aGap,
                     Trunc((h / 2) + th));
                 if tmp2Bmp.Canvas.BeginScene then
                  try
                   if fText <> '' then
                    begin
                     tmp2Bmp.Canvas.FillText(aRect, fText, False, 1, [],
                       TTextAlign.Center, TTextAlign.Center);
                    end;

                   // bottom
                   if fText4 <> '' then
                   begin
                     th := tmp2Bmp.Canvas.TextHeight(fText4);
                     aRect := TRectF.create(aGap, (h - (th + aGap)), w - aGap,
                       h - aGap);
                     tmp2Bmp.Canvas.FillText(aRect, fText4, False, 1, [],
                       TTextAlign.Center, TTextAlign.Leading);
                   end;

                   // top
                   if fText2 <> '' then
                   begin
                     th := tmp2Bmp.Canvas.TextHeight(fText2);
                     aRect := TRectF.create(aGap, aGap, w - aGap, th + aGap);
                     tmp2Bmp.Canvas.FillText(aRect, fText2, False, 1, [],
                       TTextAlign.Center, TTextAlign.Leading);
                   end;
                  finally
                   tmp2Bmp.Canvas.EndScene;
                  end;
                 end
                 else
                 begin
                   // all 4
                 if tmpBmp.Canvas.BeginScene then
                  try
                   //top
                   if fLabelTxt <> '' then
                   begin
                     aRect := TRectF.create(aGap, aGap, w - aGap, th);

                       tmpBmp.Canvas.FillText(aRect, fLabelTxt, False, 1, [],
                         TTextAlign.Center, TTextAlign.Center);
                   end;
                   //line 2
                   if fText2 <> '' then
                   begin
                     aRect := TRectF.create(aGap, aGap + th, w - aGap,
                       (th * 2) + aGap);
                     tmpBmp.Canvas.FillText(aRect, fText2, False, 1, [],
                       TTextAlign.Center, TTextAlign.Center);
                   end;

                   aRect := TRectF.create(aGap, aGap + (th * 2),
                     w - aGap, th * 3);
                   //line 3
                   if fText <> '' then
                     begin
                     tmpBmp.Canvas.FillText(aRect, fText, False, 1, [],
                       TTextAlign.Center, TTextAlign.Center);
                     end;

                   //line 4
                   if fText4 <> '' then
                   begin
                     aRect := TRectF.create(aGap, (th * 3) + aGap, w - aGap,
                       Trunc(h));
                     tmpBmp.Canvas.Font.Size := fs + 4;  //made it a snib bigger??
                     tmpBmp.Canvas.FillText(aRect, fText4, False, 1, [],
                       TTextAlign.Center, TTextAlign.Center);
                   end;

                  finally
                   tmpBmp.Canvas.EndScene;

                  end;


                 if  tmp2Bmp.Canvas.BeginScene then
                  try
                   //top
                   if fLabelTxt <> '' then
                   begin
                     aRect := TRectF.create(aGap, aGap, w - aGap, th);

                       tmp2Bmp.Canvas.FillText(aRect, fLabelTxt, False, 1, [],
                         TTextAlign.Center, TTextAlign.Center);
                   end;
                   //line 2
                   if fText2 <> '' then
                   begin
                     aRect := TRectF.create(aGap, aGap + th, w - aGap,
                       (th * 2) + aGap);
                     tmp2Bmp.Canvas.FillText(aRect, fText2, False, 1, [],
                       TTextAlign.Center, TTextAlign.Center);
                   end;

                   aRect := TRectF.create(aGap, aGap + (th * 2),
                     w - aGap, th * 3);
                   //line 3
                   if fText <> '' then
                     begin
                     tmp2Bmp.Canvas.FillText(aRect, fText, False, 1, [],
                       TTextAlign.Center, TTextAlign.Center);
                     end;

                   //line 4
                   if fText4 <> '' then
                   begin
                     aRect := TRectF.create(aGap, (th * 3) + aGap, w - aGap,
                       Trunc(h));
                     tmp2Bmp.Canvas.Font.Size := fs + 4;  //made it a snib bigger??
                     tmp2Bmp.Canvas.FillText(aRect, fText4, False, 1, [],
                       TTextAlign.Center, TTextAlign.Center);
                   end;
                  finally
                   tmp2Bmp.Canvas.EndScene;
                  end;

                 end;
                 // assign our results
                 fUpBtnTexture.Texture.Assign(tmp2Bmp);
                 fBtnTexture.Texture.Assign(tmpBmp);
               if fUp then
                  MaterialSource:=fUpBtnTexture else
                 MaterialSource := fBtnTexture;
                 tmpBmp.Free;
                 tmp2Bmp.Free;

             end;
     end;


end;







end.
