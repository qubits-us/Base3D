{
Unit Common 3d Dialogs -dialogs for Inertia
 Created 10.1.2021
 Developer:dm

 Be it harm none, do as ye wishes..

 }
unit uCommon3dDlgs;

interface


uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.UIConsts,
  FMX.Objects,FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, System.Math.Vectors, FMX.Ani, FMX.Controls3D,
  FMX.MaterialSources, FMX.Objects3D, FMX.Effects, FMX.Filter.Effects,FMX.Layers3D,
  uDlg3dCtrls,uDlg3dTextures;



type
TDlgConfirmation= class(TDummy)
  private
  fTxt:TDlgText;
  fButtons:Array of TDlgButton;
  fMat:TDlgMaterial;
  fim:TImage3D;
  fClickEvent:TDlgSelect_Event;
  fCleanedUp:boolean;
  protected
    function GetButton(aButtonNum:integer):TDlgButton;
    procedure SetButton(aButtonNum:integer;value:TDlgButton);
    procedure DoAClick(sender:tObject);
  public
    constructor Create(aOwner:TComponent;aMat:TDlgMaterial;
                    aWidth,aHeight,aX,aY:single); reintroduce;
    destructor Destroy;override;
    procedure CleanUp;
    property DlgText:TDlgText read fTxt write fTxt;
    property Buttons[index:integer]:TDlgButton read GetButton write SetButton;
    property OnButtonClick:TDlgSelect_Event read fClickEvent write fClickEvent;
    property BackIm:TImage3D read fim write fim;
end;


TDlgInformation= class(TDummy)
  private
  fTxt:TDlgText;
  fButton:TDlgButton;
  fMat:TDlgMaterial;
  fim:TImage3D;
  fClickEvent:TDlgClick_Event;
  fCleanedUp:Boolean;
  protected
  procedure DoClick(sender:TObject);
  public
    constructor Create(aOwner:TComponent;aMat:TDlgMaterial;
                    aWidth,aHeight,aX,aY:single); reintroduce;
    destructor Destroy;override;
    procedure  CleanUp;
    property DlgText:TDlgText read fTxt write fTxt;
    property Button:TDlgButton read fButton write fButton;
    property BackIm:TImage3D read fim write fim;
    property OnClick:TDlgClick_Event read fClickEvent write fClickEvent;
end;



implementation








constructor TDlgConfirmation.Create(aOwner: TComponent;aMat:TDlgMaterial;
           aWidth: Single;aHeight: Single; aX: Single; aY: Single);
var
i:integer;
newx,newy:single;
aButtonHeight,aButtonWidth:single;
aColGap,aRowGap,aNewGap:single;
SectionHeight:single;
ah,af,ap:single;
 tmpBitmap:tBitmap;
