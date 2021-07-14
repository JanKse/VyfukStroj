
PROGRAM _INIT
	(* Insert code here *)
	doAirPump := FALSE;
	diStartButton := FALSE;
	diFrameLocked :=FALSE;
	diFormLocked := FALSE;
	doFormLocking := FALSE;
	doBlowing  := FALSE;
	doHeating := FALSE;
	FormLocking := FALSE;
	
	StateOfProcess := WaitForStartCommand;
	
	HeatingTOFValue := 10.0; 		// Time delay to turn off the heating
	BlowingTONValue := 20; 	 		// Time delay to turn on the blowing valve
	BlowingTOFValue := 2;    		//Duration of blowing air
	FormLockingTONValue := 5;  	//Time delay to turn on to form to locked position
	BubbleTOFValue := 5;
	FormingTONValue := 10;
	
	gAVGTemperature := 100;     	// 
	gDefaultTemperatureValue := 100;	//
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	CASE StateOfProcess OF
		WaitForStartCommand:
			IF (diStartButton=TRUE) AND (diFrameLocked=TRUE) THEN
				doAirPump := TRUE;
	  			StateOfProcess := Heating;
			END_IF;
		Heating: 
			doHeating := TRUE;
			TOFHeating.IN:=EDGEPOS(doHeating);
			TOFHeating.PT := REAL_TO_TIME(HeatingTOFValue * 1000);									 //Add HeatingZones
			TOFHeating();
			doHeating := TOFHeating.Q;	
			
			IF BlowingTOFValue <> 0 THEN
				TONBlowing.IN := NOT EDGEPOS(doHeating); 
				TONBlowing.PT := REAL_TO_TIME(BlowingTONValue * 1000);
				TONBlowing();
		
				TOFBlowing.IN := EDGEPOS(TONBlowing.Q);
				TOFBlowing.PT := REAL_TO_TIME(BlowingTOFValue * 1000);
				TOFBlowing();
				doBlowing := TOFBlowing.Q;
			END_IF;
			
			IF (TOFHeating.ET = TOFHeating.PT) AND (TOFBlowing.ET = TOFBlowing.PT) AND (doBlowing = FALSE) AND (doHeating = FALSE) THEN
	  			StateOfProcess := PreForming;
			END_IF
		PreForming:
	
			FormLocking := TRUE;
			TONFormLocking.IN := NOT EDGEPOS(FormLocking);
			TONFormLocking.PT := REAL_TO_TIME(FormLockingTONValue * 1000);
			TONFormLocking();
			doFormLocking := TONFormLocking.Q;
			
			TONForming.IN := NOT EDGEPOS(FormLocking);
			TONForming.PT := REAL_TO_TIME(FormingTONValue * 1000);
			TONForming();
			
			IF gAVGTemperature <= gDefaultTemperatureValue THEN
				IF BubbleTOFValue <> 0 THEN
					TOFBubble.IN := EDGEPOS(FormLocking);
					TOFBubble.PT := REAL_TO_TIME(BubbleTOFValue * 1000);
					TOFBubble();
					doBubble := TOFBubble.Q;
				END_IF;
			END_IF;
			
			IF (diFormLocked=TRUE) THEN
				doFormLocking := FALSE;
				doBubble := FALSE;
			END_IF;
			IF (diFormLocked=TRUE) AND (TONForming.Q = TRUE) THEN
	  			StateOfProcess := Forming;
			END_IF;	
		Forming:
			
	END_CASE;
		END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

