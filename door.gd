extends Node2D


func _ready() -> void:
	%DoorSprite.play("closed")

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		%DoorSprite.play("open")

func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		%DoorSprite.play("closed")
