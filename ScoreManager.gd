class_name ScoreManager
extends Node

## is responsible for all score tracking
var player_points : int = 0

func connect_to_smudge(smudge : AbstractSmudge) -> void:
	smudge.connect("smudge_destroyed", _on_smudge_destroyed)
	
func _on_smudge_destroyed(points : int) -> void:
	player_points += points
