class_name HitPointComponent
extends Node

## A component for managing hit points with configurable defaults and events
##
## This component handles getting/setting hit points, allows for default values,
## and emits signals when hit points change or reach zero.

signal hit_points_changed(old_value: int, new_value: int)
signal hit_points_depleted
signal hit_points_restored_to_full

@export var default_hit_points: int = 100 : set = set_default_hit_points
@export var current_hit_points: int : set = set_current_hit_points, get = get_current_hit_points

var _current_hit_points: int
var _max_hit_points: int

func _ready():
	# Initialize hit points to default value if not already set
	if _current_hit_points == 0:
		reset_to_default()

func set_default_hit_points(value: int) -> void:
	default_hit_points = max(1, value)  # Ensure minimum of 1
	_max_hit_points = default_hit_points
	
	# If this is the first time setting default, initialize current HP
	if _current_hit_points == 0:
		_current_hit_points = default_hit_points

func set_current_hit_points(value: int) -> void:
	var old_value = _current_hit_points
	_current_hit_points = clamp(value, 0, _max_hit_points)
	
	if old_value != _current_hit_points:
		hit_points_changed.emit(old_value, _current_hit_points)
		
		if _current_hit_points == 0 and old_value > 0:
			hit_points_depleted.emit()
		elif _current_hit_points == _max_hit_points and old_value < _max_hit_points:
			hit_points_restored_to_full.emit()

func get_current_hit_points() -> int:
	return _current_hit_points

## Reset hit points to the default value
func reset_to_default() -> void:
	set_current_hit_points(default_hit_points)

## Get the maximum hit points (same as default)
func get_max_hit_points() -> int:
	return _max_hit_points

## Take damage (reduce hit points)
func take_damage(amount: int) -> void:
	set_current_hit_points(_current_hit_points - amount)

## Heal (increase hit points)
func heal(amount: int) -> void:
	set_current_hit_points(_current_hit_points + amount)

## Check if hit points are at maximum
func is_at_full_health() -> bool:
	return _current_hit_points == _max_hit_points

## Check if hit points are depleted
func is_depleted() -> bool:
	return _current_hit_points <= 0

## Get hit points as a percentage (0.0 to 1.0)
func get_health_percentage() -> float:
	if _max_hit_points == 0:
		return 0.0
	return float(_current_hit_points) / float(_max_hit_points)
