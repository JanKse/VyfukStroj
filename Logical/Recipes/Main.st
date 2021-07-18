
PROGRAM _INIT
	(* Insert code here *)

	UISetup.RecipeListSize := 5;
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	
	
	gDoHeatingZone1;
	MpRecipeXml_0.MpLink := ADR(gRecipeXml);
	MpRecipeXml_0.Enable := TRUE;
	MpRecipeXml_0.DeviceName := ADR('Recipe');
	MpRecipeXml_0.FileName := ADR('test2');
	gRecipeLoaded := UDINT_TO_BOOL(MpRecipeXml_0.Info.FileSize); // check if Recipe is loaded (If not lenght = 0)
	
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
	
	RecipeUI.Enable := TRUE;
	RecipeUI.MpLink := ADR(gRecipeXml);
	RecipeUI.UISetup :=UISetup;
	RecipeUI.UIConnect := ADR(UIConnect);
	
	MpRecipeXml_0();
	MpRecipeRegParTemperatures();
	MpRecipeRegParTimers();
	RecipeUI();
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

