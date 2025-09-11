extends Node

## contains global constants, enums, etc

enum DepositTypes {
	GENERAL_TRASH,
	PLASTIC,
	BOOKS,
	BOTTLES
}

enum SmudgeTypes {
	DRY,
	WET,
	BACTERIA,
	HOUSEHOLD
}

enum ToolTypes {
	DRY,
	WET,
	DESINFECTANT,
	TIDYING
}

## maps from a tool type onto a list of SmudgeTypes
const CLEAN_MAPPING = {
	ToolTypes.DRY: [SmudgeTypes.DRY],
	ToolTypes.WET: [SmudgeTypes.WET],
	ToolTypes.DESINFECTANT: [SmudgeTypes.BACTERIA],
	ToolTypes.TIDYING: [SmudgeTypes.HOUSEHOLD],
}

func is_smudge_cleanable_with_tool(smudge: SmudgeTypes, tool: ToolTypes) -> bool:
	if CLEAN_MAPPING[tool].has(smudge):
		return true
	return false
