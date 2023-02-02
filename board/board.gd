extends Node2D

signal board_ready


func _ready():
	for switch in get_tree().get_nodes_in_group(Globals.GROUP_SWITCHES):
		switch.set_random_position()
		yield(switch.get("animation_player"), "animation_finished")
	emit_signal("board_ready")
