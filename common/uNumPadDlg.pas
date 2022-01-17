{Number Pad Dialog for Inertia
 Created 10.1.21 -dm

 be it harm none, do as ye wishes..

 }
unit uNumPadDlg;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.UIConsts,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, System.Math.Vectors, FMX.Ani, FMX.Controls3D,
  FMX.MaterialSources, FMX.Objects3D, FMX.Effects, FMX.Filter.Effects,FMX.Layers3D,
  FMX.Objects,uDlg3dCtrls,uDlg3dTextures;



  type
      TDlgNumPad = class(TDummy)
        private
        fMat:TDlgMaterial;
        fIm:TImage3d;
        fNumGetBtn:TDlgInputButton;
        fClearBtn:tDlgButton;
        fKeys:array of TDlgButton;
        fNum:integer;
        fDoneEvent:TDlgSelect_Event;
        fCleanedUp:Boolean;

        protected
        procedure DoDone(aExitType:byte);
        procedure KeyClick(sender:tObject);
        procedure ClearClick(sender:tObject);
        procedure SetNum(aNum:integer);

        public
       constructor Create(aOwner:TComponent;aMat:TDlgMaterial;
                    aWidth,aHeight,aX,aY:single); reintroduce;
       destructor  Destroy;override;
       procedure  CleanUp;

       property OnDone:TDlgSelect_Event read fDoneEvent write fDoneEvent;
       property NumBtn:TDlgInputButton read fNumGetBtn write fNumGetBtn;
       property Number:integer read fnum write SetNum;
       property CleanedUp:Boolean read fCleanedUp;
       property BackIm:TImage3d read fim write fim;
      end;



implementation





constructor TDlgNumPad.Create(aOwner: TComponent; aMat: TDlgMaterial;
                     aWidth: Single; aHeight: Single; aX: Single; aY: Single);
var
i:integer;
newx,newy:single;
aButtonHeight,aButtonWidth,aParamWidth,aClearWidth:single;
aColGap,aRowGap:single;
SectionHeight:single;
ah,af,ap:single;
aFontSize:single;
tmpBitmap:TBitmap;
begin

inherited Create(aOwner);
//create things
  //set our cam first always!!!
  Projection:=TProjection.Screen;



  fMat:=aMat;
  aFontSize:=fMat.FontSize;

  //set w,h and pos
  Width:=Trunc(aWidth);
  Height:=Trunc(aHeight);
  Position.X:=aX;
  Position.Y:=aY;
  Depth:=1;

    tmpBitmap:=MakeDlgBackGrnd(Width+12,Height+12,0,0,10);


  fIm:=TImage3d.Create(self);
  fIm.Projection:=tProjection.Screen;
  fIm.Bitmap.Assign(tmpBitmap);
  tmpBitmap.Free;
  fIm.Width:=aWidth+12;
  fIm.Height:=aHeight+12;
  fIm.HitTest:=false;
  fIm.Position.X:=0;
  fIm.Position.Y:=0;
  fIm.Position.Z:=0;
  fIm.Parent:=self;

   Opacity:=0.95;//gets rid of black corners..



  aColGap:=2;
  aRowGap:=2;
  aButtonWidth:=aWidth-aColGap;//divide width by max keys in a row
  aParamWidth:=Trunc(aButtonWidth/2);

  aButtonWidth:=aWidth/3;
  aButtonWidth:=aButtonWidth*2;
  aClearWidth:=aButtonWidth/2;
  aButtonWidth:=Trunc(aButtonWidth-aColGap);
  aClearWidth:=Trunc(aClearWidth-aColGap);


  aFontSize:=32;

  ah:=Height / 5;// devide height by number of rows..
  SectionHeight:=ah;
  SectionHeight:=Trunc(SectionHeight-aRowGap);

if SectionHeight>(aButtonWidth+aColGap) then
   begin
     ah:=SectionHeight-(aButtonWidth+aColGap);
     SectionHeight:=Trunc(SectionHeight-(ah/2));
   end;


