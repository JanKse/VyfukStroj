
TYPE
	StateOfProcessType : 
		(
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
		defaultTemperatureValue : INT;
	END_STRUCT;
	TimersType : 	STRUCT 
		HeatingTOFValue : REAL;
		BlowingTONValue : REAL;
		BlowingTOFValue : REAL;
		BubbleTOFValue : REAL;
		FormingTONValue : REAL;
		FormLockingTONValue : REAL;
		FormingTOFVALUE : REAL;
		OdfukTOFValue : REAL;
		OdfukTONValue : REAL;
		FormUpTONValue : REAL;
	END_STRUCT;
END_TYPE
