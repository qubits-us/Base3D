program Base3d;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmMain in 'ufrmMain.pas' {MainFrm},
  dmMaterials in 'dmMaterials.pas' {MaterialsDm: TDataModule},
  uScene3dMenu in 'uScene3dMenu.pas',
  uWorldAniDlg in 'uWorldAniDlg.pas',
  uBorgTestDlg in 'uBorgTestDlg.pas',
  uCommon3dDlgs in '..\common\uCommon3dDlgs.pas',
  uDlg3dCtrls in '..\common\uDlg3dCtrls.pas',
  uKeyboardDlg in '..\common\uKeyboardDlg.pas',
  uNumPadDlg in '..\common\uNumPadDlg.pas',
  uNumSelectDlg in '..\common\uNumSelectDlg.pas',
  uInertiaTimer in '..\common\uInertiaTimer.pas',
  uDlg3dTextures in '..\common\uDlg3dTextures.pas',
  uGlobs in 'uGlobs.pas',
  uComplexDlg in 'uComplexDlg.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Landscape];
  Application.CreateForm(TMainFrm, MainFrm);
  Application.Run;
end.
