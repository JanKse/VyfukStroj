
PROGRAM _INIT
	(* Insert code here *)
	doAirPump := FALSE;
	diStartButton := FALSE;
	diFrameLocked :=FALSE;
	doBlowing  := FALSE;
	StateOfProcess := WaitForStartCommand;
	doHeating := FALSE;
	HeatingTOFValue := 10.0;
	BlowingTONValue := 20;
	BlowingTOFValue := 2;    //Duration of blowing air
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
	CASE StateOfProcess OF
		WaitForStartCommand:
			IF diStartButton AND diFrameLocked THEN
				doAirPump := TRUE;
	  			StateOfProcess := Heating;
			END_IF;
		Heating: 
			doHeating := TRUE;
			TOFHeating.IN:=EDGEPOS(doHeating);
			TOFHeating.PT := REAL_TO_TIME(HeatingTOFValue * 1000);
			doHeating := TOFHeating.Q;										 //Add HeatingZones
			TOFHeating();
			
			IF BlowingTOFValue <> 0 THEN
				TONBlowing.IN := NOT EDGEPOS(doHeating); 
				TONBlowing.PT := REAL_TO_TIME(BlowingTONValue * 1000);
				TONBlowing();
		
				TOFBlowing.IN := EDGEPOS(TONBlowing.Q);
				TOFBlowing.PT := REAL_TO_TIME(BlowingTOFValue * 1000);
				doBlowing := TOFBlowing.Q;
				TOFBlowing();
			END_IF;
			
			IF (TOFHeating.ET = TOFHeating.PT) AND (TOFBlowing.ET = TOFBlowing.PT) AND (doBlowing = FALSE) AND (doHeating = FALSE) THEN
	  			StateOfProcess := PreForming;
			END_IF
		PreForming:
			//TODO Tomorow
	END_CASE;
		END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

