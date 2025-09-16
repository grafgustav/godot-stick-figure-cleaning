class_name Level1
extends Node2D

func _ready() -> void:
	ScoreManager.connect("player_points_updated", _on_player_points_updated)

func _process(_delta: float) -> void:
	if Input.is_action_pressed("exit_to_menu"):
		get_tree().change_scene_to_file("res://main_menu.tscn")

func showRoom(room_number: int):
	hideAllRooms()
	match room_number:
		1:
			%Room1HideBox.visible = false
		2:
			%Room2HideBox.visible = false
		3:
			%Room3HideBox.visible = false
		_:
			hideAllRooms()

func hideAllRooms():
	%Room1HideBox.visible = true
	%Room2HideBox.visible = true
	%Room3HideBox.visible = true

func _on_room_1_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		showRoom(1)

func _on_room_2_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		showRoom(2)

func _on_room_3_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		showRoom(3)

func _on_player_points_updated(player_points : int) -> void:
	%PointsLabel.text = str(player_points)

func _on_broom_but_pressed() -> void:
	%Player.equip_broom()
	
func _on_vacuum_but_pressed() -> void:
	%Player.equip_vacuum()

func _on_hands_but_pressed() -> void:
	%Player.equip_hands()
	
func _on_mop_but_pressed() -> void:
	%Player.equip_mop()

func _on_tile_machine_but_pressed() -> void:
	%Player.equip_tile_machine()
