class_name Ui
extends Control

signal ui_vacuum_but_pressed
signal ui_broom_but_pressed
signal ui_hands_but_pressed
signal ui_mop_but_pressed
signal ui_tile_machine_but_pressed

func _on_vacuum_but_pressed() -> void:
	ui_vacuum_but_pressed.emit()

func _on_broom_but_pressed() -> void:
	ui_broom_but_pressed.emit()

func _on_hands_but_pressed() -> void:
	ui_hands_but_pressed.emit()

func _on_mop_but_pressed() -> void:
	ui_mop_but_pressed.emit()

func _on_tile_machine_but_pressed() -> void:
	ui_tile_machine_but_pressed.emit()
