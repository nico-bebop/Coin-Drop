extends RigidBody2D

const MAX_MULTIPLIER = 5
const MAX_SPEED = 150.0

var orientation = null
var can_shine = true
var multiplier = 1 setget set_multiplier

onready var animation_player = $AnimationPlayer
onready var coin_combine_audio = $CoinCombineAudio
onready var coin_land_audio = $CoinLandAudio
onready var label = $Label
onready var shine_timer = $ShineTimer
onready var sparkle_effect = $Sparkle

signal check_sleeping_coins


func _ready():
	var _err = connect("check_sleeping_coins", get_parent(), "check_active_coins")


func _physics_process(_delta):
	if sleeping && can_shine:
		shine_timer.start()
		animation_player.play("IdleShine")
		can_shine = false


func _integrate_forces(_state):
	linear_velocity = linear_velocity.limit_length(MAX_SPEED)


func _on_SwitchCollision_body_entered(body):
	sleeping = true
	orientation = body.get("orientation")
	coin_land_audio.play()
	emit_signal("check_sleeping_coins")


func _on_SwitchCollision_body_exited(_body):
	sleeping = false


func _on_Coin_tree_exited():
	emit_signal("check_sleeping_coins")


func _on_CoinCollision_combine(value):
	animation_player.play("HorizontalFlip")
	coin_combine_audio.play()
	sparkle_effect.emitting = true
	yield(animation_player, "animation_finished")
	multiplier = clamp(value, multiplier, MAX_MULTIPLIER)
	label.text = str(multiplier)


func _on_ShineTimer_timeout():
	can_shine = true


func set_multiplier(value):
	multiplier = value
