unit uScene3dMenu;


{Menus for ????..
 created:12.14.2018 dm

 Added animated backgrounds 1.16.22 -dm

 be it harm none, do as ye wishes..


}



interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.UIConsts,FMX.Layers3D,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics,
  FMX.Dialogs, System.Math.Vectors, FMX.Ani, FMX.Controls3D,
  FMX.MaterialSources, FMX.Objects3D, FMX.Effects, FMX.Filter.Effects,uDlg3dCtrls;




type
TDlgMenu = class(TDummy)
  private
    //array of keys..
    fKeys: array of TDlgButton;
    fMenuMat:TDlgMaterial;
    fCurrentMenu:integer;
    fMenuSelect:tDlgSelect_Event;
    fCleanedUp:Boolean;
    fIm:TImage3d;
    fIm2:TImage3d;
    fImAni:TBitmapAnimation;//merge
    fImFa1:TFloatAnimation;//slides
    fImFa2:TFloatAnimation;
    fAniType:byte;//0=none 1=slide 2=merge
  protected
    function    GetKey(aKeyNum:integer):TDlgButton;
    procedure   SetKey(aKeyNum:integer;value:TDlgButton);
    procedure   btnClick(sender:tObject);
    procedure   SetAniType(aValue:byte);
    procedure   fa1SlideImFinished(sender:tobject);
    procedure   fa2SlideImFinished(sender:tobject);
    function    GetKeyText(aMenu,keyNum:integer):string;
    procedure   ChangeText(aValue:integer);
  public
    procedure   StartAni;
    procedure   StopAni;
    constructor Create(aOwner:TComponent;aMenuMat:TDlgMaterial;
                    aWidth,aHeight,aX,aY:single); reintroduce;
    destructor  Destroy;override;
    procedure   CleanUp;
    property    Keys[index:integer]:TDlgButton read GetKey write SetKey;
    property    OnSelect:TDlgSelect_Event read fMenuSelect write fMenuSelect;
    property    BackIm:TImage3d read fim write fim;
    property    AniType:byte read fAniType write SetAniType;
end;





implementation






constructor TDlgMenu.Create(aOwner: TComponent;aMenuMat:TDlgMaterial;
           aWidth: Single;aHeight: Single; aX: Single; aY: Single);
var
i:integer;
newx,newy:single;
aButtonHeight,aButtonWidth:single;
aColGap,aRowGap:single;
SectionHeight:single;
ah,af,ap:single;
numpadStart:single;
begin

  inherited Create(aOwner);
  //set our cam first always!!!
  fCleanedUp:=false;
  Projection:=TProjection.Screen;


  fMenuMat:=aMenuMat;

  //set w,h and pos
  Width:=aWidth;
  Height:=aHeight;
  Position.X:=aX;
  Position.Y:=aY;
  Depth:=1;
  fAniType:=0;//none
  fImAni:=nil;
  fImFa1:=nil;
  fImFa2:=nil;



  fIm:=TImage3d.Create(self);
  fIm.Projection:=tProjection.Screen;
  fIm.Bitmap:=aMenuMat.BackImage;
  fIm.Width:=aWidth;
  fIm.Height:=aHeight;
  fIm.HitTest:=false;
  fIm.Position.X:=0;
  fIm.Position.Y:=0;
  fIm.Position.Z:=0;
  fIm.Parent:=self;
  fIm.Visible:=true;

  fIm2:=TImage3d.Create(self);
  fIm2.Projection:=tProjection.Screen;
  fIm2.Bitmap:=aMenuMat.BackImage;
  fIm2.Width:=aWidth;
  fIm2.Height:=aHeight;
  fIm2.HitTest:=false;
  fIm2.Position.X:=(Width);//offscreen -->
  fIm2.Position.Y:=0;
  fIm2.Position.Z:=0;
  fIm2.Parent:=self;
  fIm2.Visible:=false;

  //Opacity:=0.85;
  if Width>600 then
  SectionHeight:=80 else
  SectionHeight:=50;

  aColGap:=2;
  aRowGap:=2;
  aButtonWidth:=aWidth/4;//divide width by max keys in a row
  aButtonWidth:=aButtonWidth-(aColGap)-(aColGap/4);

  fMenuMat.FontSize:=32;

  ah:=Height / (6);// devide height by number of rows..
  SectionHeight:=ah;
  SectionHeight:=SectionHeight-(aRowGap)-(aRowGap/6);

