class_name AbstractSmudge
extends CharacterBody2D

signal smudge_destroyed(points: int)

@export var hitpoints: float
@export var points: float
@export var player_passable: bool = false

func _ready() -> void:
	$Sprite.play()
	_init_collisions()
	ScoreManager.connect_to_smudge(self)

func _init_collisions() -> void:
	self.collision_layer = 8
	if not self.player_passable:
		self.collision_layer |= 2
	else:
		self.collision_layer |= 4

func get_cleaned() -> void:
	hitpoints -= 1
	if hitpoints <= 0.0:
		smudge_destroyed.emit(self.points)
		queue_free()

func turn_left() -> void:
	self.scale = Vector2(-1, 1)
	
func turn_right() -> void:
	self.scale = Vector2(1, 1)
