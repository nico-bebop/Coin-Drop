extends Node2D

onready var animation_player = $AnimationPlayer


func _ready():
	animation_player.play("Highlight")


func _on_Board_turn_ready():
	change_slots_state(true)
	animation_player.play("Highlight")


func change_slots_state(value = false):
	for slot in get_tree().get_nodes_in_group("Slot"):
		slot.clickable = value