if SectionHeight>(aButtonWidth+aColGap) then
   begin
     ah:=SectionHeight-(aButtonWidth+aColGap);
     SectionHeight:=SectionHeight-(ah/2);
   end;


//change font size..
  if SectionHeight>79 then
    begin
     fMenuMat.FontSize:=32;
    end else
    begin
      fMenuMat.FontSize:=24;
    end;

  if SectionHeight>100 then
     begin
     fMenuMat.FontSize:=36;
     end;




   SetLength(fKeys,15);


   newy:=((aHeight/2)*-1)+(SectionHeight/2)+aRowGap;//top
   newx:=((aWidth/2)*-1)+(aButtonWidth/2)+aColGap;//left

  for I := Low(fKeys) to High(fKeys) do
   begin
    fKeys[i]:=TDlgButton.Create(self,aButtonwidth,SectionHeight,newx,newy);
    fKeys[i].Projection:=TProjection.Screen;
    fKeys[i].Parent:=self;
    fkeys[i].Tag:=i;
    fkeys[i].MaterialSource:=fMenuMat.Buttons.Rect;
    fKeys[i].TextColor:=fMenuMat.Buttons.TextColor.Color;
    fKeys[i].FontSize:=fMenuMat.FontSize;
    //back up the texture, we be drawing our own text for awhile.. :(
    fKeys[i].BtnBitMap.Assign(fMenuMat.Buttons.Rect.Texture);
    fkeys[i].Text:=GetKeyText(0,i);//default 1st menu
    fKeys[i].Opacity:=0.85;
    if not (i in [0,4,7]) then
       fKeys[i].OnClick:=btnClick;

    if i in [3,6,10] then
     begin
      newx:=newx+aButtonWidth+aColGap;
      newy:=((aHeight/2)*-1)+(SectionHeight/2)+aRowGap;//top
     end else
       newy:=newy+SectionHeight+aRowGap;

    if {(i=13) or} (i=2) then newy:=newy+(SectionHeight*2)+(aRowGap*2);//move close to the bottom
    end;


end;


//clean up..
destructor TDlgMenu.Destroy;
var
temp:TComponent;
i:integer;
begin
  try
   if not fCleanedUp then CleanUp;
  finally
   inherited;
  end;
end;

procedure TDlgMenu.CleanUp;
var
temp:TComponent;
i:integer;
begin

    if fCleanedUp then Exit;


  try
   //all the buttons
     for I := Low(fKeys) to High(fKeys) do
     begin
        fKeys[i].OnClick:=nil;
        fKeys[i].CleanUp;
        fKeys[i].Free;
        fKeys[i]:=nil;
     end;

   SetLength(fKeys,0);
   fKeys:=nil;

   if Assigned(fImAni) then
    begin
    fImAni.Stop;
    fImAni.Enabled:=false;
    fImAni.Free;
    end;

   if Assigned(fImFa1) then
    begin
    fImFa1.Stop;
    fImFa1.Enabled:=false;
    fImFa1.Free;
    end;

   if Assigned(fImFa2) then
    begin
    fImFa2.Stop;
    fImFa2.Enabled:=false;
    fImFa2.Free;
    end;



   fIm.Parent:=nil;
   fIm.Bitmap:=nil;
   fIm.Free;
   fIm:=nil;

   fIm2.Parent:=nil;
   fIm2.Bitmap:=nil;
   fIm2.Free;
   fIm2:=nil;

   fMenuSelect:=nil;

    fMenuMat:=nil;
    Parent:=nil;

  finally
   fCleanedUp:=true;
  end;
end;





procedure TDlgMenu.SetAniType(aValue: Byte);
begin
 if aValue>3 then exit;
 if aValue=fAniType then exit;

    StopAni;
    fAniType:=aValue;


end;

