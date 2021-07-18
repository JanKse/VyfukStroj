
PROGRAM _INIT
	(* Insert code here *)
	 
END_PROGRAM

PROGRAM _CYCLIC
	
	IF gDoCooling THEN
		CoolingIconIndex := 4;
	ELSE
		CoolingIconIndex := 10;
	END_IF
	
	IF gDoAirPump THEN
		AirPumpIconIndex := 6;
	ELSE
		AirPumpIconIndex :=12;
	END_IF
	IF gDoHeatingZone1 THEN
		HeatingOnOfText1 := 1;
	ELSE
		HeatingOnOfText1 := 0;
	END_IF;
	IF gDoHeatingZone2 THEN
		HeatingOnOfText2 := 1;
	ELSE
		HeatingOnOfText2 := 0;
	END_IF;
	IF gDoHeatingZone3 THEN
		HeatingOnOfText3 := 1;
	ELSE
		HeatingOnOfText3 := 0;
	END_IF;
	IF gDoHeatingZone1 AND gDoHeatingZone2 AND gDoHeatingZone3 THEN
		HeatingZonesIconIndex := 7;
	ELSE
		HeatingZonesIconIndex := 13;
	END_IF
	
	IF gDoVacuum THEN
		VacuumIconIndex := 3;
	ELSE
		VacuumIconIndex := 9;
	END_IF
	
	IF gDoFreeItem THEN
		ItemIconIndex := 18;
	ELSE
		ItemIconIndex := 21;
	END_IF
	IF gDoFreeItem THEN
		ItemIconIndex := 18;
	ELSE
		ItemIconIndex := 21;
	END_IF
	
	IF gDoFormUp THEN
		FormUpIndex := 8;
	ELSE
		FormUpIndex := 14;
	END_IF
	
	IF gDoFrameDown THEN
		FrameDownIndex := 15;
	ELSE
		FrameDownIndex :=11;
	END_IF;
	
	IF gDoFrameUp THEN
		FrameUpIconIndex := 17;
	ELSE
		FrameUpIconIndex := 16;
	END_IF;
	
	IF gDoMaterial THEN
		MaterialIconIndex := 19;
	ELSE
		MaterialIconIndex := 20;
	END_IF;
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

