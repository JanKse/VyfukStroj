
PROGRAM _INIT
	(* Insert code here *)
	gSetTemperatures.temperatureHeatZone1 := 10;
	gSetTemperatures.temperatureHeatZone2 := 20;
	gSetTemperatures.temperatureHeatZone3 := 30;
	gSetTemperatures.temperatureIRSensor :=40;
	
	gSetTimersValues.BlowingTOFValue :=10;
	gSetTimersValues.BlowingTONValue := 5;
	gSetTimersValues.BubbleTOFValue :=1;
	gSetTimersValues.FormingTONValue :=2;
	gSetTimersValues.FormLockingTONValue :=10;
	gSetTimersValues.HeatingTOFValue := 1;
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	MpRecipeXml_0.MpLink := ADR(gRecipeXml);
	MpRecipeXml_0.Enable := TRUE;
	MpRecipeXml_0.DeviceName := ADR('Recipe');
	MpRecipeXml_0.FileName := ADR('test');
	MpRecipeXml_0.Load := cmdLoadRecipes;
	MpRecipeXml_0.Save := cmdSaveRecipes;
	MpRecipeXml_0.ErrorReset := cmdErrorReset;
	
	MpRecipeRegParTemperatures.MpLink := ADR(gRecipeXml);
	MpRecipeRegParTemperatures.Enable := MpRecipeXml_0.Active;
	MpRecipeRegParTemperatures.ErrorReset := cmdErrorReset;
	MpRecipeRegParTemperatures.Category := ADR('Temperatures');
	MpRecipeRegParTemperatures.PVName := ADR('gSetTemperatures');
	
	MpRecipeRegParTimers.MpLink := ADR(gRecipeXml);
	MpRecipeRegParTimers.Enable := MpRecipeXml_0.Active;
	MpRecipeRegParTimers.ErrorReset := cmdErrorReset;
	MpRecipeRegParTimers.Category := ADR('Timers');
	MpRecipeRegParTimers.PVName := ADR('gSetTimersValues');
	
	MpRecipeXml_0();
	MpRecipeRegParTemperatures();
	MpRecipeRegParTimers();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

