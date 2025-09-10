class_name AbstractSmudge
extends CharacterBody2D

@export var hitpoints: float
@export var points: float
@export var player_passable: bool = false

func _ready() -> void:
	$Sprite.play()
	_init_collisions()

func _init_collisions() -> void:
	self.collision_layer = 8
	if not self.player_passable:
		self.collision_layer |= 2
	else:
		self.collision_layer |= 4

func get_cleaned() -> int:
	hitpoints -= 1
	if hitpoints <= 0.0:
		queue_free()
		return points
	return 0

func turn_left() -> void:
	self.scale = Vector2(-1, 1)
	
func turn_right() -> void:
	self.scale = Vector2(1, 1)
