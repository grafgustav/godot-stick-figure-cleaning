class_name GameManagerClass
extends Node

## Manages the game state
## transitions levels, pause, save and load games

var overlay : EnterLevelDialog

func connect_to_level_collision_area(area: LevelCollisionArea) -> void:
	area.connect("level_area_entered", show_level_dialog)
	
func show_level_dialog(level_number : int) -> void:
	get_tree().paused = true
	overlay = preload("res://UI/enter_level_dialog.tscn").instantiate()
	overlay.connect("confirm_but_pressed", switch_scene_to_level.bind(level_number))
	overlay.connect("cancel_but_pressed", cancel_dialog)
	get_tree().current_scene.add_child(overlay)

func cancel_dialog() -> void:
	get_tree().paused = false
	if overlay:
		overlay.queue_free()
	
func switch_scene_to_level(level_number : int) -> void:
	print("Switching scene?")
	get_tree().paused = false
	var level_file : String
	if GlobalStuff.LEVEL_DATA.has(level_number):
		level_file = GlobalStuff.LEVEL_DATA[level_number]["scene_file"]
		await get_tree().process_frame
		get_tree().change_scene_to_file(level_file)
	else:
		print("Level Number has no matching file in constants", level_number)
		cancel_dialog()