begin

  inherited Create(aOwner);
  //set our cam first always!!!
  Projection:=TProjection.Screen;
  fCleanedUp:=false;


  fMat:=aMat;

  //set w,h and pos
  Width:=Trunc(aWidth);
  Height:=Trunc(aHeight);
  Position.X:=Round(aX);
  Position.Y:=Round(aY);
  Depth:=1;
  Opacity:=0.95;

  tmpBitmap:=MakeDlgBackGrnd(Width+10,Height+20,0,0,10);

  fim:=TImage3d.Create(self);
  fIm.Projection:=TProjection.Screen;
  fIm.Width:=Width+10;
  fIm.Height:=Height+20;
  fIm.HitTest:=false;
  fIm.Position.X:=0;
  fIm.Position.Y:=0;
  fIm.Position.Z:=0;
  fIm.Opacity:=0.95;
 // fIm.WrapMode:=TImageWrapMode.Stretch;
  fIm.Bitmap.Assign(tmpBitmap);
  tmpBitmap.Free;
  fIm.Parent:=self;
  fIm.Visible:=true;



  aColGap:=2;
  aRowGap:=2;
  aButtonWidth:=Trunc((aWidth/4))-aColGap;



  ah:=Trunc(Height / 3);// devide height by number of rows..
  SectionHeight:=ah-aRowGap;


     newX:=0;//center
     NewY:=Round(((Height/2)*-1)+(SectionHeight))+aRowGap;



    fTxt:=TDlgText.Create(self,aWidth-20,(SectionHeight*2),newx,newy);
    fTxt.Projection:=TProjection.Screen;
    fTxt.Parent:=self;
    fTxt.MaterialSource:=fMat.LongRects;
    fTxt.TextColor:=fMat.Buttons.TextColor.Color;
    fTxt.FontSize:=fMat.FontSize;
      //back up the texture, we be frawing our own text for awhile.. :(
    fTxt.BtnBitMap.Assign(fMat.LongRects.Texture);
    fTxt.Text:='';








   newy:=newY+(SectionHeight*2)+(aRowGap);
   newy:=Round(newy-(SectionHeight/2)+aRowGap);
   newx:=Round((Width/2)-((aButtonWidth/2)+aButtonWidth+(aColGap*8)));

   SetLength(fButtons,2);

  for I := Low(fButtons) to High(fButtons) do
   begin
    fButtons[i]:=TDlgButton.Create(self,aButtonwidth,SectionHeight,newx,newy);
    fButtons[i].Projection:=TProjection.Screen;
    fButtons[i].Parent:=self;
    fButtons[i].Tag:=i;
    fButtons[i].MaterialSource:=fMat.Buttons.Rect;
    fButtons[i].TextColor:=fMat.Buttons.TextColor.Color;
    fButtons[i].FontSize:=fMat.FontSize+100;
    //back up the texture, we be frawing our own text for awhile.. :(
    fButtons[i].BtnBitMap.Assign(fMat.Buttons.Rect.Texture);
    if i=0 then
      begin
       fButtons[i].TextColor:=claGreen;
       fButtons[i].Text:='Yes';
      end;
    if i=1 then
      begin
       fButtons[i].TextColor:=claRed;
       fButtons[i].Text:='No';
      end;
    //link up click event
    fButtons[i].OnClick:=DoAClick;
    newx:=newx+aButtonWidth+(aColGap)+(aColGap);


    end;


end;


//clean up..
destructor TDlgConfirmation.Destroy;
var
i:integer;
begin
  try
    if not fCleanedUp then CleanUp;

  finally
   inherited;
  end;
end;

procedure TDlgConfirmation.CleanUp;
var
i:integer;
begin
  if fCleanedUp then Exit;

  try
     fTxt.CleanUp;
     fTxt.Free;
     fTxt:=nil;
   //all the buttons
     for I := Low(fButtons) to High(fButtons) do
       begin
        fButtons[i].CleanUp;
        fButtons[i].Free;
        fButtons[i]:=nil;
       end;

    SetLength(fButtons,0);
    fButtons:=nil;
    fIm.Parent:=nil;

    fIm.Free;
    fIm:=nil;
    fMat:=nil;
    Parent:=nil;
    fCleanedUp:=true;

  finally
   //fafa
  end;
end;


//get and sets for our  buttons
procedure TDlgConfirmation.SetButton(aButtonNum: Integer; value: TDlgButton);
begin
if aButtonNum<0 then exit;// nope

if aButtonNum>High(fButtons) then exit;//outa here
fButtons[aButtonNum]:=value;
end;

function TDlgConfirmation.GetButton(aButtonNum: Integer):TDlgButton;
begin
result:=nil;//nil the result
if aButtonNum<0 then exit;//nope
if aButtonNum>High(fButtons) then exit;//outa here
result:=fButtons[aButtonNum];
end;

procedure TDlgConfirmation.DoAClick(sender: TObject);
var
aBtnNum:integer;
begin
if not visible then exit;

   aBtnNum:=99;
  if sender is TRectangle3d then
    aBtnNum:=TRectangle3d(sender).Tag;

  if assigned(fClickEvent) then
      fClickEvent(sender,aBtnNum);

end;



{Information Dialog}

constructor TDlgInformation.Create(aOwner: TComponent;aMat:TDlgMaterial;
           aWidth: Single;aHeight: Single; aX: Single; aY: Single);
var
i:integer;
newx,newy:single;
aButtonHeight,aButtonWidth:single;
aColGap,aRowGap:single;
SectionHeight:single;
ah,af,ap:single;
tmpBitmap:tBitmap;

