class_name Ui
extends Control

signal ui_tool_but_pressed(tool_scene: String)

func _ready() -> void:
	ToolManager.connect_to_ui(self)

func _on_vacuum_but_pressed() -> void:
	ui_tool_but_pressed.emit(GlobalStuff.VACUUM)

func _on_broom_but_pressed() -> void:
	ui_tool_but_pressed.emit(GlobalStuff.BROOM)

func _on_hands_but_pressed() -> void:
	ui_tool_but_pressed.emit(GlobalStuff.HANDS)

func _on_mop_but_pressed() -> void:
	ui_tool_but_pressed.emit(GlobalStuff.MOP)

func _on_tile_machine_but_pressed() -> void:
	ui_tool_but_pressed.emit(GlobalStuff.TILE_MACHINE)
