extends "res://board/moving_parts/ball.gd"

const Hole = preload("res://board/broken_parts/hole.tscn")

enum { EXPLODE, RED_GLOW, HALF_TIME, IGNITED }

export(int) var ticks_left = 3
export(bool) var ignited = false

onready var explosion_audio = $ExplosionAudio
onready var label = $Label
onready var spark = $Spark
onready var animation_player = $AnimationPlayer
onready var switch_collision = $SwitchCollision
onready var holes = $"../../Holes"

onready var camera = $"../../Camera2D"


func _ready():
	update_label()


func tick():
	if ignited:
		ticks_left -= 1

	update_label()
	update_animation()


func update_label():
	label.text = str(ticks_left)


func update_animation():
	match ticks_left:
		IGNITED:
			animation_player.play("Ignited")
		HALF_TIME:
			animation_player.play("HalfTime")
		RED_GLOW:
			animation_player.play("RedGlow")
		EXPLODE:
			animation_player.play("BlinkAndExplode")
		_:
			animation_player.play("RESET")


func explode():
	animation_player.play("BlinkAndExplode")


func destroy_colliding_switch():
	for switch in switch_collision.get_overlapping_bodies():
		if switch.is_in_group(Globals.GROUP_SWITCHES):
			switch.destroy_switch()


func create_hole():
	var hole = Hole.instance()
	hole.global_position = global_position
	holes.add_child(hole)


func shake_camera():
	camera.shake(0.3, 50, 7) 
