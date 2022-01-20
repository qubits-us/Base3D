unit uComplexDlg;

interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.UIConsts,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, System.Math.Vectors, FMX.Ani, FMX.Controls3D,FMX.Layers3d,
  FMX.MaterialSources, FMX.Objects3D, FMX.Effects, FMX.Filter.Effects,FMX.Objects,
  uDlg3dCtrls,uNumPadDlg;


  const
    MAX_THINGS=100;//maximum things..

    //encapsulate the data in something.. :)
  type
    tSomeThing = packed record
         ThingName:string;
         NumThings:byte;
         D1Value:integer;
         D2Value:integer;
         B1:integer;
         P1:integer;
         B2:integer;
         B3:integer;
         B4:integer;
         FThingType:array[0..MAX_THINGS] of byte;
         FThingSub:array[0..MAX_THINGS] of byte;
     end;




  type
     tComplexDlg= class(TDummy)
       private
       //priv
       //dialog data
       fThing:tSomeThing;


       fThingName:String;
       fNumThings:byte;
       fThingType:integer;
       fSkipped:Boolean;
       fP1:integer;
       fB1:integer;
       fB2:integer;
       fB3:integer;
       fB4:integer;

       fBtnName:tDlgInputButton;
       fBtnMaxP:tDlgInputButton;
       fBtnMaxS:tDlgInputButton;
       fBtnB1:tDlgInputButton;
       fBtnP1:tDlgInputButton;
       fBtnB2:tDlgInputButton;
       fBtnB3:tDlgInputButton;
       fBtnB4:tDlgInputButton;



       fBtnGF:tDlgInputButton;
       fBtnHeader:array of tDlgButton;
       fBtnNext:tDlgButton;
       fBtnPrev:tDlgButton;
       fBtnType: array of tDlgInputButton;
       fBtnMap: array of tDlgInputButton;
       fBtnCancel:tDlgButton;
       fBtnDone:tDlgButton;
       fIm:TImage3d;
       fMat:TDlgMaterial;
       fDoneEvent:TDlgDoneClick_Event;
       fCancelEvent:tDlgCancelClick_Event;
       fNumPad:TDlgNumPad;
       fStartNum:byte;
       fDlgUp:boolean;
       fCleanedUp:boolean;




       protected
       //prots
       procedure DoB1Click(sender:tObject);
       procedure OnB1Done(sender:tObject;aExitType:integer);
       procedure DoP1Click(sender:tObject);
       procedure OnP1Done(sender:tObject;aExitType:integer);
       procedure DoB2Click(sender:tObject);
       procedure OnB2Done(sender:tObject;aExitType:integer);
       procedure DoB3Click(sender:tObject);
       procedure OnB3Done(sender:tObject;aExitType:integer);
       procedure DoB4Click(sender:tObject);
       procedure OnB4Done(sender:tObject;aExitType:integer);
       procedure DoDoneClick(sender:tObject);
       procedure DoCancelClick(sender:tObject);
       procedure DoNextClick(sender:tObject);
       procedure DoPrevClick(sender:tObject);
       procedure TogGF(sender:tObject);
       procedure DoTypeClick(sender:tObject);
       procedure DoMapClick(sender:tObject);
       procedure DoNameClick(sender:tObject);
       procedure Refresh;
       procedure SetThing(value:TSomeThing);

       public
       //pubs
       constructor Create(aOwner:TComponent;aMat:TDlgMaterial;aWidth,aHeight,aX,aY:single); reintroduce;
       destructor  Destroy;override;
       procedure   CleanUp;

       property BackIm:TImage3d read fim write fim;
       property OnDone:TDlgDoneClick_Event read fDoneEvent write fDoneEvent;
       property OnCancel:TDlgCancelClick_Event read fCancelEvent write fCancelEvent;
       property NumThings:byte read fNumThings write fNumThings;
       property CleanedUp:boolean read fCleanedUp;
       property Thing:TSomeThing read fThing write fThing;
     end;






implementation








Constructor tComplexDlg.Create(aOwner: TComponent; aMat: TDlgMaterial;
                aWidth: Single; aHeight: Single; aX: Single; aY: Single);
