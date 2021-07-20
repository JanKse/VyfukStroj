
TYPE
	StateOfProcessType : 
		(
		ManualMode,
		DefaultState,
		Start,
		BubbleANDFormDownDelay,
		StartForming,
		CoolingANDBlowingDelay,
		Finishing
		);
	TemperaturesType : 	STRUCT 
		temperatureHeatZone1 : INT;
		temperatureHeatZone2 : INT;
		temperatureHeatZone3 : INT;
		temperatureIRSensor : INT;
		temperatureOffset : INT;
		temperatureHysterese : REAL;
	END_STRUCT;
	TimersType : 	STRUCT 
		HeatingTOFValue : REAL;
		BlowingTONValue : REAL;
		BlowingTOFValue : REAL;
		BubbleTOFValue : REAL;
		FormingTONValue : REAL;
		FormLockingTONValue : REAL;
		FormingTOFVALUE : REAL;
		FreeItemTOFValue : REAL;
		FreeItemTONValue : REAL;
		FormUpTONValue : REAL;
	END_STRUCT;
END_TYPE
