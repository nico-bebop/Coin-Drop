extends Node2D

onready var animation_player = $AnimationPlayer

const LEFT = -45.0
const RIGHT = 45.0


func _ready():
	randomize()
	if randi() % 2 == 0:
		animation_player.play("FlipToLeft")
	else:
		animation_player.play("FlipToRight")


func flip_contrary():
	match global_rotation_degrees:
		LEFT:
			animation_player.play("FlipToRight")
		RIGHT:
			animation_player.play("FlipToLeft")


func _on_Bottom_body_entered(_body):
	flip_contrary()
