unit uKeyboardDlg;


{On screen keyboard..
 created:12.4.2018 dm

 added specail keys and carret support 10.25.2021

 be it harm none, do as ye wishes..

}



interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.UIConsts,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, System.Math.Vectors, FMX.Ani, FMX.Controls3D, FMX.Layers3d,
  FMX.MaterialSources, FMX.Objects3D, FMX.Effects, FMX.Filter.Effects,uDlg3dCtrls;

  type
      TDlgKeyboardBtnClick_Event = procedure (sender:tObject; aKeyNum:integer) of object;






TDlgKeyboard = class(TDummy)
  private
     fBtnName:TDlgInputButton;
     fBtnDone:tDlgButton;
     fBtnFunct:tDlgButton;
     fBtnErase:tDlgButton;
    //39 keys..
    fKeys: array[0..38] of TDlgButton;
    fNavBtns:array of tDlgButton;
    fKeyboardMat:TDlgMaterial;
    fShifted:boolean;
    fFunct:boolean;
    fClickEvent:TDlgKeyboardBtnClick_Event;
    fDoneEvent:TDlgClick_Event;
    fIm:TImage3d;
    fAllowSpec:boolean;
    fStrReturned:String;
    fBtnLabel:String;
    fCleanedUp:boolean;
  protected
    procedure DoErase(sender:tObject);
    procedure DoFunct(sender:tObject);
    procedure DoDone(sender:tObject);
    procedure DoNav(sender:tObject);
    procedure DoClick(sender:tObject);
    procedure UpdateStr(aKeyNum:integer);
    function GetKey(aKeyNum:integer):TDlgButton;
    procedure SetKey(aKeyNum:integer;value:TDlgButton);
    procedure SetShifted(aValue:Boolean);
    procedure SetStrReturned(aStr:String);
    function  GetStrReturned:String;
    procedure SetLabel(aStr:String);
  public
    constructor Create(aOwner:TComponent;aKeyboardMat:TDlgMaterial;
                    aWidth,aHeight,aX,aY:single); reintroduce;
    destructor Destroy;override;
    procedure CleanUp;
    property Keys[index:integer]:TDlgButton read GetKey write SetKey;
    function GetKeyText(keyNum:integer):string;
    procedure Refresh;
  published
  property BackIm:TImage3d read fim write fim;
  property Shifted:boolean read fShifted write fShifted;
  property OnKeyClick:TDlgKeyboardBtnClick_Event read fClickEvent write fClickEvent;
  property StrGet:string read GetStrReturned write SetStrReturned;
  property OnDone:TDlgClick_Event read fDoneEvent write fDoneEvent;
  property BtnLabel:String read fBtnLabel write SetLabel;
  property AllowSpec:boolean read fAllowSpec write fAllowSpec;

end;



implementation