var
i,j,k:integer;
newx,newy:single;
aButtonHeight,aButtonWidth,aParamWidth:single;
aColGap,aRowGap:single;
SectionHeight:single;
ah,af,ap:single;
begin
inherited Create(aOwner);
//create things
  //set our cam first always!!!
  Projection:=TProjection.Screen;

 fCleanedUp:=false;

 Opacity:=0.85;

  fMat:=aMat;
  fDlgUp:=false;

  fNumPad:=nil;
  fP1:=0;
  fB1:=0;
  fB2:=0;
  fB3:=0;

  fStartNum:=0;
  fThingType:=0;
  fNumThings:=100;//should be multiple of 10 else change grid scrolling..

  //set w,h and pos
  Width:=(aWidth);
  Height:=(aHeight);
  Position.X:=aX;
  Position.Y:=aY;
  Depth:=1;

  fIm:=TImage3d.Create(self);
  fIm.Projection:=tProjection.Screen;
  fIm.WrapMode:=TImageWrapMode.Stretch;
  fIm.TwoSide:=false;
  fIm.Width:=aWidth;
  fIm.Height:=aHeight;
  fIm.HitTest:=false;
  fIm.Position.X:=0;
  fIm.Position.Y:=0;
  fIm.Position.Z:=0;
  fIm.Parent:=self;
  fIm.Opacity:=0.85;
  fIm.Bitmap.Assign(fMat.BackImage);




  if Width>600 then
  SectionHeight:=80 else
  SectionHeight:=50;

  aColGap:=2;
  aRowGap:=2;
  aButtonWidth:=(aWidth/3);//divide width by max keys in a row
  aButtonWidth:=aButtonWidth-aColGap;
  aParamWidth:=Trunc(Width/11);
  aParamWidth:=aParamWidth-aColGap;

  fMat.FontSize:=32;

  ah:=(Height / 6);// divide height by number of rows..
  SectionHeight:=ah;
  SectionHeight:=SectionHeight-aRowGap;

if SectionHeight>(aButtonWidth+aColGap) then
   begin
     ah:=SectionHeight-(aButtonWidth+aColGap);
     SectionHeight:=(SectionHeight-(ah/2));
   end;


