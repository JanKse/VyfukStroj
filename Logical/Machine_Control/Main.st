
PROGRAM _INIT
	
	//At beginning of cyclus turn everything off
	
	cmdAirPump	:= FALSE;
	cmdCooling	:= FALSE;
	cmdFrameDown:= FALSE;
	cmdFrameUp	:= FALSE;
	cmdFreeItem	:= FALSE;
	cmdHeating 	:= FALSE;
	cmdMaterial := FALSE;
	cmdVacuum	:= FALSE;
	cmdFormUp 	:= FALSE;
	
	gDoAirPump := cmdAirPump;
	gDoCooling := cmdCooling;
	gDoFormUp := cmdFormUp;
	gDoFrameDown := cmdFrameDown;
	gDoFrameUp := cmdFrameUp;
	gDoFreeItem := cmdFreeItem;
	gDoHeatingZone1 := cmdHeating;
	gDoHeatingZone2 := cmdHeating;
	gDoHeatingZone3 := cmdHeating;
	gDoMaterial := cmdMaterial;
	gDoVacuum := cmdVacuum;
 	//------------------------------------------------------------------------------------------------
	//Start state of cyclus
	gStateOfProcess := DefaultState;
	//--------------------------------------------------------------------------------------------
	
	gAVGTemperature := 100;     	// 
	gSetTemperatures.defaultTemperatureValue := 100;	//
END_PROGRAM

PROGRAM _CYCLIC
	
	CASE gStateOfProcess OF
		DefaultState :
			//Manual mode
			cmdAirPump;
			cmdCooling;
		    cmdFormUp;
			cmdFrameDown;
			cmdFrameUp;
			cmdFreeItem;
			cmdMaterial;
			cmdVacuum;
			//--------------------------------------------------------------
			IF (gRecipeLoaded = TRUE )THEN
				cmdAirPump := gDiButtonStart;
				cmdFrameDown := gDiButtonStart;
				IF (gDiButtonStart = TRUE) AND (gDiFrameDownPosition = TRUE) THEN
					gStateOfProcess := Start;
				END_IF;
			END_IF;		
		Start:
			cmdHeating := TRUE;
			//cmdFrameDown :=TRUE / FALSE;
			//cmdAirPump := TRUE  / FALSE;
			TOFHeating.IN := EDGEPOS(cmdHeating);
			TOFHeating.PT := REAL_TO_TIME(gSetTimersValues.HeatingTOFValue * 1000);
			TOFHeating();
			
			cmdHeating := TOFHeating.Q;
			
			IF (gDiHeatingHigh = TRUE) THEN
				cmdMaterial := TRUE;
				IF gSetTimersValues.BlowingTONValue <> 0 THEN
					TONBlowing.IN := cmdMaterial;
					TONBlowing.PT := REAL_TO_TIME(gSetTimersValues.BlowingTONValue * 1000);
					TONBlowing();
				
					TOFBlowing.IN := EDGEPOS(TONBlowing.Q);
					TOFBlowing.PT := REAL_TO_TIME(gSetTimersValues.BlowingTONValue * 1000);
					TOFBlowing();
					cmdBubble := TOFBlowing.Q;
				END_IF;	
				
				IF (TOFHeating.PT = TOFHeating.ET) AND (TOFBlowing.PT = TOFBlowing.ET) THEN
					cmdHeating := FALSE;
					gStateOfProcess := BubbleANDFormDownDelay;
				END_IF;
			END_IF;
		
		BubbleANDFormDownDelay : 
		
	END_CASE;
	
	gDoAirPump := cmdAirPump;
	gDoCooling := cmdCooling;
	gDoFormUp := cmdFormUp;
	gDoFrameDown := cmdFrameDown;
	gDoFrameUp := cmdFrameUp;
	gDoFreeItem := cmdFreeItem;
	gDoHeatingZone1 := cmdHeating;
	gDoHeatingZone2 := cmdHeating;
	gDoHeatingZone3 := cmdHeating;
	gDoMaterial := cmdMaterial;
	gDoVacuum := cmdVacuum;
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