function TDlgKeyboard.GetKeyText(keyNum:integer):string;
begin
if fFunct then
 begin
          case KeyNum of
            0:
              result := '!';
            1:
              result := '@';
            2:
              result := '#';
            3:
              result := '$';
            4:
              result := '%';
            5:
              result := '^';
            6:
              result := '&';
            7:
              result := '*';
            8:
              result := '(';
            9:
              result := ')';
            10:
              result := '7';
            11:
              result := '8';
            12:
              result := '9';
            13:
              result := '+';
            14:
              result := '{';
            15:
              result := '}';
            16:
              result := '[';
            17:
              result := ']';
            18:
              result := '\';
            19:
              result := '/';
            20:
              result := '.';
            21:
              result := '>';
            22:
              result := '4';
            23:
              result := '5';
            24:
              result := '6';
            // shift inserted here
            25:
              result := 'Shift';
            26:
              result := '<';
            27:
              result := ':';
            28:
              result := '"';
            29:
              result := 'http://';
            30:
              result := '=';
            31:
              result := '~';
            32:
              result := '-';
            33:
              result := 'BkSp';
            34:
              result := '1';
            35:
              result := '2';
            36:
              result := '3';
            37:
              result := 'Space';
            38:
              result := '0';
          end;



 end
  else
 begin
 if fShifted then
   begin
    case keyNum of
    0:result:='Q';
    1:result:='W';
    2:result:='E';
    3:result:='R';
    4:result:='T';
    5:result:='Y';
    6:result:='U';
    7:result:='I';
    8:result:='O';
    9:result:='P';
    10:result:='7';
    11:result:='8';
    12:result:='9';
    13:result:='A';
    14:result:='S';
    15:result:='D';
    16:result:='F';
    17:result:='G';
    18:result:='H';
    19:result:='J';
    20:result:='K';
    21:result:='L';
    22:result:='4';
    23:result:='5';
    24:result:='6';
    //shift inserted here
    25:result:='Shift';
    26:result:='Z';
    27:result:='X';
    28:result:='C';
    29:result:='V';
    30:result:='B';
    31:result:='N';
    32:result:='M';
    33:result:='BkSp';
    34:result:='1';
    35:result:='2';
    36:result:='3';
    37:result:='Space';
    38:result:='0';
    end;

   end else
        begin
          case KeyNum of
            0:
              result := 'q';
            1:
              result := 'w';
            2:
              result := 'e';
            3:
              result := 'r';
            4:
              result := 't';
            5:
              result := 'y';
            6:
              result := 'u';
            7:
              result := 'i';
            8:
              result := 'o';
            9:
              result := 'p';
            10:
              result := '7';
            11:
              result := '8';
            12:
              result := '9';
            13:
              result := 'a';
            14:
              result := 's';
            15:
              result := 'd';
            16:
              result := 'f';
            17:
              result := 'g';
            18:
              result := 'h';
            19:
              result := 'j';
            20:
              result := 'k';
            21:
              result := 'l';
            22:
              result := '4';
            23:
              result := '5';
            24:
              result := '6';
            // shift inserted here
            25:
              result := 'Shift';
            26:
              result := 'z';
            27:
              result := 'x';
            28:
              result := 'c';
            29:
              result := 'v';
            30:
              result := 'b';
            31:
              result := 'n';
            32:
              result := 'm';
            33:
              result := 'BkSp';
            34:
              result := '1';
            35:
              result := '2';
            36:
              result := '3';
            37:
              result := 'Space';
            38:
              result := '0';
          end;


        end;
 end;


end;



constructor TDlgKeyboard.Create(aOwner: TComponent;aKeyboardMat:TDlgMaterial;
           aWidth: Single;aHeight: Single; aX: Single; aY: Single);
var
i:integer;
newx,newy:single;
aButtonHeight,aButtonWidth:single;
aColGap,aRowGap,aBorder:single;
SectionHeight:single;
ah,af,ap:single;
numpadStart:single;
aHeaderWidth:single;
begin

  inherited Create(aOwner);
  fCleanedUp:=false;
  //set our cam first always!!!
  Projection:=TProjection.Screen;

//  fBlockMaterial:=aScoreGridMat.fmtNormal.fmtSmallBlocks;
//  fRectMaterial:=aScoreGridMat.fmtNormal.fmtLargeRects;
  fKeyboardMat:=aKeyboardMat;
  fShifted:=false;
  fAllowSpec:=false;
  fFunct:=false;//allows for special keys
  Opacity:=0.95;
  aBorder:=4;

  //set w,h and pos
  Width:=Trunc(aWidth-(aBorder*2));
  Height:=Trunc(aHeight-(aBorder*2));
  Position.X:=aX;
  Position.Y:=aY;
  Depth:=1;

  fim:=TImage3d.Create(self);
  fIm.Projection:=TProjection.Screen;
  fIm.Width:=Width;
  fIm.Height:=Height;
  fIm.HitTest:=false;
  fIm.Position.X:=0;
  fIm.Position.Y:=0;
  fIm.Position.Z:=0;
  fIm.Parent:=self;
  fIm.Bitmap:=fKeyboardMat.BackImage;





  aColGap:=2;
  aRowGap:=2;
  aButtonWidth:=Width/13;//divide width by max keys in a row
  aButtonWidth:=Trunc(aButtonWidth-(aColGap)-(aColGap/2));

  aHeaderWidth:=(aButtonWidth*9)+(aColGap*7);
 // aHeaderWidth:=aHeaderWidth-aColGap;


  fKeyboardMat.FontSize:=24;

  ah:=Height / 6;// devide height by number of rows..
  SectionHeight:=ah;
  SectionHeight:=Trunc(SectionHeight-aRowGap-(aRowGap/2));

