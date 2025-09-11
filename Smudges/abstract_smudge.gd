class_name AbstractSmudge
extends CharacterBody2D

signal smudge_destroyed(points: int)

@export var hitpoints: float
@export var points: float
@export var player_passable: bool = false
@export var smudge_type: GlobalStuff.SmudgeTypes

var detection_area : Area2D
var is_in_deposit_area : int = 0

func _ready() -> void:
	$Sprite.play()
	_init_collisions()
	ScoreManager.connect_to_smudge(self)
	detection_area = $DetectionArea
	_create_detection_area()
	
func _create_detection_area() -> void:
	detection_area = $DetectionArea
	var detection_area_shape = CollisionShape2D.new()
	var hitbox_shape = $Hitbox.shape

	detection_area_shape.shape = hitbox_shape.duplicate()
	detection_area.collision_mask = 8
	detection_area.add_child(detection_area_shape)

func _init_collisions() -> void:
	self.collision_layer = 8
	if not self.player_passable:
		self.collision_layer |= 2
	else:
		self.collision_layer |= 4

func get_cleaned() -> void:
	hitpoints -= 1
	if hitpoints <= 0.0:
		_destroy_smudge()

func collides_with_deposit() -> bool:
	return is_in_deposit_area == 0

func get_deposited() -> void:
	_destroy_smudge()
	
func get_smudge_type() -> GlobalStuff.SmudgeTypes:
	return smudge_type

func _destroy_smudge() -> void:
	smudge_destroyed.emit(self.points)
	queue_free()

func turn_left() -> void:
	self.scale = Vector2(-1, 1)

func turn_right() -> void:
	self.scale = Vector2(1, 1)

func _on_detection_area_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent is AbstractDepositContainer:
		is_in_deposit_area += 1

func _on_detection_area_area_exited(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent is AbstractDepositContainer:
		is_in_deposit_area -= 1
