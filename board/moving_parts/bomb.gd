extends "res://board/moving_parts/ball.gd"

const Hole = preload("res://board/broken_parts/hole.tscn")

enum { EXPLODE, RED_GLOW, HALF_TIME, IGNITED }

export(int) var ticks_left = 3
export(bool) var ignited = false

onready var animation_player = $AnimationPlayer
onready var coin_destroy_audio = get_tree().current_scene.coin_destroy_audio
onready var holes = $"../../Holes"
onready var camera = $"../../Camera2D"

var colliding_switch


func _ready():
	animation_player.play("Alert")
	yield(animation_player, "animation_finished")


func _physics_process(_delta):
	if ball_collision.is_colliding():
		var colliding_ball = ball_collision.get_collider()
		if colliding_ball.is_in_group(Globals.GROUP_COINS):
			colliding_ball.queue_free()
			coin_destroy_audio.play()


func tick():
	if ignited:
		ticks_left -= clamp(1, EXPLODE, IGNITED)

	update_label()
	update_animation()


func update_label():
	$Label.text = str(ticks_left)


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


func get_colliding_switch():
	for switch in $SwitchCollision.get_overlapping_bodies():
		if switch.is_in_group(Globals.GROUP_SWITCHES):
			switch.deactivate_switch()
			colliding_switch = switch


func destroy_colliding_switch():
	if colliding_switch != null:
		colliding_switch.destroy_switch()


func create_hole():
	var hole = Hole.instance()
	hole.global_position = global_position
	holes.add_child(hole)


func shake_camera():
	camera.shake(0.3, 50, 7)


func _on_SwitchCollision_body_entered(body):
	._on_SwitchCollision_body_entered(body)
	tick()
