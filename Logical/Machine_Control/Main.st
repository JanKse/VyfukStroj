
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
			
			cmdHeating := TOFHeating.Q; //IF gDiHeatingHigh cmdHeating := FALSE ??
			
			IF (gDiHeatingHigh = TRUE) THEN
				cmdMaterial := TRUE; // kedy vypnuù
				IF (gSetTimersValues.BlowingTONValue <> 0.0) THEN
					TONBlowing.IN := TRUE;
					TONBlowing.PT := REAL_TO_TIME(gSetTimersValues.BlowingTONValue * 1000);
					TONBlowing();
				
					TOFBlowing.IN := EDGEPOS(TONBlowing.Q);
					TOFBlowing.PT := REAL_TO_TIME(gSetTimersValues.BlowingTONValue * 1000);
					TOFBlowing();
					cmdBlowing := TOFBlowing.Q;
					
					IF (cmdHeating = FALSE) AND (TOFBlowing.ET = TOFBlowing.PT) THEN
						cmdMaterial := FALSE;
						gStateOfProcess := BubbleANDFormDownDelay;
					END_IF;
				ELSE
					IF (cmdHeating = FALSE) THEN
						cmdMaterial := FALSE;
						gStateOfProcess := BubbleANDFormDownDelay;
					END_IF
				END_IF;
	
			END_IF;
		
		BubbleANDFormDownDelay :
			//------------ZpoûdenÌ uzav¯enÌ formy nastavenÈ na x sekund ---------------
			TONFormLocking.IN := TRUE;
			TONFormLocking.PT := REAL_TO_TIME(gSetTimersValues.FormLockingTONValue * 1000);
			TONFormLocking();
			cmdFormDown:= TONFormLocking.Q; // cmdFormUp ?? 
			//---------------------------------------------
			//------------ZpoûdenÌ formovanÌ nastastavenÈ na x sekund -----------------------
			TONForming.IN := TONFormLocking.Q;
			TONForming.PT := REAL_TO_TIME(gSetTimersValues.FormingTONValue * 1000);
			TONForming();
			//---------------------------------------------------------------
			//Ovladanie bubliny
			IF (gDiHeatingLow = TRUE) THEN
				IF gSetTimersValues.BubbleTOFValue <> 0 THEN
					//Zapni bublinu na x sekund
					cmdBubble := TRUE;
					TOFBubble.IN := EDGEPOS(cmdBubble);
					TOFBubble.PT := REAL_TO_TIME(gSetTimersValues.BubbleTOFValue * 1000);
					TOFBubble();
					cmdBubble := TOFBubble.Q;
				END_IF;
			END_IF;
			//AK je forma dole vypni bublinu
			IF (gDiFormDownPosition = TRUE) THEN
				cmdBubble := FALSE;
			//--------------------------------------------------
			END_IF;
			//Ak mÙûme zaËaù formovaù a bublina je vypnuta prejdi na krok formovanie
			IF (TONForming.Q = TRUE) AND (cmdBubble = FALSE) THEN
				gStateOfProcess := StartForming;	
			END_IF;
			//--------------------------------------------------
		StartForming :
			//Formovanie na x sekund
			cmdForming := TRUE;
			TOFForming.IN := EDGEPOS(cmdForming);
			TOFForming.PT := REAL_TO_TIME(gSetTimersValues.FormingTOFVALUE * 1000);
			TOFForming();
			cmdForming:=TOFForming.Q;
			//--------------
			//Ak to skonËÌ formovanie prejdi na ÔalöÌ krok
			IF (cmdForming = FALSE) THEN
				gStateOfProcess :=CoolingANDBlowingDelay;
			END_IF;
		CoolingANDBlowingDelay:
			//Zapni chladnie
			//Zapni oneskorenie odfuku na x sekund
			cmdCooling := TRUE;
			TONOdfuk.IN := TRUE;
			TONOdfuk.PT := REAL_TO_TIME(gSetTimersValues.OdfukTONValue * 1000);
			TONOdfuk();
			//Ak vyprÌ Ëas oneskorenia prejdi na ÔaæöÌ krok
			IF (TONOdfuk.Q = TRUE) THEN
	  			gStateOfProcess := Finishing;
			END_IF;
		Finishing:
			//Zapni odfuk na x sekund
			cmdOdfuk:= TRUE;
			TOFOdfuk.IN := cmdOdfuk;
			TOFOdfuk.PT := REAL_TO_TIME(gSetTimersValues.OdfukTOFValue * 1000);
			TOFOdfuk();
			cmdOdfuk := TOFOdfuk.Q;
			//------------
			//Oneskorenie otvorenia formy nastavenÈ na x sekund
			TONFormUp.IN := TRUE;
			TONFormUp.PT := REAL_TO_TIME(gSetTimersValues.FormUpTONValue);
			TONFormUp();
			IF TONFormUp.Q THEN
				cmdFormDown:=FALSE; //cmdFormUp
				cmdCooling:=FALSE;
				cmdFrameDown := FALSE;
				cmdFrameUp := TRUE;
			END_IF;
			IF (gDiFormUpPosition = TRUE) THEN
	  			gStateOfProcess := DefaultState;
			END_IF;
		
			
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
END_PROGRAM