//change font size..
  if SectionHeight>70 then
    begin
     aFontSize:=32;
    end else
    begin
      aFontSize:=24;
    end;

  if SectionHeight>100 then
     begin
     aFontSize:=36;
     end;




  newy:=Round(((aHeight/2)*-1)+(SectionHeight/2));//top
  newx:=Round(((aWidth/2)*-1)+(aButtonWidth/2));//left

      fNumGetBtn:=tDlgInputButton.Create(self,aButtonwidth,SectionHeight,newx,newy);
      fNumGetBtn.Projection:=TProjection.Screen;
      fNumGetBtn.Parent:=self;
      fNUmGetBtn.Position.Z:=0;
      fNumGetBtn.Opacity:=0.95;
      fNumGetBtn.MaterialSource:=fMat.Large.Rect;
  //    fNumGetBtn.RectButton.MaterialBackSource:=fMat.tmButtons.mtButton;
  //    fNumGetBtn.RectButton.MaterialShaftSource:=fMat.tmButtons.mtButton;
    fNumGetBtn.BtnBitMap.Assign(fMat.Large.Rect.Texture);
    fNumGetBtn.TextColor:=fMat.Buttons.TextColor.Color;
    fNumGetBtn.LabelColor:=fMat.Buttons.TextColor.Color;
    fNumGetBtn.FontSize:=aFontSize;
    fNumGetBtn.LabelSize:=aFontSize / 1.25;
    fNumGetBtn.Text:='0';
    fNumGetBtn.LabelText:='Enter a new value..';
    fNumGetBtn.OnClick:=nil;


     newx:=Round(newx+(fNumGetBtn.Width/2)+aColGap+(aClearWidth/2));
      fClearBtn:=tDlgButton.Create(self,aClearwidth,SectionHeight,newx,newy);
      fClearBtn.Projection:=TProjection.Screen;
      fClearBtn.Parent:=self;
      fClearBtn.Position.Z:=0;
      fClearBtn.Opacity:=0.95;
      fClearBtn.MaterialSource:=fMat.Large.Button;
  //    fNumGetBtn.RectButton.MaterialBackSource:=fMat.tmButtons.mtButton;
  //    fNumGetBtn.RectButton.MaterialShaftSource:=fMat.tmButtons.mtButton;
      fClearBtn.BtnBitMap.Assign(fMat.Large.Button.Texture);
      fClearBtn.TextColor:=fMat.Buttons.TextColor.Color;
      fClearBtn.FontSize:=aFontSize;
      fClearBtn.Text:='Clear';
      fClearBtn.OnClick:=ClearClick;




      //new line
      newy:=newy+SectionHeight+aRowGap;

  aButtonWidth:=Trunc((aWidth/3)-aColGap);//divide width by max keys in a row


   newx:=Round(((aWidth/2)*-1)+(aButtonWidth/2));
   SetLength(fKeys,12);//12 buttons 4 rows

  // numpadStart:=0;
  for I := Low(fKeys) to High(fKeys) do
   begin
    fKeys[i]:=TDlgButton.Create(self,aButtonwidth,SectionHeight,newx,newy);
    //now set it up..
    fKeys[i].Projection:=TProjection.Screen;
    fKeys[i].Parent:=self;
    fKeys[i].Position.Z:=0;
    fKeys[i].Opacity:=0.95;
    if i<>9 then
    fkeys[i].Tag:=i+1 else
    fkeys[i].Tag:=0;
    fkeys[i].MaterialSource:=fMat.Large.Button;
 //   fkeys[i].RectButton.MaterialBackSource:=fMat.tmButtons.mtButton;
 //   fkeys[i].RectButton.MaterialShaftSource:=fMat.tmButtons.mtButton;
    fKeys[i].OnClick:=KeyClick;
    fKeys[i].TextColor:=fMat.Buttons.TextColor.Color;
    fKeys[i].FontSize:=aFontSize;
    //back up the texture, we be frawing our own text for awhile.. :(
    fKeys[i].BtnBitMap.Assign(fMat.Large.Button.Texture);
    if i=High(fKeys) then
    fkeys[i].Text:='Done' else
    if i=10 then
    fkeys[i].Text:='Cancel' else
    if i<>9 then
    fkeys[i].Text:=IntToStr(i+1) else fKeys[i].Text:='0';

    newx:=newx+aButtonWidth+aColGap;
    if i in [2,5,8,11] then
    begin
     newy:=newy+SectionHeight+aRowGap; //NL
     newx:=Round(((aWidth/2)*-1)+(aButtonWidth/2)); //CR
    end;


   end;






end;

destructor TDlgNumPad.Destroy;
begin

  if not fCleanedUp then CleanUp;

 inherited;
end;

procedure TDlgNumPad.CleanUp;
var
i:integer;
begin
  if fCleanedUp then exit;

  for I := Low(fKeys) to High(fKeys) do
    begin
      fKeys[i].CleanUp;
      fKeys[i].Free;
      fKeys[i]:=nil;
    end;

  SetLength(fKeys,0);
  fKeys:=nil;


  fNumGetBtn.CleanUp;
  fNumGetBtn.Free;
  fNumGetBtn:=nil;

  fClearBtn.CleanUp;
  fClearBtn.Free;
  fClearBtn:=nil;

  fIm.Parent:=nil;
  fIm.Free;

  fMat:=nil;
  Visible:=false;
  Parent:=nil;
  fCleanedUp:=true;
end;


procedure TDlgNumPad.ClearClick(sender: TObject);
begin
       fNum:=0;
       fNumGetBtn.Text:='0';


end;


procedure TDlgNumPad.KeyClick(sender: TObject);
var
aTag:integer;
aStr:String;
begin
aTag:=-1;
  //we got a click event..
  if sender is TRectangle3D then
     aTag:=TRectangle3D(sender).Tag;

     //do it
     if (aTag<10) and (aTag>-1) then
       begin
        if fNum=0 then
         aStr:=IntToStr(aTag) else
         aStr:=IntToStr(fNum)+IntToStr(aTag);
         fNum:=StrToInt(aStr);
         fNumGetBtn.Text:=aStr;
         exit;
       end;

   if aTag=11 then
     begin
       DoDone(1);
       exit;
       //fNum:=0;
       //fNumGetBtn.Text:='0';
     end;

   if aTag=12 then
     begin
       DoDone(0);
       exit;
     end;



end;

procedure TDlgNumPad.DoDone(aExitType:byte);
begin
  if Assigned(fDoneEvent) then
   if aExitType=0 then
       fDoneEvent(nil,0) else
          fDoneEvent(nil,1);

end;


procedure TDlgNumPad.SetNum(aNum: Integer);
begin
  if fNum<>aNum then
    begin
      fNum:=aNum;
      fNumGetBtn.Text:=IntToStr(fNum);
    end;
end;


end.
