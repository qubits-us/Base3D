unit uIPChangeDlg;

interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.UIConsts,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, System.Math.Vectors, FMX.Ani, FMX.Controls3D,
  FMX.MaterialSources, FMX.Objects3D, FMX.Effects, FMX.Filter.Effects,FMX.Layers3D,
  FMX.Objects,uDlg3dCtrls;




  type
      TDlgIPNumPad = class(TDummy)
        private
        fMat:TDlgMaterial;
        fIm:TImage3d;
        fNumGetBtn:TDlgInputButton;
        fCancelBtn:TDlgButton;
        fDoneBtn:TDlgButton;
        fKeys:array of TDlgButton;
        fIP:String;
        fDoneEvent:TDlgClick_Event;
        fCancelEvent:TDlgClick_Event;
        fCleanedUp:Boolean;

        protected
        procedure DoDone(sender:tObject);
        procedure DoCancel(sender:TObject);
        procedure KeyClick(sender:tObject);
        procedure SetIP(aIP:String);

        public
       constructor Create(aOwner:TComponent;aMat:TDlgMaterial;
                    aWidth,aHeight,aX,aY:single); reintroduce;
       destructor  Destroy;override;
       procedure  CleanUp;

       property OnDone:TDlgClick_Event read fDoneEvent write fDoneEvent;
       property OnCancel:TDlgCLick_Event read fCancelEvent write fCancelEvent;
       property IP:String read fIP write SetIP;
       property BackIm:Timage3d read fim write fim;
      end;




implementation

uses uDlg3dTextures;