//change font size..
  if SectionHeight>79 then
    begin
     fMat.FontSize:=24;
    end else
    begin
      fMat.FontSize:=18;
    end;

  if SectionHeight>100 then
     begin
     fMat.FontSize:=28;
     end;



  newy:=(((aHeight/2)*-1)+(SectionHeight/2))+aRowGap;//top
  newx:=(((aWidth/2)*-1)+(aButtonWidth/2))+aColGap;//left

      fBtnName:=tDlgInputButton.Create(self,aButtonwidth,SectionHeight,newx,newy);
      fBtnName.Projection:=TProjection.Screen;
      fBtnName.Parent:=self;
      fBtnName.Opacity:=0.95;
      fBtnName.MaterialSource:=fMat.Large.Rect;
    fBtnName.TextColor:=fMat.Buttons.TextColor.Color;
    fBtnName.LabelColor:=fMat.Buttons.TextColor.Color;
    fBtnName.FontSize:=fMat.FontSize;
    fBtnName.BtnBitMap.Assign(fMat.Large.Rect.Texture);

      fBtnName.OnClick:=DoNameClick;
      fBtnName.Text:='Super Duper';
      fThing.ThingName:='Super Duper';

      fBtnName.LabelText:='Thing Name..';

      newx:=(newx+(aButtonWidth/2)+(aButtonWidth/4))+aColGap;

      fBtnGF:=tDlgInputButton.Create(self,(aButtonwidth/2),SectionHeight,newx,newy);
      fBtnGF.Projection:=TProjection.Screen;
      fBtnGF.Parent:=self;
      fBtnGF.MaterialSource:=fMat.Buttons.Rect;

    fBtnGF.TextColor:=fMat.Buttons.TextColor.Color;
    fBtnGF.LabelColor:=fMat.Buttons.TextColor.Color;
    fBtnGF.FontSize:=fMat.FontSize;
    fBtnGF.BtnBitMap.Assign(fMat.Buttons.Rect.Texture);
    fBtnGF.Text:='100';
    fThing.NumThings:=100;
    fBtnGF.LabelText:='# of Things';


      fBtnGF.OnClick:=TogGF;



     newx:=(((aWidth/2))-(aButtonWidth/4))-aColGap;//left

      fBtnMaxS:=tDlgInputButton.Create(self,(aButtonwidth/2),SectionHeight,newx,newy);
      fBtnMaxS.Projection:=TProjection.Screen;
      fBtnMaxS.Parent:=self;
      fBtnMaxS.MaterialSource:=fMat.Buttons.Rect;
      fBtnMaxS.TextColor:=fMat.Buttons.TextColor.Color;
      fBtnMaxS.LabelColor:=fMat.Buttons.TextColor.Color;
      fBtnMaxS.FontSize:=fMat.FontSize;
      fBtnMaxS.BtnBitMap.Assign(fMat.Buttons.Rect.Texture);
      fBtnMaxS.Text:='12';
      fThing.D1Value:=12;
      fBtnMaxS.LabelText:='Displayed Value';
      fBtnMaxS.OnClick:=nil;

      newx:=(newx-(aButtonWidth/2))-aColGap;
      fBtnMaxP:=tDlgInputButton.Create(self,(aButtonwidth/2),SectionHeight,newx,newy);
      fBtnMaxP.Projection:=TProjection.Screen;
      fBtnMaxP.Parent:=self;
      fBtnMaxP.MaterialSource:=fMat.Buttons.Rect;
    fBtnMaxP.TextColor:=fMat.Buttons.TextColor.Color;
    fBtnMaxP.LabelColor:=fMat.Buttons.TextColor.Color;
    fBtnMaxP.FontSize:=fMat.FontSize;
    fBtnMaxP.BtnBitMap.Assign(fMat.Buttons.Rect.Texture);
    fBtnMaxP.Text:='100';
    fThing.D2Value:=100;
    fBtnMaxP.LabelText:='Displayed Value';

      fBtnMaxP.OnClick:=nil;



      //new line
      newy:=newy+SectionHeight+aRowGap;
      newx:=((aWidth/2)*-1)+(aButtonWidth/2)+aColGap;//left
      newx:=(newx-(aButtonWidth/4));



      fBtnB1:=tDlgInputButton.Create(self,(aButtonwidth/2),SectionHeight,newx,newy);
      fBtnB1.Projection:=TProjection.Screen;
      fBtnB1.Parent:=self;
      fBtnB1.MaterialSource:=fMat.Buttons.Rect;
      fBtnB1.TextColor:=fMat.Buttons.TextColor.Color;
      fBtnB1.LabelColor:=fMat.Buttons.TextColor.Color;
      fBtnB1.FontSize:=fMat.FontSize;
      fBtnB1.BtnBitMap.Assign(fMat.Buttons.Rect.Texture);
      fBtnB1.Text:='0';
      fThing.B1:=0;
      fBtnB1.LabelText:='B1';
      fBtnB1.OnClick:=DoB1Click;

      newx:=(newx+(aButtonWidth/2))+aColGap;


      fBtnP1:=tDlgInputButton.Create(self,(aButtonwidth/2),SectionHeight,newx,newy);
      fBtnP1.Projection:=TProjection.Screen;
      fBtnP1.Parent:=self;
      fBtnP1.MaterialSource:=fMat.Buttons.Rect;
    fBtnP1.TextColor:=fMat.Buttons.TextColor.Color;
    fBtnP1.LabelColor:=fMat.Buttons.TextColor.Color;
    fBtnP1.FontSize:=fMat.FontSize;
    fBtnP1.BtnBitMap.Assign(fMat.Buttons.Rect.Texture);
    fBtnP1.Text:='0';
    fThing.P1:=0;
    fBtnP1.LabelText:='P1';
      fBtnP1.OnClick:=DoP1Click;

      newx:=(newx+(aButtonWidth/2))+aColGap;
      fBtnB2:=tDlgInputButton.Create(self,(aButtonwidth/2),SectionHeight,newx,newy);
      fBtnB2.Projection:=TProjection.Screen;
      fBtnB2.Parent:=self;
      fBtnB2.MaterialSource:=fMat.Buttons.Rect;
    fBtnB2.TextColor:=fMat.Buttons.TextColor.Color;
    fBtnB2.LabelColor:=fMat.Buttons.TextColor.Color;
    fBtnB2.FontSize:=fMat.FontSize;
    fBtnB2.BtnBitMap.Assign(fMat.Buttons.Rect.Texture);
    fBtnB2.Text:='0';
    fThing.B2:=0;
    fBtnB2.LabelText:='B2';

      fBtnB2.OnClick:=DoB2Click;

      newx:=(newx+(aButtonWidth/2))+aColGap;
      fBtnB3:=tDlgInputButton.Create(self,(aButtonwidth/2),SectionHeight,newx,newy);
      fBtnB3.Projection:=TProjection.Screen;
      fBtnB3.Parent:=self;
      fBtnB3.MaterialSource:=fMat.Buttons.Rect;
    fBtnB3.TextColor:=fMat.Buttons.TextColor.Color;
    fBtnB3.LabelColor:=fMat.Buttons.TextColor.Color;
    fBtnB3.FontSize:=fMat.FontSize;
    fBtnB3.BtnBitMap.Assign(fMat.Buttons.Rect.Texture);
    fBtnB3.Text:='0';
    fThing.B3:=0;
    fBtnB3.LabelText:='B3';
      fBtnB3.OnClick:=DoB3Click;

      newx:=(newx+(aButtonWidth/2))+aColGap;
      fBtnB4:=tDlgInputButton.Create(self,(aButtonwidth/2),SectionHeight,newx,newy);
      fBtnB4.Projection:=TProjection.Screen;
      fBtnB4.Parent:=self;
      fBtnB4.MaterialSource:=fMat.Buttons.Rect;
    fBtnB4.TextColor:=fMat.Buttons.TextColor.Color;
    fBtnB4.LabelColor:=fMat.Buttons.TextColor.Color;
    fBtnB4.FontSize:=fMat.FontSize;
    fBtnB4.BtnBitMap.Assign(fMat.Buttons.Rect.Texture);
    fBtnB4.Text:='0';
    fThing.B4:=0;
    fBtnB4.LabelText:='B4';
      fBtnB4.OnClick:=DoB4Click;

       newx:=0;
      //add this to space it up
      newy:=newy+(SectionHeight/4);


       newy:=newy+(SectionHeight/2)+aRowGap;
       newx:=(((aWidth/2)*-1)+(aParamWidth/4))+aColGap;//left
       newy:=(newy+(((SectionHeight*2.5)+(aRowGap*2))/2));

     fBtnPrev:=TDlgButton.Create(self,(aParamWidth/2),Trunc((SectionHeight*2.5)+(aRowGap*2)),newx,newy);
     fBtnPrev.Projection:=tProjection.Screen;
     fBtnPrev.Parent:=self;
     fBtnPrev.MaterialSource:=fMat.Small.VRect;
    fBtnPrev.TextColor:=fMat.Buttons.TextColor.Color;
    //fBtnPrev.LabelColor:=fMat.Buttons.TextColor.Color;
    fBtnPrev.FontSize:=fMat.FontSize;
    fBtnPrev.BtnBitMap.Assign(fMat.Small.VRect.Texture);
    fBtnPrev.Text:='<';
     fBtnPrev.OnClick:=DoPrevClick;

     newx:=(((aWidth/2))-(aParamWidth/4))-aColGap;//left

     fBtnNext:=TDlgButton.Create(self,(aParamWidth/2),Trunc((SectionHeight*2.5)+(aRowGap*2)),newx,newy);
     fBtnNext.Projection:=tProjection.Screen;
     fBtnNext.Parent:=self;
     fBtnNext.MaterialSource:=fMat.Small.VRect;
    fBtnNext.TextColor:=fMat.Buttons.TextColor.Color;
    fBtnNext.FontSize:=fMat.FontSize;
    fBtnNext.BtnBitMap.Assign(fMat.Small.VRect.Texture);
    fBtnNext.Text:='>';
     fBtnNext.OnClick:=DoNextClick;


       newy:=newy-(((SectionHeight*2.5)+(aRowGap*2))/2);

     //init thing arrays, some random pattern
     j:=1;
     k:=0;
     for I := 0 to MAX_THINGS do
       begin
         fThing.FThingType[i]:=j;
         fThing.FThingSub[i]:=k;
         if j<3 then Inc(j) else j:=1;
         if k<16 then Inc(k) else k:=0;
       end;




    SetLength(fBtnHeader,10);
   newx:=(((aWidth/2)*-1)+(aParamWidth/2)+(aParamWidth/2))+aColGap;//left
   newy:=(newy+SectionHeight/4);

        for I := Low(fBtnHeader) to High(fBtnHeader) do
   begin
    fBtnHeader[i]:=TDlgButton.Create(self,aParamwidth,Trunc(SectionHeight/2),newx,newy);
    fBtnHeader[i].Projection:=TProjection.Screen;
    fBtnHeader[i].Parent:=self;
    fBtnHeader[i].Tag:=i;
    fBtnHeader[i].MaterialSource:=fMat.Small.Rect;
    fBtnHeader[i].TextColor:=fMat.Buttons.TextColor.Color;
    fBtnHeader[i].FontSize:=fMat.FontSize;
    fBtnHeader[i].TextFixed:=true;
    fBtnHeader[i].BtnBitMap.Assign(fMat.Small.Rect.Texture);
    fBtnHeader[i].Text:=IntToStr(i+1);
    fBtnHeader[i].OnClick:=nil;

    newx:=newx+aParamWidth+aColGap;
    end;


     newy:=newy-SectionHeight/4;

      newy:=(newy+(SectionHeight))+aRowGap;

   //now the param buttons
      SetLength(fBtnType,10);
   newx:=(((aWidth/2)*-1)+(aParamWidth/2)+(aParamWidth/2))+aColGap;//left


        for I := Low(fBtnType) to High(fBtnType) do
   begin
    fBtnType[i]:=TDlgInputButton.Create(self,aParamwidth,SectionHeight,newx,newy);
    fBtnType[i].Projection:=TProjection.Screen;
    fBtnType[i].Parent:=self;
    fBtnType[i].Tag:=i;
    fBtnType[i].MaterialSource:=fMat.Small.Button;
    fBtnType[i].TextColor:=fMat.Buttons.TextColor.Color;
    fBtnType[i].LabelColor:=fMat.Buttons.TextColor.Color;
    fBtnType[i].FontSize:=fMat.FontSize;
    fBtnType[i].LabelSize:=fMat.FontSize/1.5;
    fBtnType[i].LabelFixed:=true;
    fBtnType[i].BtnBitMap.Assign(fMat.Small.Button.Texture);
    fBtnType[i].Text:=IntToStr(fThing.FThingType[i]);
    fBtnType[i].LabelText:='Number';

    fBtnType[i].OnClick:=DoTypeClick;
    fBtnType[i].RecordID:=i;
    fBtnType[i].ByteValue:=fThing.FThingType[i];
    newx:=newx+aParamWidth+aColGap;
    end;



      SetLength(fBtnMap,10);
   newx:=(((aWidth/2)*-1)+(aParamWidth/2)+(aParamWidth/2))+aColGap;//left
      newy:=newy+SectionHeight+aRowGap;// NL


        for I := Low(fBtnType) to High(fBtnType) do
   begin
    fBtnMap[i]:=TDlgInputButton.Create(self,aParamwidth,SectionHeight,newx,newy);
    fBtnMap[i].Projection:=TProjection.Screen;
    fBtnMap[i].Parent:=self;
    fBtnMap[i].Tag:=i;
    fBtnMap[i].MaterialSource:=fMat.Small.Button;
    fBtnMap[i].TextColor:=fMat.Buttons.TextColor.Color;
    fBtnMap[i].LabelColor:=fMat.Buttons.TextColor.Color;
    fBtnMap[i].FontSize:=fMat.FontSize;
    fBtnMap[i].LabelSize:=fMat.FontSize/1.5;
    fBtnMap[i].LabelFixed:=true;
    fBtnMap[i].BtnBitMap.Assign(fMat.Small.Button.Texture);
    fBtnMap[i].OnClick:=DoMapClick;
    fBtnMap[i].RecordID:=i;
    fBtnMap[i].LabelText:='Type';
          case fThing.FThingSub[i] of
          0:fBtnMap[i].Text:='A';
          1:fBtnMap[i].Text:='B';
          2:fBtnMap[i].Text:='C';
          3:fBtnMap[i].Text:='D';
          4:fBtnMap[i].Text:='E';
          5:fBtnMap[i].Text:='F';
          6:fBtnMap[i].Text:='G';
          7:fBtnMap[i].Text:='H';
          8:fBtnMap[i].Text:='I';
          9:fBtnMap[i].Text:='J';
          10:fBtnMap[i].Text:='K';
          11:fBtnMap[i].Text:='L';
          end;



    newx:=newx+aParamWidth+aColGap;
    end;









      newy:=newy+(SectionHeight/4);
      newy:=(newy+SectionHeight+aRowGap);// NL
      newx:=(((aWidth/2)*-1)+(aButtonWidth/2))+aColGap; //CR

     fBtnCancel:=TDlgButton.Create(self,aButtonWidth,SectionHeight,newx,newy);
     fBtnCancel.Projection:=tProjection.Screen;
     fBtnCancel.Parent:=self;
     fBtnCancel.MaterialSource:=fMat.Large.Rect;
     fBtnCancel.TextColor:=fMat.Buttons.TextColor.Color;
     fBtnCancel.FontSize:=fMat.FontSize;
     fBtnCancel.BtnBitMap.Assign(fMat.Large.Rect.Texture);
     fBtnCancel.Text:='Cancel';


     fBtnCancel.OnClick:=DoCancelClick;//
     //empty space
     Newx:=Newx+(aButtonWidth)+(aColGap);
     fBtnDone:=TDlgButton.Create(self,aButtonWidth,SectionHeight,newx,newy);
     fBtnDone.Projection:=tProjection.Screen;
     fBtnDone.Parent:=self;
     fBtnDone.MaterialSource:=fMat.Large.Rect;
     fBtnDone.TextColor:=fMat.Buttons.TextColor.Color;
     fBtnDone.FontSize:=fMat.FontSize;
     fBtnDone.BtnBitMap.Assign(fMat.Large.Rect.Texture);
     fBtnDone.Text:='Done';
     fBtnDone.Opacity:=0.95;

     fBtnDone.OnClick:=DoDoneClick;//





