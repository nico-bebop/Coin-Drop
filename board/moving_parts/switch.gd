extends Node2D

onready var animation_player = $AnimationPlayer

export(String) var orientation


func _ready():
	randomize()
	if randi() % 2 == 0:
		animation_player.play("FlipToLeft")
	else:
		animation_player.play("FlipToRight")
	animation_player.seek(0.6)


func flip_contrary():
	match orientation:
		"LEFT":
			animation_player.play("FlipToRight")
		"RIGHT":
			animation_player.play("FlipToLeft")


func _on_Bottom_body_entered(_body):
	flip_contrary()
