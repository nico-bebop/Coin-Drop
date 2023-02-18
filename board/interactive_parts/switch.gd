extends Node2D

const BrokenSwitch = preload("res://board/broken_parts/broken_switch.tscn")

const FLIP_TO_LEFT = "FlipToLeft"
const FLIP_TO_RIGHT = "FlipToRight"

onready var animation_player = $AnimationPlayer
onready var coin_spawn_position = $CoinSpawnPosition
onready var holes = $"../../../Holes"

export(String) var orientation

var has_ball = false


func set_random_position():
	if randi() % 2 == 0:
		animation_player.play(FLIP_TO_LEFT)
	else:
		animation_player.play(FLIP_TO_RIGHT)
	animation_player.seek(0.2)


func flip_contrary():
	match orientation:
		Globals.LEFT:
			animation_player.play(FLIP_TO_RIGHT)
		Globals.RIGHT:
			animation_player.play(FLIP_TO_LEFT)


func _on_Bottom_body_entered(_body):
	flip_contrary()


func destroy_switch():
	animation_player.play("BlinkAndDestroy")


func deactivate_switch():
	$Bottom.monitoring = false


func create_hole():
	var hole = BrokenSwitch.instance()
	hole.frame = 1 if orientation == Globals.LEFT else 0
	hole.global_position = global_position
	holes.add_child(hole)
