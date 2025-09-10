class_name AbstractDepositContainer
extends CharacterBody2D

var sprite : AnimatedSprite2D

func _ready() -> void:
	self.sprite = $Sprite
	self.sprite.play("idle")

func _on_hitbox_area_body_entered(body: Node2D) -> void:
	if body is AbstractSmudge:
		self.sprite.play("open")

func _on_hitbox_area_body_exited(body: Node2D) -> void:
	if body is AbstractSmudge:
		self.sprite.play("idle")
	
