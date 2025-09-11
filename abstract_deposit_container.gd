class_name AbstractDepositContainer
extends CharacterBody2D

@export var deposit_type : GlobalStuff.DepositTypes

var sprite : AnimatedSprite2D

func _ready() -> void:
	sprite = $Sprite
	sprite.play("idle")

func get_deposit_type() -> GlobalStuff.DepositTypes:
	return deposit_type

func _on_hitbox_area_body_entered(body: Node2D) -> void:
	if body is AbstractSmudge:
		sprite.play("open")

func _on_hitbox_area_body_exited(body: Node2D) -> void:
	if body is AbstractSmudge:
		sprite.play("idle")
	
