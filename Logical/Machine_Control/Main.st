PROGRAM _INIT
	//Start state of cyclus
	gStateOfProcess := ManualMode;
	//--------------------------------------------------------------------------------------------
END_PROGRAM

PROGRAM _CYCLIC	
	ManualModeControl;
(*	CASE gStateOfProcess OF
		ManualMode:
			ManualModeControl;
		
		IF (gDiButtonStart = TRUE) AND (gRecipeLoaded = TRUE) THEN
			cmdAirPump := gDiButtonStart;
			cmdFrameDown := gDiButtonStart;
			IF (gDiFrameDownPosition = TRUE) THEN
				//cmdAirPump:= TRUE/FALSE; ??
				//cmdFrameDown:=TRUE/FALSE; ??
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
			cmdFormUp:= NOT(TONFormLocking.Q); // cmdFormUp ?? 
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
			IF (cmdFormUp = FALSE) AND (cmdBubble = FALSE) AND (gDiFormDownPosition = TRUE) THEN
				gStateOfProcess := StartForming;	
			END_IF;
			//--------------------------------------------------
		StartForming :
			//Formovanie na x sekund
			cmdForming := TRUE;
			TOFForming.IN := EDGEPOS(cmdForming);
			TOFForming.PT := REAL_TO_TIME(gSetTimersValues.FormingTOFVALUE * 1000);
			TOFForming();
			cmdForming:=TOFForming.Q; //asi vacuum
			//--------------
			//Ak to skonËÌ formovanie prejdi na ÔalöÌ krok
			IF (cmdForming = FALSE) THEN
				gStateOfProcess :=CoolingANDBlowingDelay;
			END_IF;
		CoolingANDBlowingDelay:
			//Zapni chladnie
			//Zapni oneskorenie odfuku na x sekund
			cmdCooling := TRUE;
			TONFreeItem.IN := TRUE;
			TONFreeItem.PT := REAL_TO_TIME(gSetTimersValues.FreeItemTONValue * 1000);
			TONFreeItem();
			//Ak vyprÌ Ëas oneskorenia prejdi na ÔaæöÌ krok
			IF (TONFreeItem.Q = TRUE) THEN
				gStateOfProcess := Finishing;
			END_IF;
		Finishing:
			//Zapni odfuk na x sekund
			cmdFreeItem:= TRUE;
			TOFFreeItem.IN := cmdFreeItem;
			TOFFreeItem.PT := REAL_TO_TIME(gSetTimersValues.FreeItemTOFValue * 1000);
			TOFFreeItem();
			cmdFreeItem := TOFFreeItem.Q;
			//------------
			//Oneskorenie otvorenia formy nastavenÈ na x sekund
			TONFormUp.IN := TRUE;
			TONFormUp.PT := REAL_TO_TIME(gSetTimersValues.FormUpTONValue);
			TONFormUp();
			IF TONFormUp.Q THEN
				cmdFormUp:=TRUE; //cmdFormUp
				cmdCooling:=FALSE;
				cmdFrameDown := FALSE;
				cmdFrameUp := TRUE;
			END_IF;
			IF (gDiFrameUpPoistion = TRUE) THEN
				cmdFrameUp := FALSE;
				gStateOfProcess := DefaultState;
			END_IF;
		
			
	END_CASE;	
		
	*)
	
END_PROGRAM

PROGRAM _EXIT		 
END_PROGRAM

