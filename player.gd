class_name Player
extends CharacterBody2D

signal player_points_updated

var equipped_tool : Tool
var carried_smudge : AbstractSmudge

var happyFreddy: HappyFreddy

func _ready() -> void:
	equip_vacuum()
	happyFreddy = %HappyFreddy

func equip_broom() -> void:
	if equipped_tool:
		equipped_tool.queue_free()
	var broom_scene = preload("res://Tools/broom.tscn")
	equipped_tool = broom_scene.instantiate()
	add_child(equipped_tool)
	
func equip_vacuum() -> void:
	if equipped_tool:
		equipped_tool.queue_free()
	var vacuum_scene = preload("res://Tools/vacuum.tscn")
	equipped_tool = vacuum_scene.instantiate()
	add_child(equipped_tool)
	
func equip_hands() -> void:
	if equipped_tool:
		equipped_tool.queue_free()
	var hands_scene = preload("res://Tools/hands.tscn")
	equipped_tool = hands_scene.instantiate()
	add_child(equipped_tool)

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	self.velocity = direction * 200
	if direction.x < 0:
		happyFreddy.flip_h = true
		equipped_tool.turn_left()
		if carried_smudge:
			carried_smudge.position = Vector2(-10,0)
	elif direction.x > 0:
		happyFreddy.flip_h = false
		equipped_tool.turn_right()
		if carried_smudge:
			carried_smudge.position = Vector2(10,0)
	move_and_slide()
	
	var using_tool = Input.is_action_pressed("use_tool")
	
	if using_tool:
		use_tool()
	else:
		if velocity.length() > 0.0:
			if carried_smudge:
				happyFreddy.play_handling_animation()
			else:
				happyFreddy.play_walk_animation()
		else:
			happyFreddy.play_idle_animation()
			
func use_tool() -> void:
	var tool_used = equipped_tool.use_tool()
	play_tool_animation(equipped_tool.animation_name)
	if tool_used:
		if not equipped_tool.tool_picks_up():
			cleaning()
		else:
			if carried_smudge:
				put_down()
			else:
				pick_up()
	
func play_tool_animation(animation_name) -> void:
	match animation_name:
		"brooming":
			happyFreddy.play_brooming_animation()
		"vacuuming":
			happyFreddy.play_vacuuming_animation()
		"handling":
			happyFreddy.play_handling_animation()
		_:
			pass
	
func brooming() -> void:
		%HappyFreddy.play("brooming")

func cleaning():
	var tool_hitbox : Area2D = equipped_tool.get_node("CleanBox")
	var collidingSmudges = tool_hitbox.get_overlapping_bodies()
	for smudge in collidingSmudges:
		if smudge.has_method("get_cleaned"):
			smudge.get_cleaned()

func pick_up():
	var tool_hitbox : Area2D = equipped_tool.get_node("CleanBox")
	var collidingSmudges = tool_hitbox.get_overlapping_bodies()
	for smudge in collidingSmudges:
		smudge.collision_layer &= ~2
		smudge.reparent(self)
		smudge.position = Vector2(10,0)
		self.carried_smudge = smudge

func put_down():
	if not carried_smudge:
		print("No smudge carried!")
		return
	var parent = self.get_parent()
	carried_smudge.reparent(parent)
	if not carried_smudge.player_passable:
		carried_smudge.collision_layer |= 2
	carried_smudge = null
