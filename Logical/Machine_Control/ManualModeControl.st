
ACTION ManualModeControl: 
	IF gDiFrameDownPosition = TRUE THEN
		cmdHeating;
		gDoHeating := cmdHeating;
	ELSIF gDiFrameUpPoistion = TRUE THEN
		cmdHeating := FALSE;
		gDoHeating := cmdHeating;
	END_IF;
	
	IF gDiHeatingBack = TRUE THEN //topení vzadu
		cmdFormUp;
		cmdFrameDown;
		cmdFrameUp;
		gDoFormUp := cmdFormUp;
		gDoFrameDown := cmdFrameDown;
		gDoFrameUp := cmdFrameUp;
	ELSIF gDiHeatingFront = TRUE THEN
		cmdFormUp := FALSE;
		cmdFrameDown := FALSE;
		cmdFrameUp := FALSE;
	END_IF;
	IF (gDiFrameDownPosition = TRUE) AND (gDiFormUpPosition = TRUE) THEN
		cmdHeating := FALSE;
		gDoHeating := cmdHeating;
	END_IF;
	
	gDoFreeItem := cmdFreeItem;
	gDoMaterial := cmdMaterial;
	gDoAirPump := cmdAirPump;
	gDoCooling := cmdCooling;
	gDoHeatingZone1 := cmdHeatingZone1;
	gDoHeatingZone2 := cmdHeatingZone2;
	gDoHeatingZone3 := cmdHeatingZone3;
	IF gDoAirPump = TRUE THEN
		gDoVacuum := cmdVacuum;
	END_IF
END_ACTION