end;

Destructor tComplexDlg.Destroy;
begin

 if not fCleanedUp then CleanUp;



inherited;
end;

procedure tComplexDlg.CleanUp;
var
i:integer;
temp:TComponent;
begin
//clean house

if fCleanedUp then exit;


if assigned(fNumPad) then
begin
 fNumPad.CleanUp;
 fNumPad.Free;
 fNumPad:=nil;
end;

fBtnB1.CleanUp;
fBtnB1.Free;
fBtnB1:=nil;
fBtnP1.CleanUp;
fBtnP1.Free;
fBtnP1:=nil;
fBtnB2.CleanUp;
fBtnB2.Free;
fBtnB2:=nil;
fBtnB3.CleanUp;
fBtnB3.Free;
fBtnB3:=nil;
fBtnB4.CleanUp;
fBtnB4.Free;
fBtnB4:=nil;
fBtnDone.CleanUp;
fBtnDone.Free;
fBtnDone:=nil;
fBtnMaxS.CleanUp;
fBtnMaxS.Free;
fBtnMaxS:=nil;
fBtnMaxP.CleanUp;
fBtnMaxP.Free;
fBtnMaxP:=nil;
fBtnGF.CleanUp;
fBtnGF.Free;
fBtnGF:=nil;

fBtnCancel.CleanUp;
fBtnCancel.Free;
fBtnCancel:=nil;

