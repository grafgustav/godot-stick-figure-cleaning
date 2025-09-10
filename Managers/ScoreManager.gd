class_name ScoreManagerClass
extends Node

signal player_points_updated(points: int)

## is responsible for all score tracking
var player_points : int = 0

func get_player_points() -> int:
	return player_points

func connect_to_smudge(smudge : AbstractSmudge) -> void:
	smudge.connect("smudge_destroyed", _on_smudge_destroyed)
	
func _on_smudge_destroyed(points : int) -> void:
	player_points += points
	player_points_updated.emit(player_points)
