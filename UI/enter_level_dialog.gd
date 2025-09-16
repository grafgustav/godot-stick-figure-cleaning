class_name EnterLevelDialog
extends CanvasLayer

signal confirm_but_pressed
signal cancel_but_pressed

func _on_confirm_but_pressed() -> void:
	confirm_but_pressed.emit()

func _on_cancel_but_pressed() -> void:
	cancel_but_pressed.emit()