fBtnNext.CleanUp;
fBtnNext.Free;
fBtnNext:=nil;
fBtnPrev.CleanUp;
fBtnPrev.Free;
fBtnPrev:=nil;
fBtnName.CleanUp;
fBtnName.Free;
fBtnName:=nil;

for I := Low(fBtnType) to High(fBtnType) do
 begin
    fBtnType[i].CleanUp;
    fBtnType[i].Free;
    fBtnType[i]:=nil;
 end;

for I := Low(fBtnMap) to High(fBtnMap) do
begin
    fBtnMap[i].CleanUp;
    fBtnMap[i].Free;
    fBtnMap[i]:=nil;
end;

for I := Low(fBtnHeader) to High(fBtnHeader) do
begin
    fBtnHeader[i].CleanUp;
    fBtnHeader[i].Free;
    fBtnHeader[i]:=nil;
end;

SetLength(fBtnType,0);
SetLength(fBtnMap,0);
SetLength(fBtnHeader,0);
  fBtnType:=nil;
  fBtnMap:=nil;
  fBtnHeader:=nil;


fIm.Free;
fIm:=nil;


fThingName:='';
fDoneEvent:=nil;
fCancelEvent:=nil;

fMat:=nil;
Parent:=nil;

fCleanedUp:=true;



