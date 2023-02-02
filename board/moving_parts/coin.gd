extends KinematicBody2D

const MAX_MULTIPLIER = 5
const MAX_SPEED = 500
const ACCELERATION = 200
const LEFT_TARGET = Vector2(20, 2)
const RIGHT_TARGET = Vector2(-20, 2)

var can_shine = true
var direction = Globals.DOWN
var multiplier = 1 setget set_multiplier
var is_moving = true
var orientation = null
var target_position
var velocity = Vector2.ZERO

onready var animation_player = $AnimationPlayer
onready var coin_collision = $CoinCollision
onready var coin_combine_audio = $CoinCombineAudio
onready var coin_land_audio = $CoinLandAudio
onready var label = $Label
onready var shine_timer = $ShineTimer
onready var sparkle_effect = $Sparkle

signal check_moving_coins


func _ready():
	var _err = connect("check_moving_coins", get_parent(), "check_active_coins")


func _physics_process(delta):
	play_idle_animation()
	process_movement(delta)
	velocity = move_and_slide(velocity)


func process_movement(delta):
	match direction:
		Globals.DOWN:
			velocity = velocity.move_toward(Vector2.DOWN * MAX_SPEED, ACCELERATION * delta)
		Globals.LEFT, Globals.RIGHT:
			is_moving = true
			global_position = global_position.move_toward(target_position, ACCELERATION / 2.0 * delta)

	if global_position == target_position:
		direction = Globals.DOWN


func play_idle_animation():
	if !is_moving && can_shine:
		shine_timer.start()
		animation_player.play("IdleShine")
		can_shine = false


func combine(coins):
	if coins[0].is_moving && coins[1].is_moving:
		play_combine_effects()
		change_multiplier(coins[0].multiplier + coins[1].multiplier)
		coins[0].queue_free()


func play_combine_effects():
	animation_player.stop()
	animation_player.play("HorizontalFlip")
	coin_combine_audio.play()
	sparkle_effect.emitting = true


func change_multiplier(value):
	yield(animation_player, "animation_finished")
	multiplier = clamp(value, multiplier, MAX_MULTIPLIER)
	label.text = str(multiplier)


func _on_CoinCollision_body_entered(_body):
	if !is_moving:
		direction = orientation

	var bodies = coin_collision.get_overlapping_bodies()
	if bodies.size() > 1:
		combine(bodies)


func _on_SwitchCollision_body_entered(body):
	is_moving = false
	orientation = body.get("orientation")
	coin_land_audio.play()
	emit_signal("check_moving_coins")
	set_target_position()


func _on_SwitchCollision_body_exited(_body):
	is_moving = true


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
