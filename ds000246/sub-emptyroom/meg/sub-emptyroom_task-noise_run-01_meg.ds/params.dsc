
// Head Localization parameters.
// 24-Oct-2017 17:11

CustomDs
{
	FixSensors:	False
}

// PROCESSING PARAMETERS
processing
{
	// balance: order, adapted
	// (adapted=0 -> not adapted)
	// (adapted=1 -> adapted)
	balance:	3,0
}

// Data selector parameters.
DsSelector
{
	RejectBadTrials:	TRUE
	ForceEvenNumTargets:	FALSE
	MaximumOverlap:	0
	StartTime:	-0
	EndTime:	2
	EventRange:	ALL
	WholeTrial:	TRUE
	CondSearchStart:	0
	CondSearchEnd:	0
	TargetTrialOffset:	0
}