end;



procedure tComplexDlg.DoDoneClick(sender: TObject);
begin
if fDlgUp then exit;

  if assigned(fDoneEvent) then
      fDoneEvent(self);
end;

procedure tComplexDlg.DoCancelClick(sender: TObject);
begin
if fDlgUp then exit;
  if assigned(fCancelEvent) then
      fCancelEvent(self);
end;


procedure tComplexDlg.DoNextClick(sender: TObject);
var
i:integer;
begin
if fDlgUp then exit;
//next
if fNumThings>10 then
   begin
     if fStartNum<(fNumThings-10) then
       begin
         fStartNum:=fStartNum+10;
         //relabel header..
          for I := Low(fBtnHeader) to High(fBtnHeader) do
              begin
                fBtnHeader[i].Tag:=fStartNum+i;
                fBtnHeader[i].Text:=IntToStr((fStartNum+1)+i);
                fBtnType[i].RecordID:=fStartNum+i;
                fBTnType[i].ByteValue:=fThing.fThingType[fStartNum+i];
                fBtnType[i].Text:=IntToStr(fThing.FThingType[fStartNum+i]);
                fBtnMap[i].RecordID:=fStartNum+i;
                fBtnMap[i].ByteValue:=fThing.FThingSub[fStartNum+i];
                 case fThing.fThingSub[fStartNum+i] of
                 0:fBtnMap[i].Text:='A';
                 1:fBtnMap[i].Text:='B';
                 2:fBtnMap[i].Text:='C';
                 3:fBtnMap[i].Text:='D';
                 4:fBtnMap[i].Text:='E';
                 10:fBtnMap[i].Text:='F';
                 11:fBtnMap[i].Text:='G';
                 12:fBtnMap[i].Text:='H';
                 13:fBtnMap[i].Text:='I';
                 14:fBtnMap[i].Text:='J';
                 15:fBtnMap[i].Text:='K';
                 16:fBtnMap[i].Text:='L';
                 end;


              end;

       end;


   end;



end;

procedure tComplexDlg.DoPrevClick(sender: TObject);
var
i:integer;
begin
if fDlgUp then exit;
//prev
if fNumThings>10 then
   begin
     if fStartNum>=10 then
       begin
         fStartNum:=fStartNum-10;
         //relabel header..
          for I := Low(fBtnHeader) to High(fBtnHeader) do
              begin
                fBtnHeader[i].Tag:=fStartNum+i;
                fBtnHeader[i].Text:=IntToStr((fStartNum+1)+i);
                fBtnType[i].RecordID:=fStartNum+i;
                fBTnType[i].ByteValue:=fThing.fThingType[fStartNum+i];
                fBtnType[i].Text:=IntToStr(fThing.FThingType[fStartNum+i]);
                fBtnMap[i].RecordID:=fStartNum+i;
                fBtnMap[i].ByteValue:=fThing.fThingSub[fStartNum+i];
                 case fThing.fThingSub[fStartNum+i] of
                 0:fBtnMap[i].Text:='A';
                 1:fBtnMap[i].Text:='B';
                 2:fBtnMap[i].Text:='C';
                 3:fBtnMap[i].Text:='D';
                 4:fBtnMap[i].Text:='E';
                 5:fBtnMap[i].Text:='F';
                 6:fBtnMap[i].Text:='G';
                 7:fBtnMap[i].Text:='H';
                 8:fBtnMap[i].Text:='I';
                 9:fBtnMap[i].Text:='J';
                 10:fBtnMap[i].Text:='K';
                 11:fBtnMap[i].Text:='L';
                 end;

              end;

       end;


   end;

