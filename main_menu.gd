extends Control


func _on_start_but_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")

func _on_exit_but_pressed() -> void:
	get_tree().quit()
