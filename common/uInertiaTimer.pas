{Threaded Timer
  10.22.2021 -dm

  be it harm none, do as ye wishes..
}

unit uInertiaTimer;


interface


uses Classes,System.SysUtils, System.Generics.Collections, System.SyncObjs,System.UITypes,FMX.Types;




type
  TInertiaTimer_Event  = procedure (Sender:TObject) of object;


   type
      tInertiaTimerThread = class(TThread)
        private
         fCrit:tCriticalSection;
         fInterval:word;
         fEnabled:boolean;
         fTimerEvent:tInertiaTimer_Event;
         fPausedEvent:TEvent;
         fTickEvent:tEvent;
        protected
         procedure SetEnabled(aValue:boolean);
         procedure SetInterval(aValue:word);
         procedure DoInterval;
         procedure Execute;override;
        public
         Constructor Create(aCrit:TCriticalSection);
         destructor  Destroy;override;
         property    OnTimer:tInertiaTimer_Event read fTimerEvent write fTimerEvent;
         property    Interval:word read fInterval write SetInterval;
         property    Enabled:boolean read fEnabled write SetEnabled;
      end;


    tInertiaTimer= class(tObject)
        private
         fCrit:TCriticalSection;
         fTimerThrd:tInertiaTimerThread;
         fInterval:word;
         fEnabled:boolean;
         fTimerEvent:tInertiaTimer_Event;
        protected
         procedure SetInterval(aValue:word);
         procedure SetEnabled(aValue:boolean);
         procedure OnThrdTimer(sender:tObject);
         procedure DoTimer;
        public
         constructor Create;
         destructor  Destroy;override;
         property    OnTimer:tInertiaTimer_Event read fTimerEvent write fTimerEvent;
         property    Interval:word read fInterval write SetInterval;
         property    Enabled:boolean read fEnabled write SetEnabled;
    end;



implementation




constructor TInertiaTimerThread.Create(aCrit:TCriticalSection);
var
i:integer;
begin
  fCrit:=aCrit;
  fEnabled:=False;
  fInterval:=1000;//1 second
  fTickEvent:=tEvent.Create(nil,true,false,'');
  fPausedEvent:=tEvent.Create(nil,true, false,'');
  inherited Create(false);
end;


destructor TInertiaTimerThread.Destroy;
begin

  Terminate;
  fPausedEvent.SetEvent;
  fTickEvent.SetEvent;
  if Started then WaitFor;
  fPausedEvent.Free;
  fTickEvent.Free;

  fCrit:=nil;//just nil we dont own it

  inherited;
end;




procedure TInertiaTimerThread.Execute;
var
aInterval:word;
begin
  while not Terminated do
     begin

       //sit here if not enabled
       fPausedEvent.WaitFor(INFINITE);//pause
       if Terminated then exit;

         fCrit.Enter;
         try
         aInterval:=fInterval;
         finally
         fCrit.Leave;
         end;

       //if we time out then fire off..
      if fTickEvent.WaitFor(aInterval)= wrTimeOut then
      begin
       if Terminated then exit;
       fPausedEvent.WaitFor(INFINITE);//todo: not right replace with if and test
       if Terminated then exit;
          if Assigned(fTimerEvent) then
            Synchronize(DoInterval);
      end;
     end;
end;

procedure TInertiaTimerThread.DoInterval;
begin
  if assigned(fTimerEvent) then
         fTimerEvent(nil);
end;


procedure TInertiaTimerThread.SetEnabled(aValue: Boolean);
begin
if aValue=fEnabled then exit;//nothing to do


fCrit.Enter;
try
  fEnabled:=aValue;

     if fEnabled then
        begin
          fTickEvent.ResetEvent;
          fPausedEvent.SetEvent;
          end else
          begin
          fPausedEvent.ResetEvent;
          fTickEvent.SetEvent;
          end;

finally
  fCrit.Leave;
end;


end;


procedure TInertiaTimerThread.SetInterval(aValue: Word);
begin
  if aValue<10 then aValue:=10;
   fCrit.Enter;
   try
    if aValue<>fInterval then
      begin
        fInterval:=aValue;
      end;

   finally
     fCrit.Leave;
   end;


end;


constructor TInertiaTimer.Create;
begin
  Inherited Create;

  fCrit:=tCriticalSection.Create;
  fEnabled:=false;
  fInterval:=1000;
  fTimerThrd:=TInertiaTimerThread.Create(fCrit);
  fTimerThrd.OnTimer:=OnThrdTimer;



end;

destructor TInertiaTimer.Destroy;
begin

 fTimerThrd.Free;
 fCrit.Free;

 Inherited;

end;

procedure TInertiaTimer.DoTimer;
begin
  if Assigned(fTimerEvent) then
      fTimerEvent(self);
end;

procedure TInertiaTimer.OnThrdTimer(sender: TObject);
begin
  DoTimer;
end;

procedure TInertiaTimer.SetEnabled(aValue: Boolean);
begin
  if fEnabled=aValue then exit;//
  fEnabled:=aValue;
     fTimerThrd.Enabled:=fEnabled;
end;

procedure TInertiaTimer.SetInterval(aValue: Word);
begin
  if fInterval=aValue then exit;
  if aValue<10 then aValue:=10;
  fInterval:=aValue;
     fTimerThrd.Interval:=fInterval;

end;

end.