end;



procedure tComplexDlg.TogGF(sender: TObject);
begin
if fDlgUp then exit;

if fNumThings<MAX_THINGS then fNumThings:=fNumThings+10 else fNumThings:=10;



                     fBtnGF.Text:=IntToStr(fNumThings);
                     fThing.NumThings:=fNumThings;


end;


procedure tComplexDlg.DoTypeClick(sender: TObject);
begin
if fDlgUp then exit;

   if sender is tDlgInputButton then
     with sender as tDlgInputButton do
        begin
         if ByteValue<3 then ByteValue:=ByteValue+1 else ByteValue:=1;



              Text:=IntToStr(ByteValue);
              fThing.FThingType[RecordId]:=ByteValue;

        end;


end;


procedure tComplexDlg.DoMapClick(sender: TObject);
var
i:integer;
begin
if fDlgUp then exit;
   if sender is tDlgInputButton then
     with sender as tDlgInputButton do
        begin

          if ByteValue<12 then ByteValue:=ByteValue+1 else ByteValue:=0;
                 i:=ByteValue;

                //update button storage
                 case i of
                 0:Text:='A';
                 1:Text:='B';
                 2:Text:='C';
                 3:Text:='D';
                 4:Text:='E';
                 5:Text:='F';
                 6:Text:='G';
                 7:Text:='H';
                 8:Text:='I';
                 9:Text:='J';
                 10:Text:='K';
                 11:Text:='L';
                 end;

                  //update our thing..
                 fThing.FThingSub[RecordId]:=i;


        end;

end;

procedure tComplexDlg.DoNameClick(sender: TObject);
begin
//nop
end;

procedure TComplexDlg.SetThing(value: tSomeThing);
begin
  fThing:=value;
  Refresh;
end;


procedure tComplexDlg.Refresh;
var
i:integer;
begin

   fStartNum:=0;
  fBtnName.Text:=fThing.ThingName;
  fBtnGF.Text:=IntToStr(fthing.NumThings);
  fBtnMaxS.Text:=IntToStr(fThing.D1Value);
  fBtnMaxP.Text:=IntToStr(fThing.D2Value);

  fBtnP1.Text:=IntToStr(fThing.P1);
  fBtnB1.Text:=IntToStr(fThing.B1);
  fBtnB2.Text:=IntToStr(fThing.B2);
  fBtnB3.Text:=IntToStr(fThing.B3);
  fBtnB4.Text:=IntToStr(fThing.B4);


    for I := Low(fBtnHeader) to High(fBtnHeader) do
        begin
        fBtnHeader[i].Text:=IntToStr(i+1);
        fBtnType[i].RecordID:=i;
        fBtnType[i].ByteValue:=fThing.FThingType[i];
        fBtnType[i].Text:=IntToStr(fThing.FThingType[i]);

         fBtnMap[i].RecordID:=i;
         fBtnMap[i].ByteValue:=fThing.FThingSub[i];
          case fThing.FThingSub[i] of
          0:fBtnMap[i].Text:='A';
          1:fBtnMap[i].Text:='B';
          2:fBtnMap[i].Text:='C';
          3:fBtnMap[i].Text:='D';
          4:fBtnMap[i].Text:='E';
          5:fBtnMap[i].Text:='F';
          6:fBtnMap[i].Text:='G';
          7:fBtnMap[i].Text:='H';
          8:fBtnMap[i].Text:='I';
          9:fBtnMap[i].Text:='J';
          10:fBtnMap[i].Text:='K';
          11:fBtnMap[i].Text:='L';
          end;



        end;



end;


procedure tComplexDlg.DoP1Click(sender: TObject);
begin
  //open up a numpad..
if fDlgUp then exit;
     if not assigned(fNumPad) then
        begin

          fNumPad:=tDlgNumPad.Create(self,fmat,height,height/1.25,Width/2,Height/2);
        end;
          fNumPad.Number:=fP1;
          fNumPad.OnDone:=OnP1Done;
          fNumPad.Parent:=self.Parent;
        //  fNumPad.BackIm.Parent:=self.Parent;

          fNumPad.Position.Z:=-10;
          fNumPad.Opacity:=0.85;
          fNumPad.Visible:=true;
        //  Self.Visible:=false;
          fDlgUp:=true;




