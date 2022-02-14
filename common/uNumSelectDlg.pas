{Quick pic 1-12 Dialog created for Inertia
  10.1.21- dm

  be it harm none, do as ye wishes..

  }
unit uNumSelectDlg;

interface
 uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.UIConsts,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, System.Math.Vectors, FMX.Ani, FMX.Controls3D,
  FMX.MaterialSources, FMX.Objects3D, FMX.Effects, FMX.Filter.Effects,FMX.Layers3D,
  FMX.Objects,uDlg3dCtrls,uDlg3dTextures;



    type
      TDlgNumSel = class(TDummy)
        private
        fMat:TDlgMaterial;
        fIm:TImage3d;
        fKeys:array of TDlgButton;
        fNum:integer;
        fDoneEvent:TDlgClick_Event;
        fCleanedUp:boolean;

        protected
        procedure DoDone(sender:tObject);
        procedure KeyClick(sender:tObject);
        procedure SetNum(aNum:integer);

        public
       constructor Create(aOwner:TComponent;aMat:TDlgMaterial;
                    aWidth,aHeight,aX,aY:single); reintroduce;
       destructor  Destroy;override;
       procedure  CleanUp;

       property OnDone:TDlgClick_Event read fDoneEvent write fDoneEvent;
       property Num:integer read fnum write fnum;
       property BackIm:Timage3d read fim write fim;
      end;




implementation






constructor TDlgNumSel.Create(aOwner: TComponent; aMat: TDlgMaterial;
                     aWidth: Single; aHeight: Single; aX: Single; aY: Single);
var
i:integer;
newx,newy:single;
aButtonHeight,aButtonWidth,aParamWidth:single;
aColGap,aRowGap:single;
SectionHeight:single;
ah,af,ap:single;
aFontSize:integer;
tmpBitmap:TBitmap;
begin

inherited Create(aOwner);
fCleanedUp:=false;
//create things
  //set our cam first always!!!
  Projection:=TProjection.Screen;

 // fCurrentMenu:=0;//default to 1st menu

  fMat:=aMat;
  aFontSize:=fMat.FontSize;
   Opacity:=0.95;
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
  fIm.Width:=aWidth+12;
  fIm.Height:=aHeight+12;
  fIm.HitTest:=false;
  fIm.Position.X:=0;
  fIm.Position.Y:=0;
  fIm.Position.Z:=-2;
  fIm.Parent:=self;
 // fIm.Opacity:=0.85;
     tmpBitmap.Free;




  aColGap:=2;
  aRowGap:=2;
  aButtonWidth:=aWidth-aColGap;//divide width by max keys in a row
  aParamWidth:=Trunc(aButtonWidth/2);

  aFontSize:=32;

  ah:=Height / 4;// devide height by number of rows..
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
      aFontSize:=28;
    end;

  if SectionHeight>100 then
     begin
     aFontSize:=36;
     end;




  newy:=Round(((aHeight/2)*-1)+(SectionHeight/2));//top


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
    fkeys[i].Tag:=i+1;
    fKeys[i].Position.Z:=-2;
    fKeys[i].Opacity:=0.95;
    fkeys[i].MaterialSource:=fMat.Large.Button;
 //   fkeys[i].RectButton.MaterialBackSource:=fMat.tmButtons.mtButton;
  //  fkeys[i].RectButton.MaterialShaftSource:=fMat.tmButtons.mtButton;
    fKeys[i].OnClick:=KeyClick;//DoClick;
    fKeys[i].TextColor:=fMat.Buttons.TextColor.Color;
    fKeys[i].FontSize:=aFontSize;
    //back up the texture, we be frawing our own text for awhile.. :(
    fKeys[i].BtnBitMap.Assign(fMat.Large.Button.Texture);

    fkeys[i].Text:=IntToStr(fKeys[i].Tag);

    newx:=newx+aButtonWidth+aColGap;
    if i in [2,5,8,11] then
    begin
     newy:=newy+SectionHeight+aRowGap; //NL
     newx:=Round(((aWidth/2)*-1)+(aButtonWidth/2)); //CR
    end;


   end;






end;

destructor TDlgNumSel.Destroy;
begin
 if not fCleanedUp then CleanUp;

 inherited;
end;

procedure TDlgNumSel.CleanUp;
var
i:integer;
begin

 if fCleanedUp then Exit;

  for I := Low(fKeys) to High(fKeys) do
   begin
      fKeys[i].CleanUp;
      fKeys[i].Free;
      fKeys[i]:=nil;
   end;

   SetLength(fKeys,0);
   fKeys:=nil;

  fIm.Parent:=nil;

  fIm.Free;
  fIm:=nil;
  fMat:=nil;
  Parent:=Nil;
  fDoneEvent:=nil;
  fCleanedUp:=true;

end;



procedure TDlgNumSel.KeyClick(sender: TObject);
var
aTag:integer;
aStr:String;
begin
aTag:=-1;
  //we got a click event..
  if sender is TRectangle3D then
     aTag:=TRectangle3D(sender).Tag;

     //do it
      fNum:=aTag;
       DoDone(sender);
end;

procedure TDlgNumSel.DoDone(sender: TObject);
begin
  if Assigned(fDoneEvent) then
       fDoneEvent(sender);
end;


procedure TDlgNumSel.SetNum(aNum: Integer);
begin
  if fNum<>aNum then
    begin
      fNum:=aNum;
    end;
end;







end.
