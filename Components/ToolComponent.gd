class_name ToolComponent
extends Node

var tool_name : String = ""
var animation_name : String = ""

func play_animation() -> void:
	var parent = get_parent()
	if parent.has_method(animation_name):
		parent.call(animation_name)
