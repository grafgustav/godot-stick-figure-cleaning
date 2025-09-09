class_name Player
extends CharacterBody2D

signal player_points_updated

var player_points = 0
var equipped_tool : Tool

var happyFreddy: HappyFreddy

func _ready() -> void:
	equip_broom()
	happyFreddy = %HappyFreddy

func equip_broom() -> void:
	if equipped_tool:
		equipped_tool.queue_free()
	var broom_scene = preload("res://Tools/broom.tscn")
	equipped_tool = broom_scene.instantiate()
	add_child(equipped_tool)

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	self.velocity = direction * 200
	if direction.x < 0:
		happyFreddy.flip_h = true
		# %CleanBox.scale = Vector2(-1, 1)
	elif direction.x > 0:
		happyFreddy.flip_h = false
		# %CleanBox.scale = Vector2(1, 1)
	move_and_slide()
	
	var using_tool = Input.is_action_pressed("use_tool")
	
	if using_tool:
		use_tool()
		cleaning()
	else:
		if velocity.length() > 0.0:
			happyFreddy.play_walk_animation()
		else:
			happyFreddy.play_idle_animation()
			
func use_tool() -> void:
	var tool_used = equipped_tool.use_tool()
	#if tool_used:
		# play animation & clean
	play_tool_animation(equipped_tool.animation_name)
		# cleaning()
	
func play_tool_animation(animation_name) -> void:
	match animation_name:
		"brooming":
			happyFreddy.play_brooming_animation()
		_:
			pass
	
func brooming() -> void:
		%HappyFreddy.play("brooming")

func update_player_points(add: int):
	if add > 0:
		player_points += add
		player_points_updated.emit()
	
func get_player_points() -> int:
	return player_points

func cleaning():
	var tool_hitbox : Area2D = equipped_tool.get_node("CleanBox")
	var collidingSmudges = tool_hitbox.get_overlapping_bodies()
	for smudge in collidingSmudges:
		if smudge.has_method("get_cleaned"):
			var clean_points = smudge.get_cleaned()
			update_player_points(clean_points)
