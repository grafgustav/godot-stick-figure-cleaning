extends CharacterBody2D

var hitpoints = 3

func _ready() -> void:
	%AnimatedSprite2D.play()

func get_cleaned() -> int:
	hitpoints -= 1
	if hitpoints <= 0.0:
		queue_free()
		return 1
	return 0
