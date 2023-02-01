extends KinematicBody2D

const MAX_MULTIPLIER = 5
const MAX_SPEED = 300
const ACCELERATION = 150
const LEFT_TARGET = Vector2(20, 2)
const RIGHT_TARGET = Vector2(-20, 2)

var can_shine = true
var direction = Globals.DOWN
var multiplier = 1 setget set_multiplier
var moving = true
var orientation = null
var target_position
var velocity = Vector2.ZERO

onready var animation_player = $AnimationPlayer
onready var coin_combine_audio = $CoinCombineAudio
onready var coin_land_audio = $CoinLandAudio
onready var label = $Label
onready var shine_timer = $ShineTimer
onready var sparkle_effect = $Sparkle

signal check_moving_coins


func _ready():
	var _err = connect("check_moving_coins", get_parent(), "check_active_coins")


func _physics_process(delta):
	process_movement(delta)
	play_idle_animation()
	velocity = move_and_slide(velocity)


func combine_coin():
	animation_player.stop()
	animation_player.play("HorizontalFlip")
	coin_combine_audio.play()
	yield(animation_player, "animation_finished")
	sparkle_effect.emitting = true


func change_multiplier(value):
	multiplier = clamp(value, multiplier, MAX_MULTIPLIER)
	label.text = str(multiplier)


func process_movement(delta):
	match direction:
		Globals.DOWN:
			velocity = velocity.move_toward(Vector2.DOWN * MAX_SPEED, ACCELERATION * delta)
		Globals.LEFT, Globals.RIGHT:
			global_position = global_position.move_toward(target_position, ACCELERATION * delta)

	if global_position == target_position:
		direction = Globals.DOWN


func play_idle_animation():
	if !moving && can_shine:
		shine_timer.start()
		animation_player.play("IdleShine")
		can_shine = false


func _on_SwitchCollision_body_entered(body):
	moving = false
	orientation = body.get("orientation")
	coin_land_audio.play()
	emit_signal("check_moving_coins")
	set_target_position()


func _on_CoinCollision_combine(value):
	combine_coin()
	change_multiplier(value)


func _on_SwitchCollision_body_exited(_body):
	moving = true


func _on_Coin_tree_exited():
	emit_signal("check_moving_coins")


func _on_ShineTimer_timeout():
	can_shine = true


func set_multiplier(value):
	multiplier = value


func set_target_position():
	match orientation:
		Globals.LEFT:
			target_position = global_position + LEFT_TARGET
		Globals.RIGHT:
			target_position = global_position + RIGHT_TARGET
