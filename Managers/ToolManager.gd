class_name ToolManagerClass
extends Node

## this class takes care of all the tool switching
## and tool operations maybe? No, that's better inside
## of the player. But switching tools should not be
## the responsibility of the level scene

var ui : Node
var player : Player

func connect_to_ui(node: Node):
	node.connect("ui_tool_but_pressed", _on_change_tool)

func register_player(player : Player) -> void:
	self.player = player

func _on_change_tool(tool_scene : String) -> void:
	player.equip_tool(tool_scene)