//change font size..
  if SectionHeight>79 then
    begin
     fKeyboardMat.FontSize:=24;
    end else
    begin
      fKeyboardMat.FontSize:=20;
    end;

  if SectionHeight>100 then
     begin
     fKeyboardMat.FontSize:=28;
     end;



   newy:=Round(((Height/2)*-1)+(SectionHeight/2)+aBorder);
   newx:=Round(((Width/2)*-1)+(aHeaderWidth/2)+aColGap+aBorder);

      fBtnName:=tDlgInputButton.Create(self,aHeaderWidth,SectionHeight,newx,newy);
      fBtnName.Projection:=TProjection.Screen;
      fBtnName.Parent:=self;
      fBtnName.MaterialSource:=fKeyboardMat.LongRects;
   //   fBtnName.RectButton.MaterialBackSource:=fKeyboardMat.LongRects;
    //  fBtnName.RectButton.MaterialShaftSource:=fKeyboardMat.LongRects;
      fBtnName.TextColor:=fKeyboardMat.Buttons.TextColor.Color;
      fBtnName.LabelColor:=fKeyboardMat.Buttons.TextColor.Color;
      fBtnName.FontSize:=fKeyboardMat.FontSize;
      fBtnName.LabelSize:=fKeyboardMat.FontSize/1.25;
      //back up the texture, we be frawing our own text for awhile.. :(
    //  fBtnName.BtnBitMap.Resize(fKeyboardMat.LongRects.Texture.Width,fKeyboardMat.LongRects.Texture.Height);
      fBtnName.BtnBitMap.Assign(fKeyboardMat.LongRects.Texture);

      fBtnName.Text:='';
      fBtnName.LabelText:='Enter new string.';
      fBtnName.Opacity:=0.90;

      setLength(fNavBtns,4);
           newx:=Round(newx+(aHeaderWidth/2)+(aButtonWidth/2)+aColGap+aBorder);

       for I := Low(fNavBtns) to High(fNavBtns) do
         begin
           fNavBtns[i]:=TDlgButton.Create(self,aButtonwidth,SectionHeight,newx,newy);
           fNavBtns[i].Projection:=TProjection.Screen;
           fNavBtns[i].Parent:=self;
           fNavBtns[i].Tag:=i;
           fNavBtns[i].MaterialSource:=fKeyboardMat.Buttons.Button;
           fNavBtns[i].Opacity:=0.90;
  //         fNavBtns[i].fRectButton.MaterialBackSource:=fKeyboardMat.tmButtons.mtButton;
  //         fNavBtns[i].fRectButton.MaterialShaftSource:=fKeyboardMat.tmButtons.mtButton;
           fNavBtns[i].TextColor:=fKeyboardMat.Buttons.TextColor.Color;
           fNavBtns[i].FontSize:=fKeyboardMat.FontSize;
           fNavBtns[i].BtnBitMap.Assign(fKeyboardMat.Buttons.Button.Texture);

           fNavBtns[i].OnClick:=DoNav;
             case i of
             0:fNavBtns[i].Text:='<<';
             1:fNavBtns[i].Text:='<';
             2:fNavBtns[i].Text:='>';
             3:fNavBtns[i].Text:='>>';
             end;
           newx:=newx+aButtonWidth+aColGap;
         end;





      //new line
      newy:=newy+SectionHeight+aRowGap;



   newx:=Round(((Width/2)*-1)+(aButtonWidth/2)+aColGap+aBorder);

   numpadStart:=0;
  for I := Low(fKeys) to High(fKeys) do
   begin
    if i=37 then  //space
      begin
      fBtnFunct:=tDlgButton.Create(self,aButtonWidth,SectionHeight,Newx,Newy);
      fBtnFunct.Projection:=tProjection.Screen;
      fBtnFunct.Parent:=self;
      fBtnFunct.MaterialSource:=fKeyboardMat.Buttons.Button;
      fBtnFunct.Opacity:=0.90;
      fBtnFunct.TextColor:=fKeyboardMat.Buttons.TextColor.Color;

      fBtnFunct.FontSize:=fKeyboardMat.FontSize;
      fBtnFunct.BtnBitMap.Assign(fKeyboardMat.Buttons.button.Texture);
      fBtnFunct.OnClick:=DoFunct;//DoDone;//NameClick;//btnClick;
      fBtnFunct.Text:='Func';//GetKeyText(0,i);//default 1st menu

       newx:=Round(((Width/2)*-1)+((aButtonWidth*6)/2)+(aButtonWidth*2)+(aButtonWidth/2)+aColGap+aBorder);
       fKeys[i]:=TDlgButton.Create(self,aButtonwidth*6,SectionHeight,newx,newy);

       newx:=Round(newx+(aButtonWidth*3)+(aButtonWidth/2)+aColGap);

      fBtnErase:=tDlgButton.Create(self,aButtonWidth,SectionHeight,Newx,Newy);
      fBtnErase.Projection:=tProjection.Screen;
      fBtnErase.Parent:=self;
      fBtnErase.Opacity:=0.90;
      fBtnErase.MaterialSource:=fKeyboardMat.Buttons.Button;
      fBtnErase.FontSize:=fKeyboardMat.FontSize;
      fBtnErase.TextColor:=fKeyboardMat.Buttons.TextColor.Color;
      fBtnErase.BtnBitMap.Assign(fKeyboardMat.Buttons.Button.Texture);
      fBtnErase.OnClick:=DoErase;//DoDone;//NameClick;//btnClick;
      fBtnErase.Text:='Erase';//GetKeyText(0,i);//default 1st menu



       end else
           fKeys[i]:=TDlgButton.Create(self,aButtonwidth,SectionHeight,newx,newy);
    //now set it up..
    fKeys[i].Projection:=TProjection.Screen;
    fKeys[i].Parent:=self;
    fkeys[i].Tag:=i;
    fKeys[i].Opacity:=0.90;
    if i<>37 then
     begin
      fkeys[i].MaterialSource:=fKeyboardMat.Buttons.Button;
      fKeys[i].BtnBitMap.Assign(fKeyboardMat.Buttons.Button.Texture);
     end else
       begin
       fkeys[i].MaterialSource:=fKeyboardMat.LongRects;
       fKeys[i].BtnBitMap.Assign(fKeyboardMat.LongRects.Texture);
       end;
    fKeys[i].OnClick:=DoClick;
    fKeys[i].TextColor:=fKeyboardMat.Buttons.TextColor.Color;
    fKeys[i].FontSize:=fKeyboardMat.FontSize;

    fkeys[i].Text:=GetKeyText(i);
    newx:=newx+aButtonWidth+aColGap;

    //number keys are special
    if i=9 then
      begin
       newx:=newx+aColGap;
       numpadStart:=newx;//remeber this locartion
      end;
    if i=21 then
    newx:=numpadStart;
    if i=33 then
    newx:=numpadStart;
    if i=37 then
    newx:=numPadStart+(aButtonWidth+aColGap);



    //row breaks
    if i=12 then
      begin
       newy:=newy+SectionHeight+aRowGap;
       newx:=Round(((Width/2)*-1)+(aButtonWidth/2)+(aButtonWidth/2)+aBorder);
      end;
    if i=24 then
      begin
       newy:=newy+SectionHeight+aRowGap;
       newx:=Round(((Width/2)*-1)+((aButtonWidth/2)+aButtonWidth)+aBorder);
      end;
    if i=36 then
      begin
       newy:=newy+SectionHeight+aRowGap;
       newx:=Round(((Width/2)*-1)+((aButtonWidth)+(aButtonWidth))+aBorder);
      end;


    end;

       newy:=newy+SectionHeight+aRowGap;

   newx:=aBorder;//((aWidth/2)*-1)+(aHeaderWidth/2);

      fBtnDone:=tDlgButton.Create(self,aHeaderWidth,SectionHeight,newx,newy);
      fBtnDone.Projection:=TProjection.Screen;
      fBtnDone.Parent:=self;
      fBtnDone.Opacity:=0.90;
      fBtnDone.MaterialSource:=fKeyboardMat.LongRects;
      fBtnDone.FontSize:=fKeyboardMat.FontSize;
      fBtnDone.BtnBitMap.Assign(fKeyboardMat.LongRects.Texture);
      fBtnDone.TextColor:=fKeyboardMat.Buttons.TextColor.Color;
      fBtnDone.OnClick:=DoDone;
      fBtnDone.Text:='Done';





