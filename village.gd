class_name Village
extends Node2D

## here I should check for all LevelCollisionAreas and connect their signals I guess
func _ready() -> void:
	var children = get_children()
	for child in children:
		if child is LevelCollisionArea:
			print("Connecting Level")
			child.connect("level_area_entered", _on_level_area_entered)

func _on_level_area_entered(level_number : int) -> void:
	print("Entering Level ", level_number)
	var level_file : String
	if GlobalStuff.LEVELS.has(level_number):
		level_file = GlobalStuff.LEVELS[level_number]
		var ret := get_tree().change_scene_to_file(level_file)
		print("Returning code: ", ret)
	else:
		print("Level Number has no matching file in constants", level_number)
