{ Unit contaiing functions for making bitmaps..

  Created: 1.16.22 -dm

  be it harm none, do as ye wishes..


}
unit uDlg3dTextures;

interface

uses
  System.SysUtils, System.Classes,System.Types, FMX.MaterialSources,System.UIConsts,System.UITypes, FMX.Types,FMX.Graphics ,
  uInertiaTimer,uDlg3dCtrls;


    function MakeDlgBackGrnd(aWidth:single;aHeight:single;aColor:byte;aBorder:byte;aCorner:byte):tBitmap;
    function MakeTexture(aWidth:single;aHeight:single;aColor:byte;aBorder:byte;bColor:byte;aCorner:byte):tBitmap;
    function MakeBrush(aColor:byte):tBrush;





implementation


//make my brushes.. completely crazy, like me, so i wrote them down.. :)
function MakeBrush(aColor: Byte): TBrush;
var
aBrush:tBrush;
fColor:tAlphaColorRec;
begin
  aBrush:=TBrush.Create(TBrushKind.Gradient,claMistyRose);
  aBrush.Kind:=TBrushKind.Gradient;
  aBrush.Gradient.StartPosition.Y:=0;
  aBrush.Gradient.StopPosition.Y:=1;
  aBrush.Gradient.Style:=tGradientStyle.Linear;

  case aColor of
    0:
      begin
        // Purple
        // purple start
        fColor := TAlphaColorRec.Create(claMistyRose);
        fColor.R := 180;
        fColor.G := 170;
        fColor.B := 220;
        aBrush.Gradient.Color := fColor.Color;
        // puple end
        fColor.R := 105;
        fColor.G := 80;
        fColor.B := 168;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    1:
      begin
        // Black-Dark Blue
        // start
        aBrush.Gradient.Color := claBlack;
        // end
        fColor := TAlphaColorRec.Create(claMidNightBlue);
        fColor.R := 7;
        fColor.G := 54;
        fColor.B := 100;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    2:
      begin
        // Black-Red
        // Black-Red start
        fColor := TAlphaColorRec.Create(claBlack);
        aBrush.Gradient.Color := fColor.Color;
        // Black-Red end
        fColor.R := 126;
        fColor.G := 16;
        fColor.B := 16;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    3:
      begin
        // Light Blue
        // Light BLue start
        fColor := TAlphaColorRec.Create(claBLue);
        fColor.R := 157;
        fColor.G := 196;
        fColor.B := 231;
        aBrush.Gradient.Color := fColor.Color;
        // Light Blue end
        fColor.R := 62;
        fColor.G := 133;
        fColor.B := 198;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    4:
      begin
        // Red White
        // Red White start
        fColor := TAlphaColorRec.Create(claBLue);
        fColor.R := 234;
        fColor.G := 151;
        fColor.B := 151;
        aBrush.Gradient.Color := fColor.Color;
        // Red White end
        fColor.R := 205;
        fColor.G := 6;
        fColor.B := 6;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    5:
      begin
        // Yelloq White
        // Yellow White start
        fColor := TAlphaColorRec.Create(claYellow);
        fColor.R := 255;
        fColor.G := 242;
        fColor.B := 200;
        aBrush.Gradient.Color := fColor.Color;
        // Yellow White end
        fColor.R := 255;
        fColor.G := 255;
        fColor.B := 6;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    6:
      begin
        // Green White
        // Green White start
        fColor := TAlphaColorRec.Create(claGreen);
        fColor.R := 181;
        fColor.G := 214;
        fColor.B := 167;
        aBrush.Gradient.Color := fColor.Color;
        // Green White end
        fColor.R := 57;
        fColor.G := 113;
        fColor.B := 30;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    7:
      begin
        // Grey White
        // Grey White start
        fColor := TAlphaColorRec.Create(claGrey);
        fColor.R := 238;
        fColor.G := 238;
        fColor.B := 238;
        aBrush.Gradient.Color := fColor.Color;
        // Grey White end
        fColor.R := 106;
        fColor.G := 106;
        fColor.B := 106;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    8:
      begin
        // Orange
        // Orange start
        fColor := TAlphaColorRec.Create(claGrey);
        fColor.R := 234;
        fColor.G := 83;
        fColor.B := 2;
        aBrush.Gradient.Color := fColor.Color;
        // Orange end
        fColor.R := 176;
        fColor.G := 0;
        fColor.B := 0;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    9:
      begin
        // Black
        //Blackstart
        fColor := TAlphaColorRec.Create(claGrey);
        fColor.R := 0;
        fColor.G := 0;
        fColor.B := 0;
        aBrush.Gradient.Color := fColor.Color;
        // Black End
        fColor.R := 25;
        fColor.G := 25;
        fColor.B := 25;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    10:
      begin
        // dark purple
        //dark purple
        fColor := TAlphaColorRec.Create(claGrey);
        fColor.R := 207;
        fColor.G := 164;
        fColor.B := 244;
        aBrush.Gradient.Color := fColor.Color;
        // Black End
        fColor.R := 61;
        fColor.G := 10;
        fColor.B := 104;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    11:
      begin
        // dark Blue ab
        //dark blue abs
        fColor := TAlphaColorRec.Create(claGrey);
        fColor.R := 132;
        fColor.G := 192;
        fColor.B := 220;
        aBrush.Gradient.Color := fColor.Color;
        // blue ab
        fColor.R := 53;
        fColor.G := 131;
        fColor.B := 169;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    12:
      begin
        // dark color wave
        //dark color wave
        fColor := TAlphaColorRec.Create(claGrey);
        fColor.R := 92;
        fColor.G := 173;
        fColor.B := 166;
        aBrush.Gradient.Color := fColor.Color;
        //
        fColor.R := 36;
        fColor.G := 93;
        fColor.B := 136;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    13:
      begin
        // Green Abs
        //d
        fColor := TAlphaColorRec.Create(claGrey);
        fColor.R := 73;
        fColor.G := 170;
        fColor.B := 80;//63;
        aBrush.Gradient.Color := fColor.Color;
        //
        fColor.R := 8;
        fColor.G := 147;
        fColor.B := 82;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    14:
      begin
        // bricks
        //d
        fColor := TAlphaColorRec.Create(claGrey);
        fColor.R := 78;
        fColor.G := 71;
        fColor.B := 63;
        aBrush.Gradient.Color := fColor.Color;
        //
        fColor.R := 39;
        fColor.G := 35;
        fColor.B := 26;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    15:
      begin
        // orange
        //d
        fColor := TAlphaColorRec.Create(claGrey);
        fColor.R := 149;
        fColor.G := 1;
        fColor.B := 1;
        aBrush.Gradient.Color := fColor.Color;
        //
        fColor.R := 115;
        fColor.G := 0;
        fColor.B := 0;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    16:
      begin
        // dark blue ab
        //d
        fColor := TAlphaColorRec.Create(claGrey);
        fColor.R := 2;
        fColor.G := 2;
        fColor.B := 10;
        aBrush.Gradient.Color := fColor.Color;
        //
        fColor.R := 8;
        fColor.G := 40;
        fColor.B := 97;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    17:
      begin
        // Black
        //d
        fColor := TAlphaColorRec.Create(claBlack);
        aBrush.Gradient.Color := fColor.Color;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    18:
      begin
        // White
        //d
        fColor := TAlphaColorRec.Create(claWhite);
        aBrush.Gradient.Color := fColor.Color;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
    19:
      begin
        // Red
        //d
        fColor := TAlphaColorRec.Create(claRed);
        aBrush.Gradient.Color := fColor.Color;
        aBrush.Gradient.Color1 := fColor.Color;
      end;
  end;

   result:=aBrush;