end;

procedure TDlgKeyboard.Refresh;
var
i:integer;
begin
   //all the buttons
     for I := 0 to High(fKeys) do
    fkeys[i].Text:=GetKeyText(i);

end;


//clean up..
destructor TDlgKeyboard.Destroy;
var
i:integer;
begin
  try
    if not fCleanedUp then  CleanUp;

  finally
   //fafa
   inherited;
  end;
end;

procedure TDlgKeyboard.CleanUp;
var
i:integer;
begin
   if fCleanedUp then Exit;

  try
     fBtnName.CleanUp;
     fBtnName.Free;
     fBtnName:=nil;
     fBtnDone.CleanUp;
     fBtnDone.Free;
     fBtnDone:=nil;
     fBtnFunct.CleanUp;
     fBtnFunct.Free;
     fBtnFunct:=nil;
     fBtnErase.CleanUp;
     fBtnErase.Free;
     fBtnErase:=nil;

     fIm.Parent:=nil;
     fIm.Bitmap:=nil;
     fIm.Free;
     fIm:=nil;
   //all the buttons
     for I := 0 to High(fKeys) do
       begin
        fKeys[i].CleanUp;
        fKeys[i].Free;
        fKeys[i]:=nil;
       end;
     for I := Low(fNavBtns) to High(fNavBtns) do
       begin
       fNavBtns[i].CleanUp;
       fNavBtns[i].Free;
       fNavBtns[i]:=nil;
       end;

   // SetLength(fKeys,0);
    SetLength(fNavBtns,0);
   // fKeys:=nil;
    fNavBtns:=nil;
    Parent:=nil;

    fKeyboardMat:=nil;

   fCleanedUp:=true;
  finally
  end;
