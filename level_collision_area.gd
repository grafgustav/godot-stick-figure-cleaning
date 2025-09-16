class_name LevelCollisionArea
extends Area2D

signal level_area_entered(level_number: int)

@export var level_number : int

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		level_area_entered.emit(level_number)
