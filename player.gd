class_name Player
extends CharacterBody2D

signal player_points_updated

var equipped_tool : AbstractTool
var carried_smudge : AbstractSmudge

var happyFreddy: HappyFreddy
var turned_right: bool

func _ready() -> void:
	equip_vacuum()
	happyFreddy = %HappyFreddy
	
func equip_tool(tool_name : String) -> void:
	if equipped_tool:
		equipped_tool.queue_free()
	var tool_scene = load(tool_name)
	equipped_tool = tool_scene.instantiate()
	add_child(equipped_tool)

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
	
func equip_mop() -> void:
	if equipped_tool:
		equipped_tool.queue_free()
	var mop_scene = preload("res://Tools/mop.tscn")
	equipped_tool = mop_scene.instantiate()
	add_child(equipped_tool)
	
func equip_tile_machine() -> void:
	if equipped_tool:
		equipped_tool.queue_free()
	var tile_machine_scene = preload("res://Tools/tile_floor_cleaner.tscn")
	equipped_tool = tile_machine_scene.instantiate()
	add_child(equipped_tool)

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 200
	if direction.x < 0:
		happyFreddy.flip_h = true
		turned_right = false
		equipped_tool.turn_left()
		if carried_smudge:
			carried_smudge.position = Vector2(-10,0)
	elif direction.x > 0:
		happyFreddy.flip_h = false
		turned_right = true
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
			clean()
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
		"tile_machining":
			happyFreddy.play_tile_machining()
		"mopping":
			happyFreddy.play_mopping()
		_:
			print("Animation not found")

func clean():
	var tool_hitbox : Area2D = equipped_tool.get_node("CleanBox")
	var colliding_bodies = tool_hitbox.get_overlapping_bodies()
	for c_body in colliding_bodies:
		if not c_body is AbstractSmudge:
			break
		var smudge : AbstractSmudge = c_body
		if GlobalStuff.is_smudge_cleanable_with_tool(smudge.get_smudge_type(), equipped_tool.get_tool_type()):
			smudge.get_cleaned()

func pick_up():
	var tool_hitbox : Area2D = equipped_tool.get_node("CleanBox")
	var colliding_bodies = tool_hitbox.get_overlapping_bodies()
	for c_body in colliding_bodies:
		if not c_body is AbstractSmudge:
			break
		var smudge : AbstractSmudge = c_body
		if not GlobalStuff.is_smudge_cleanable_with_tool(smudge.get_smudge_type(), equipped_tool.get_tool_type()):
			break
		smudge.collision_layer &= ~2
		smudge.reparent(self)
		if turned_right:
			smudge.position = Vector2(10,0)
		else:
			smudge.position = Vector2(-10,0)
		self.carried_smudge = smudge

func put_down():
	if not carried_smudge:
		print("No smudge carried!")
		return
	# put the smudge onto a deposit
	if carried_smudge.collides_with_deposit():
		carried_smudge.get_deposited()
		carried_smudge = null
		return
	else:
		var parent = self.get_parent()
		carried_smudge.reparent(parent)
	# put the smudge somewhere
	if not carried_smudge.player_passable:
		carried_smudge.collision_layer |= 2
	carried_smudge = null
