class_name Tool
extends Node2D

@export var tool_name : String
@export var animation_name : String
@export var cd : float
@export var cooldown_time : float = 1.0

@onready var cooldown_timer : Timer = %CDTimer
@onready var hitbox : Area2D = $CleanBox

signal tool_used
signal tool_ready

func _ready() -> void:
	cooldown_timer.wait_time = cooldown_time
	cooldown_timer.one_shot = true
	cooldown_timer.timeout.connect(_on_cooldown_finished)

# return true if the operation was successful, otherwise false
func use_tool() -> bool:
	if can_use():
		start_cooldown()
		return true
	return false
	
func start_cooldown() -> void:
	cooldown_timer.start()
	
func can_use() -> bool:
	return cooldown_timer.is_stopped()
	
func turn_left() -> void:
	hitbox.scale = Vector2(-1, 1)
	
func turn_right() -> void:
	hitbox.scale = Vector2(1, 1)
	
func _on_cooldown_finished() -> void:
	tool_ready.emit()