end;




//make a bitmap scaled using current screen scale..
function MakeTexture(aWidth:single;aHeight:single;aColor:byte;aBorder:byte;bColor:byte;aCorner:byte):tBitmap;
var
  tmpBitmap:tBitmap;
  aRect,bRect:TRectF;
  aBrush:TBrush;
  bBrush:TBrush;
  fColor:TAlphaColorRec;
  aColGap,aRowGap,nCorner:single;
 aScale:single;
begin

  result:=tBitmap.Create;


    aScale:=CurrentScale;
  if aScale<>1 then
    begin
    aWidth:=Trunc(aWidth*aScale);
    aHeight:=Trunc(aHeight*aScale);
    if aBorder>0 then
      aBorder:=Trunc(aBorder*aScale);
    end;


  //corner should be adjusted by the size
  if aCorner>0 then
    begin
     if aWidth>aHeight then
      begin
       nCorner:=aHeight*0.20;
      end else
        begin
        nCorner:=aWidth*0.20;
        end;
    end
     else nCorner:=0;

if aCorner<nCorner then nCorner:=aCorner;


 bBrush:=MakeBrush(bColor);
 aBrush:=MakeBrush(aColor);


  bRect:=TRectF.Create(0,0,Trunc(aWidth),Trunc(aHeight));
  aRect:=TRectF.Create(0,0,Trunc(aWidth),Trunc(aHeight));

  tmpBitmap:=tBitmap.Create(Trunc(aWidth),Trunc(aHeight));
  tmpBitmap.Clear(claNull);

  tmpBitmap.Canvas.BeginScene;
 if aBorder>0 then
    begin
    tmpBitmap.Canvas.FillRect(aRect,nCorner,nCorner,AllCorners,1,bBrush,TCornerType.Round);
     aRect.Left:=aBorder;
     aRect.Top:=aBorder;
     aRect.Right:=Trunc(aWidth-(aBorder));
     aRect.Bottom:=Trunc(aHeight-(aBorder));
    end;
  tmpBitmap.Canvas.FillRect(aRect,nCorner,nCorner,AllCorners,1,aBrush,TCornerType.Round);
  tmpBitmap.Canvas.EndScene;
  result.Assign(tmpBitmap);
  tmpBitmap.Free;
  aBrush.Free;
  bBrush.Free;