procedure TDlgMenu.StartAni;
begin
//start animations
              if fAniType=1 then
               begin

                 if not Assigned(fImFa1) then
                  begin
                  fIm2.Bitmap.Assign(fMenuMat.BackImage);
                  fIm2.Bitmap.FlipHorizontal;//magic
                  fim.Position.X:=0;
                  //im 2 just off screen
                  fim2.Position.X:=Width;
                  fim2.Visible:=true;
                  end;

                if not Assigned(fImFa1) then
                  begin
                  fImFa1:=TFloatAnimation.Create(self);
                  fImFa1.OnFinish:=fa1SlideImFinished;
                  fImFa1.StartFromCurrent:=true;
                  fImFa1.Parent:=fIm;
                  fImFa1.Duration:=120;
                  fImFa1.PropertyName:='Position.X';
                  fImFa1.StartValue:=0;
                  fImFa1.StopValue:=Width*-1;
                  fImFa1.Enabled:=true;
                  end else
                     fImFa1.Pause:=false;

                  if not Assigned(fImFa2) then
                    begin
                    fImFa2:=TFloatAnimation.Create(self);
                    fImFa2.OnFinish:=fa2SlideImFinished;
                    fImFa2.StartFromCurrent:=true;
                    fImFa2.Parent:=fim2;
                    fImFa2.Duration:=120;
                    fImFa2.PropertyName:='Position.X';
                    fImFa2.StartValue:=Width;
                    fImFa2.StopValue:=0;
                    fImFa2.Enabled:=true;
                    end else
                         fImFa2.Pause:=false;

               end else
               if fAniType=2 then
                 begin
                  if not Assigned(fImAni) then
                    begin
                    fim.Position.X:=0;
                    //im 2 just off screen
                    fim2.Position.X:=Width;
                    fim2.Visible:=False;
                    fImAni:=TBitmapAnimation.Create(fim);
                    fImAni.Enabled:=false;
                    fImAni.StartValue.Assign(fMenuMat.BackImage);
                    fImAni.StopValue.Assign(fMenuMat.BackImage);
                    fImAni.StopValue.FlipHorizontal;//magic
                    fImAni.PropertyName:='Bitmap';
                    fImAni.Duration:=10;
                    fImAni.Loop:=true;
                    fImAni.AutoReverse:=true;
                    fImAni.Parent:=fim;
                    fImAni.Enabled:=true;
                    end else
                      fImAni.Pause:=false;

                 end else
                   if fAniType = 3 then
                 begin

                   if not Assigned(fImFa1) then
                   begin
                     fIm2.Bitmap.Assign(fMenuMat.BackImage);
                     fIm2.Bitmap.FlipVertical; // magic
                     fIm2.Height:=Height;
                     fIm.Height:=Height;
                     fIm.Position.X := 0;
                     fIm.Position.Y := 0;
                     // im 2 just off screen
                     fIm2.Position.Y := ((Height) * -1);
                     fIm2.Position.X := 0;
                     fIm2.Visible := true;
                   end;

                   if not Assigned(fImFa1) then
                   begin
                     fImFa1 := TFloatAnimation.Create(self);
                     fImFa1.OnFinish := fa1SlideImFinished;
                     fImFa1.StartFromCurrent := true;
                     fImFa1.Parent := fIm;
                     fImFa1.Duration := 30;
                     fImFa1.PropertyName := 'Position.Y';
                     fImFa1.StartValue :=0;
                     fImFa1.StopValue := Height;// + (Height / 2);
                   end
                   else
                     fImFa1.Pause := false;

                   if not Assigned(fImFa2) then
                   begin
                     fImFa2 := TFloatAnimation.Create(self);
                     fImFa2.OnFinish := fa2SlideImFinished;
                     fImFa2.StartFromCurrent := true;
                     fImFa2.Parent := fIm2;
                     fImFa2.Duration := 30;
                     fImFa2.PropertyName := 'Position.Y';
                     fImFa2.StartValue := ((Height) * -1);
                     fImFa2.StopValue :=0;
                     fImFa2.Enabled := true;
                     fImFa1.Enabled := true;
                   end
                   else
                     fImFa2.Pause := false;


                 end;







end;

procedure TDlgMenu.StopAni;
begin
  //stop animations
  if fAniType in [1,3] then
    begin
     if Assigned(fImfa1) then
      fImFa1.Pause:=true;
     if Assigned(fImfa2) then
      fImFa2.Pause:=true;
    end else
      if fAniType=2 then
      begin
       if Assigned(fImAni) then
         fImAni.Pause:=true;
      end;



end;