end;


procedure TDlgKeyboard.SetShifted(aValue:boolean);
begin
  //toggle shifted state
   if aValue=fShifted then exit;//nothing todo

   fShifted:=aValue;
   Refresh;


end;

procedure TDlgKeyboard.SetLabel(aStr: string);
begin
  if aStr<>fBtnLabel then
    begin
      fBtnLabel:=aStr;
      fBtnName.LabelText:=fBtnLabel;
    end;
end;

procedure TDlgKeyboard.SetStrReturned(aStr: string);
begin
  if aStr=fStrReturned then exit;// nothing to do..
  aStr:=aStr+'|';
  fStrReturned:=aStr;
  fBtnName.Text:=aStr;


end;

function TDlgKeyboard.GetStrReturned;
var
aPos:integer;
begin

//position of the carret
 aPos:=Pos('|',fStrReturned);
 if aPos>0 then
    begin
    //take it away
    Delete(fStrReturned,aPos,1);
    end;
  result:=fStrReturned;
end;

//get and sets for our players in the grid
procedure TDlgKeyboard.SetKey(aKeyNum: Integer; value: TDlgButton);
begin
if aKeyNum>High(fKeys) then exit;//outa here
fKeys[aKeyNum]:=value;
end;

function TDlgKeyboard.GetKey(aKeyNum: Integer):TDlgButton;
begin
result:=nil;//nil the result
if aKeyNum>High(fKeys) then exit;//outa here
result:=fKeys[aKeyNum];
end;