begin

  inherited Create(aOwner);
  //set our cam first always!!!
  Projection:=TProjection.Screen;
  fCleanedUp:=false;


  fMat:=aMat;

  //set w,h and pos
  Width:=Trunc(aWidth);
  Height:=Trunc(aHeight);
  Position.X:=Round(aX);
  Position.Y:=Round(aY);
  Depth:=1;
  Opacity:=0.95;

  tmpBitmap:=MakeDlgBackGrnd(Width+10,Height+20,0,0,10);

  fim:=TImage3d.Create(self);
  fIm.Projection:=TProjection.Screen;
  fIm.Width:=Width+10;
  fIm.Height:=Height+20;
  fIm.HitTest:=false;
  fIm.Position.X:=0;
  fIm.Position.Y:=0;
  fIm.WrapMode:=TImageWrapMode.Stretch;
  fIm.Bitmap.Assign(tmpBitmap);
  tmpBitmap.Free;
  fIm.Parent:=self;
  fIm.Visible:=true;



  aColGap:=10;
  aRowGap:=20;
  aButtonWidth:=Trunc(aWidth/4);


  fMat.FontSize:=22;

  ah:=Trunc(Height / 3);// devide height by number of rows..
  SectionHeight:=ah-aRowGap;



//change font size..
  if SectionHeight>70 then
    begin
     fMat.FontSize:=28;
    end else
    begin
      fMat.FontSize:=24;
    end;

  if SectionHeight>90 then
     begin
     fMat.FontSize:=34;
     end;

  if SectionHeight>150 then fMat.FontSize:=36;



     //newX:=(aWidth/2);//center
     //NewY:=(aHeight/3);//top
     newX:=0;//(aWidth/2);//center
     NewY:=Round(((Height/2)*-1)+SectionHeight+aRowGap);


    fTxt:=TDlgText.Create(self,aWidth-20,(SectionHeight*2),newx,newy);
    fTxt.Projection:=TProjection.Screen;
    fTxt.Parent:=self;
    fTxt.MaterialSource:=fMat.LongRects;
  //  fTxt.fRectTxt.MaterialShaftSource:=fMat.fmtButtons.fmtButtonImage;
   // fTxt.fRectTxt.MaterialSource:=fMat.fmtButtons.fmtButtonImage;
    fTxt.TextColor:=fMat.Buttons.TextColor.Color;
    fTxt.FontSize:=fMat.FontSize;
      //back up the texture, we be frawing our own text for awhile.. :(
    fTxt.BtnBitMap.Assign(fMat.LongRects.Texture);
    fTxt.Text:='';







    newy:=Round((Height/2)-((SectionHeight/2)+aRowGap));
    newx:=Round((Width/2)-((aButtonWidth/2)+aColGap));

    fButton:=TDlgButton.Create(self,aButtonwidth,SectionHeight,newx,newy);
    fButton.Projection:=TProjection.Screen;
    fButton.Parent:=self;
   // fButton.fRectButton.MaterialBackSource:=fMat.fmtButtons.fmtButtonImage;
  //  fButton.fRectButton.MaterialShaftSource:=fMat.fmtButtons.fmtButtonImage;
    fButton.MaterialSource:=fMat.Buttons.Rect;
    fButton.FontSize:=fMat.FontSize;
    fButton.BtnBitMap.Assign(fMat.Buttons.Rect.Texture);
    fButton.TextColor:=fMat.Buttons.TextColor.Color;
    fButton.Text:='Ok';
    //link up click event
    fButton.OnClick:=DoClick;



end;


//clean up..
destructor TDlgInformation.Destroy;
begin
try
  if not fCleanedUp then CleanUp;

  finally
   //fafa
   inherited;
  end;
end;

procedure TDlgInformation.CleanUp;
var
i:integer;
begin
  if fCleanedUp then Exit;

  try
     fTxt.CleanUp;
     fTxt.Free;
     fTxt:=nil;
     fButton.CleanUp;
     fButton.Free;
     fButton:=nil;
     fim.Parent:=nil;
  //   fIm.Bitmap:=nil;

     fIm.Free;
     fIm:=nil;
     fMat:=nil;
     Parent:=nil;

  finally
   fCleanedUp:=True;
  end;
end;


procedure TDlgInformation.DoClick(sender: TObject);
begin
  if assigned(fClickEvent) then
        fClickEvent(sender);
end;





end.