end;

procedure tComplexDlg.OnP1Done(sender: TObject;aExitType:integer);
begin

  if assigned(fNumPad) then
    begin
      if aExitType=0 then
       begin
         fP1:=fNumPad.Number;
       end;
       fNumPad.Visible:=false;
       Self.Visible:=true;
    end;

   fBtnP1.Text:=IntToStr(fP1);
   fThing.P1:=fP1;
   fDlgUp:=false;


end;


procedure tComplexDlg.DoB1Click(sender: TObject);
begin
if fDlgUp then exit;

  //open up a numpad..
     if not assigned(fNumPad) then
        begin

          fNumPad:=tDlgNumPad.Create(self,fmat,height,height/1.25,Width/2,Height/2);
        end;
          fNumPad.Number:=fB4;
          fNumPad.OnDone:=OnB1Done;
          fNumPad.Parent:=self.Parent;
       //   fNumPad.BackIm.Parent:=self.Parent;

          fNumPad.Position.Z:=-10;
          fNumPad.Visible:=true;
         // Self.Visible:=false;
          fDlgUp:=True;





end;

procedure tComplexDlg.OnB1Done(sender: TObject;aExitType:integer);
begin

  if assigned(fNumPad) then
    begin
    if aExitType=0 then
      begin
         fB4:=fNumPad.Number;
      end;
       fNumPad.visible:=false;
      Self.Visible:=true;
    end;
   fBtnB1.Text:=IntToStr(fB4);
   fThing.B1:=fB4;
   fDlgUp:=false;


end;



procedure tComplexDlg.DoB2Click(sender: TObject);
begin
if fDlgUp then exit;

  //open up a numpad..
     if not assigned(fNumPad) then
        begin
          fNumPad:=tDlgNumPad.Create(self,fmat,height,height/1.25,Width/2,Height/2);
        end;
          fNumPad.Number:=fB1;
          fNumPad.OnDone:=OnB2Done;
          fNumPad.Parent:=self.Parent;

          fNumPad.Position.Z:=-10;
          fNumPad.Visible:=true;

         fDlgUp:=true;




end;

procedure tComplexDlg.OnB2Done(sender: TObject;aExitType:integer);
begin

  if assigned(fNumPad) then
    begin
    if aExitType=0 then
     begin
         fB1:=fNumPad.Number;
     end;
       fNumPad.visible:=false;
      Self.Visible:=true;
    end;

   fBtnB2.Text:=IntToStr(fB1);
   fThing.B2:=fB1;
   fDlgUp:=false;


end;

procedure tComplexDlg.DoB3Click(sender: TObject);
begin
  //open up a numpad..
  if fDlgUp then exit;

     if not assigned(fNumPad) then
        begin

          fNumPad:=tDlgNumPad.Create(self,fmat,height,height/1.25,Width/2,Height/2);
        end;
          fNumPad.Number:=fB2;
          fNumPad.OnDone:=OnB3Done;
          fNumPad.Parent:=self.Parent;
      //    fNumPad.BackIm.Parent:=self.Parent;

          fNumPad.Position.Z:=-10;
          fNumPad.Visible:=true;
         // Self.Visible:=false;
         fDlgUp:=true;





end;

procedure tComplexDlg.OnB3Done(sender: TObject;aExitType:integer);
begin

  if assigned(fNumPad) then
    begin
    if aExitType=0 then
      begin
         fB2:=fNumPad.Number;
      end;
       fNumPad.Visible:=false;
      Self.Visible:=true;
    end;

   fBtnB3.Text:=IntToStr(fB2);
   fDlgUp:=False;
   fThing.B3:=fb2;

end;



procedure tComplexDlg.DoB4Click(sender: TObject);
begin
  //open up a numpad..
  if fDlgUp then exit;

     if not assigned(fNumPad) then
        begin

          fNumPad:=tDlgNumPad.Create(self,fmat,height,height/1.25,Width/2,Height/2);
        end;
          fNumPad.Number:=fB3;
          fNumPad.OnDone:=OnB4Done;
          fNumPad.Parent:=self.Parent;
       //   fNumPad.BackIm.Parent:=self.Parent;

          fNumPad.Position.Z:=-10;
          fNumPad.Visible:=true;
        //  Self.Visible:=false;
        fDlgUp:=True;





end;

procedure tComplexDlg.OnB4Done(sender: TObject;aExitType:integer);
begin

  if assigned(fNumPad) then
    begin
    if aExitType=0 then
      begin
         fB3:=fNumPad.Number;
      end;
       fNumPad.visible:=false;
      Self.Visible:=true;
    end;

   fBtnB4.Text:=IntToStr(fB3);
   fDlgUp:=False;
   fThing.B4:=fb3;

end;




end.