procedure TDlgKeyboard.DoDone(sender: TObject);
begin
  if assigned(fDoneEvent) then
      FDoneEvent(sender);
end;

procedure TDlgKeyboard.DoErase(sender: TObject);
begin
  //erase all
     fStrReturned:='|';
      fBtnName.Text:=fStrReturned;

end;

procedure TDlgKeyboard.DoFunct(sender: TObject);
begin
  //show special keys if allowed
  if fAllowSpec then
    begin
     if FFunct=true then
        fFunct:=false else
          fFunct:=true;
     Refresh;
    end;

end;


procedure TDlgKeyboard.DoNav(sender: TObject);
var
aBtnNum:integer;
aPos:integer;
aLen:integer;
begin
aBtnNum:=-1;
   if Sender is TRectangle3d then
     aBtnNum:=TRectangle3d(sender).Tag;

             { move the carret
              0=first
              1=prev
              2=next
              3=last
             }

      if aBtnNUm=-1 then exit;


    aPos:=Pos('|',fStrReturned);
    aLen:=Length(fStrReturned);
    if aLen<2 then exit;// nothing to move!!
    if (aPos=1) and (aBtnNum in [0,1]) then exit;//already at the beginning
    if (aPos=aLen) and (aBtnNum in [2,3]) then exit;//already at the end


    Delete(fStrReturned,aPos,1);//remove it


     case aBtnNum of
     0:fStrReturned:='|'+fStrReturned;
     1:begin
       Dec(aPos);
       Insert('|',fStrReturned,aPos);
       end;
     2:begin
       Inc(aPos);
       Insert('|',fStrReturned,aPos);
       end;
     3:fStrReturned:=fStrReturned+'|';
     end;


      fBtnName.Text:=fStrReturned;



end;

procedure TDlgKeyboard.DoClick(sender: TObject);
var
aBtnNum:integer;
begin
aBtnNum:=-1;
   if Sender is TRectangle3d then
     aBtnNum:=TRectangle3d(sender).Tag;

    UpdateStr(aBtnNum);

   if aBtnNum=25 then
       begin
         if fShifted then SetShifted(false) else SetShifted(true);
         exit;
       end;

   if aBtnNum>-1 then
     if assigned(fClickEvent) then fClickEvent(sender,aBtnNum);


end;


procedure TDlgKeyboard.UpdateStr(aKeyNum: Integer);
var
aStr,eStr:String;
aPos:integer;
aLen:integer;
begin

//position of the carret
 aPos:=Pos('|',fStrReturned);
 //length of the string
 aLen:=Length(fStrReturned);


 eStr:='';
 if aPos>0 then
    begin
    //take it away
    eStr:=Copy(fStrReturned,aPos,aLen-(aPos-1));
    Delete(fStrReturned,aPos,aLen-(aPos-1));

    end;


 if aKeyNum in [25,33,37] then
   begin
     //33 del, 37 space
     if aKeyNum<>25 then //ignore shift
       begin
        if aKeyNum=33 then
         begin
           if length(fStrReturned)>1 then
             fStrReturned:=Copy(fStrReturned,1,Length(fStrReturned)-1) else
               fStrReturned:='';
         end else
           begin
            //space
            fStrReturned:=fStrReturned+' ';
           end;

       end;

   end else
     begin
      aStr:=GetKeyText(aKeyNum);
      fStrReturned:=fStrReturned+aStr;


     end;

   //put it back
   fStrReturned:=fStrReturned+eStr;
   fBtnName.Text:=fStrReturned;
   fBtnName.Repaint;

end;



end.
