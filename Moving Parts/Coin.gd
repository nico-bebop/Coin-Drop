extends RigidBody2D

const LAST_FRAME = 9
const MAX_MULTIPLIER = 5
const MAX_SPEED = 200.0

var orientation = null
var is_moving = true
var can_shine = true
var multiplier = 1 setget set_multiplier

onready var animation_player = $AnimationPlayer
onready var coin_collision = $CoinCollision
onready var coin_land_audio = $CoinLandAudio
onready var label = $Label
onready var shine_timer = $ShineTimer
onready var sprite = $Sprite

signal check_moving_coins


func _ready():
	var _err = connect("check_moving_coins", get_parent(), "get_active_coins")


func _physics_process(_delta):
	if !is_moving && can_shine:
		shine_timer.start()
		animation_player.play("IdleShine")
		can_shine = false


func _integrate_forces(_state):
	linear_velocity = linear_velocity.limit_length(MAX_SPEED)


func _on_SwitchCollision_body_entered(body):
	is_moving = false
	orientation = body.get("orientation")
	coin_land_audio.play()
	emit_signal("check_moving_coins")


func _on_SwitchCollision_body_exited(_body):
	is_moving = true


func _on_Coin_tree_exited():
	emit_signal("check_moving_coins")


func _on_CoinCollision_combine(value):
	animation_player.play("HorizontalFlip")
	yield(animation_player, "animation_finished")
	multiplier = clamp(value, multiplier, MAX_MULTIPLIER)
	label.text = str(multiplier)


func _on_ShineTimer_timeout():
	can_shine = true


func set_multiplier(value):
	multiplier = value