procedure TDlgMenu.fa1SlideImFinished(Sender: TObject);
begin
// fa slide im1
       if fAniType=1 then
         begin
               //right to left
               if fImFa1.tag=1 then
                begin
                fImFa1.Tag:=0;
                fim.Position.X:=0;
                fImFa1.StartValue:=0;
                fImFa1.StopValue:=Width*-1;
                fImFa1.Enabled:=true;
                fImFa1.Start;
               end else
                  begin
                   fImFa1.Tag:=1;
                   fIm.Position.X:=Width;
                   fImFa1.StartValue:=Width;
                   fImFa1.StopValue:=0;
                   fImFa1.Enabled:=true;
                   fImFa1.Start;
                  end;
         end else
            begin
                 //top to bottom
               if fImFa1.tag=0 then
                begin
                fImFa1.Tag:=1;
                fim.Position.Y:=(Height)*-1;
                fImFa1.StartValue:=(Height)*-1;
                fImFa1.StopValue:=0;
               // fImFa1.Enabled:=true;
                fImFa1.Start;
               end else
                  begin
                   fImFa1.Tag:=0;
                   fim.Position.Y:=0;
                   fImFa1.StartValue:=0;
                   fImFa1.StopValue:=Height;//+(Height/2);
                  // fImFa1.Enabled:=true;
                   fImFa1.Start;
                  end;

            end;

end;

procedure TDlgMenu.fa2SlideImFinished(Sender: TObject);
begin
// fa slide im2
        if fAniType=1 then
          begin
               //right to left
               if fImFa2.tag=0 then
                begin
                fImFa2.Tag:=1;
                fim2.Position.X:=0;
                fImFa2.StartValue:=0;
                fImFa2.StopValue:=Width*-1;
                fImFa2.Enabled:=true;
                fImFa2.Start;
               end else
                  begin
                   fImFa2.Tag:=0;
                   fim2.Position.X:=Width;
                   fImFa2.StartValue:=Width;
                   fImFa2.StopValue:=0;
                   fImFa2.Enabled:=true;
                   fImFa2.Start;
                  end;
          end else
             begin
                 //top to bottom
               if fImFa2.tag=0 then
                begin
                fImFa2.Tag:=1;
                fim2.Position.Y:=0;
                fImFa2.StartValue:=0;
                fImFa2.StopValue:=Height;//+(Height/2);
               // fImFa2.Enabled:=true;
                fImFa2.Start;
               end else
                  begin
                   fImFa2.Tag:=0;
                   fim2.Position.Y:=((Height)*-1);
                   fImFa2.StartValue:=((Height)*-1);//minus 2 gets rid of black line
                   fImFa2.StopValue:=0;
                   //fImFa2.Enabled:=true;
                   fImFa2.Start;
                  end;

             end;

end;








procedure TDlgMenu.btnClick(sender: TObject);
var
aBtnNum:integer;
begin
aBtnNum:=0;
  //we got a click event..
  if sender is TRectangle3d then
     aBtnNum:=TRectangle3d(sender).Tag;


  if assigned(fMenuSelect) then
      fMenuSelect(sender,aBtnNum);
end;



//get and sets the menu button
procedure TDlgMenu.SetKey(aKeyNum: Integer; value: TDlgButton);
begin
if aKeyNum>High(fKeys) then exit;//outa here
fKeys[aKeyNum]:=value;
end;

function TDlgMenu.GetKey(aKeyNum: Integer):TDlgButton;
begin
result:=nil;//nil the result
if aKeyNum>High(fKeys) then exit;//outa here
result:=fKeys[aKeyNum];
end;



function TDlgMenu.GetKeyText(aMenu,keyNum:integer):string;
begin



  result:='';

  case keyNum of
  0:result:='Scenes';
  1:result:='Borg';
  2:result:='Complex';
  3:result:='Close';
  4:result:='Dialogs';
  5:result:='Confirm';
  6:result:='Info';
  7:result:='Inputs';
  8:result:='Get Num';
  9:result:='Quick Pick';
  10:result:='Get Str';
  11:result:='Purple Clouds';
  12:result:='Dark Matter';
  13:result:='Blue Falls';
  14:result:='Arora';
  end;
end;

procedure TDlgMenu.ChangeText(aValue: Integer);
var
  i,j:integer;
begin

       j:=aValue*10;

       for I := Low(fKeys) to High(fkeys) do
        begin
         if not (i in[3,14]) then
          begin
           fkeys[i].Text:=IntToStr(j);
           inc(j);
          end;
        end;
end;







end.