end;






//make backgrounds for pop-up dialogs..
function MakeDlgBackGrnd(aWidth:single;aHeight:single;aColor:byte;aBorder:byte;aCorner:byte):tBitmap;
var
  tmpBitmap:tBitmap;
  aRect:TRectF;
  aBrush:TBrush;
  bBrush:TBrush;
  fColor:TAlphaColorRec;
  aColGap,aRowGap:single;
begin

  result:=tBitmap.Create;

  if aBorder=0 then aBorder:=6;



  aBrush:=TBrush.Create(TBrushKind.Bitmap,claNull);
  aBrush.Kind:=TBrushKind.Bitmap;
  aBrush.Bitmap.WrapMode:=TWrapMode.TileStretch;

  aBrush.Bitmap.Bitmap.Assign(DlgMaterial.BackImage);

  {
  case CurrentTheme of
  0:aColor:=1;
  1:aColor:=3;
  2:aColor:=1;
  3:aColor:=3;
  4:aColor:=3;
  5:aColor:=0;
  6:aColor:=3;
  7:aColor:=3;
  8:aColor:=7;
  9:aColor:=7;
  10:aColor:=9;
  11:aColor:=0;
  12:aColor:=3;
  13:aColor:=3;
  14:aColor:=0;
  15:aColor:=6;
  16:aColor:=1;
  17:aColor:=7;
  18:aColor:=8;
  19:aColor:=0;

  end;

    }

   bBrush:=MakeBrush(aColor);



  aRect:=TRectF.Create(0,0,Trunc(aWidth),Trunc(aHeight));
  tmpBitmap:=tBitmap.Create(Trunc(aWidth),Trunc(aHeight));
  tmpBitmap.Clear(claNull);
  tmpBitmap.Canvas.BeginScene;
  tmpBitmap.Canvas.FillRect(aRect,aCorner,aCorner,AllCorners,0.90,bBrush,TCornerType.Round);
  aRect.Top:=aBorder;
  aRect.Left:=aBorder;
  aRect.Width:=Trunc(aWidth)-(aBorder*2);
  aRect.Height:=Trunc(aHeight)-(aBorder*2);

  tmpBitmap.Canvas.FillRect(aRect,aCorner,aCorner,AllCorners,0.90,aBrush,TCornerType.Round);
  tmpBitmap.Canvas.EndScene;
  result.Assign(tmpBitmap);
  tmpBitmap.Free;
  aBrush.Free;
  bBrush.Free;
end;





end.