constructor TDlgIPNumPad.Create(aOwner: TComponent; aMat: TDlgMaterial;
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
  Opacity:=0.95;
  fMat:=aMat;
  aFontSize:=fMat.FontSize;

  //set w,h and pos
  Width:=(aWidth);
  Height:=(aHeight);
  Position.X:=(aX);
  Position.Y:=(aY);
  Depth:=1;
  tmpBitmap:=MakeDlgBackGrnd(Width+22,Height+20,0,0,10);

  fIm:=TImage3d.Create(self);
  fIm.Projection:=tProjection.Screen;
  fIm.Bitmap.Assign(tmpBitmap);
  tmpBitmap.Free;
  fIm.Width:=aWidth+22;
  fIm.Height:=aHeight+20;
  fIm.HitTest:=false;
  fIm.Position.X:=aX;//aWidth/2;
  fIm.Position.Y:=aY;//aHeight/2;
  fIm.Position.Z:=0;
  fIm.Parent:=self;
  fIm.Opacity:=0.85;





  if Width>600 then
  SectionHeight:=80 else
  SectionHeight:=50;

  aColGap:=2;
  aRowGap:=2;
  aButtonWidth:=aWidth-aColGap;//divide width by max keys in a row
  aParamWidth:=(aButtonWidth/2);

  aFontSize:=32;

  ah:=(Height / 6);// devide height by number of rows..
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
     aFontSize:=32;
    end else
    begin
      aFontSize:=24;
    end;

  if SectionHeight>100 then
     begin
     aFontSize:=36;
     end;




  newy:=(((aHeight/2)*-1)+(SectionHeight/2));//top
  newx:=(((aWidth/2)*-1)+(aButtonWidth/2));//left

    fNumGetBtn:=tDlgInputButton.Create(self,aButtonwidth,SectionHeight,newx,newy);
    fNumGetBtn.Projection:=TProjection.Screen;
    fNumGetBtn.Parent:=self;
    fNumGetBtn.MaterialSource:=fMat.Large.Rect;
    fNumGetBtn.BtnBitMap.Assign(fMat.Large.Rect.Texture);
    fNumGetBtn.LabelColor:=fMat.Buttons.TextColor.Color;
    fNumGetBtn.TextColor:=fMat.Buttons.TextColor.Color;
    fNumGetBtn.FontSize:=fMat.FontSize;
    fNumGetBtn.LabelSize:=fMat.FontSize/1.5;
    fNumGetBtn.Text:='0';
    fNumGetBtn.LabelText:='Enter new IP.';

      //new line
      newy:=newy+SectionHeight+aRowGap;

  aButtonWidth:=((aWidth/3)-aColGap);//divide width by max keys in a row


   newx:=(((aWidth/2)*-1)+(aButtonWidth/2));
   SetLength(fKeys,12);//12 buttons 4 rows

  // numpadStart:=0;
  for I := Low(fKeys) to High(fKeys) do
   begin
    fKeys[i]:=TDlgButton.Create(self,aButtonwidth,SectionHeight,newx,newy);
    //now set it up..
    fKeys[i].Projection:=TProjection.Screen;
    fKeys[i].Parent:=self;
    if i<>9 then
    fkeys[i].Tag:=i+1 else
    fkeys[i].Tag:=0;
    fkeys[i].MaterialSource:=fMat.Buttons.Rect;
    fKeys[i].OnClick:=KeyClick;//DoClick;
    fKeys[i].TextColor:=fMat.Buttons.TextColor.Color;
    fKeys[i].FontSize:=fMat.FontSize;
    //back up the texture, we be frawing our own text for awhile.. :(
    fKeys[i].BtnBitMap.Assign(fMat.Buttons.Rect.Texture);
    if i=High(fKeys) then
    fkeys[i].Text:='Clear' else
    if i=10 then
    fkeys[i].Text:='.' else
    if i=9 then
    fKeys[i].Text:='0' else
    fkeys[i].Text:=IntToStr(i+1);
    newx:=newx+aButtonWidth+aColGap;
    if i in [2,5,8,11] then
    begin
     newy:=newy+SectionHeight+aRowGap; //NL
//     newx:=((aWidth/2)*-1)+(aButtonWidth/2);//left
    newx:=(((aWidth/2)*-1)+(aButtonWidth/2)); //CR
    end;


   end;


   //now cancel and done buttons at bottom
    fCancelBtn:=TDlgButton.Create(self,aButtonwidth,SectionHeight,newx,newy);
    fCancelBtn.Projection:=TProjection.Screen;
    fCancelBtn.Parent:=self;
    fCancelBtn.MaterialSource:=fMat.Buttons.Rect;
    fCancelBtn.BtnBitMap.Assign(fMat.Buttons.Rect.Texture);
    fCancelBtn.TextColor:=fMat.Buttons.TextColor.Color;
    fCancelBtn.FontSize:=fMat.FontSize;

    fCancelBtn.Text:='Cancel';

    fCancelBtn.OnClick:=DoCancel;//CancelClick;

    newx:=newx+aButtonWidth+aColGap;
    fDoneBtn:=TDlgButton.Create(self,aButtonwidth,SectionHeight,newx,newy);
    fDoneBtn.Projection:=TProjection.Screen;
    fDoneBtn.Parent:=self;
    fDoneBtn.MaterialSource:=fMat.Buttons.Rect;
    fDoneBtn.FontSize:=fMat.FontSize;
    fDoneBtn.BtnBitMap.Assign(fMat.Buttons.Rect.Texture);
    fDoneBtn.TextColor:=fMat.Buttons.TextColor.Color;
    fDoneBtn.Text:='Done';
    fDoneBtn.OnClick:=DoDone;//DoneClick;







end;

destructor TDlgIPNumPad.Destroy;
var
i:integer;
begin
   if not fCleanedUp then CleanUp;

 inherited;
end;


procedure TDlgIpNumPad.CleanUp;
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

    SetLength(fkeys,0);

  fNumGetBtn.CleanUp;
  fNumGetBtn.Free;
  fNumGetBtn:=nil;

  fCancelBtn.CleanUp;
  fCancelBtn.Free;
  fCancelBtn:=nil;

  fDoneBtn.CleanUp;
  fDoneBtn.Free;
  fDoneBtn:=nil;

  fIm.Parent:=nil;
  //fIm.Bitmap:=nil;
  fIm.Free;
  fIm:=nil;
  fMat:=nil;
  Parent:=nil;
  fCleanedUp:=true;
end;



procedure TDlgIPNumPad.KeyClick(sender: TObject);
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
         aStr:=fIp+IntToStr(aTag);
         fIp:=aStr;
         fNumGetBtn.Text:=aStr;
       end;

   if aTag=11 then //dot
     begin
        fIp:=fIp+'.';
       fNumGetBtn.Text:=fIp;
     end;

   if aTag=12 then //clear
     begin
       fIp:='';
       fNumGetBtn.Text:='';
     end;



end;

procedure TDlgIPNumPad.DoDone(sender: TObject);
begin
  if Assigned(fDoneEvent) then
       fDoneEvent(sender);
end;


procedure TDlgIPNumPad.DoCancel(sender: TObject);
begin
  if assigned(fCancelEvent) then
       fCancelEvent(nil);
end;


procedure TDlgIPNumPad.SetIP(aIP: String);
begin
  if fIp<>aIp then
    begin
      fIp:=aIp;
      fNumGetBtn.Text:=fIp;
    end;
end;





end.
