extends RigidBody2D

const LAST_FRAME = 9
const MAX_MULTIPLIER = 5

var orientation = null
var is_moving = true
var can_shine = true
var multiplier = 1 setget set_multiplier

onready var coin_collision = $CoinCollision
onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite
onready var shine_timer = $ShineTimer
onready var label = $Label


func _physics_process(_delta):
	if !is_moving && can_shine:
		shine_timer.start()
		animation_player.play("IdleShine")
		can_shine = false


func _on_SwitchCollision_body_entered(body):
	is_moving = false
	orientation = body.get("orientation")


func _on_SwitchCollision_body_exited(_body):
	is_moving = true


func _on_CoinCollision_combine(value):
	animation_player.play("HorizontalFlip")
	yield(animation_player, "animation_finished")
	multiplier = clamp(value, multiplier, MAX_MULTIPLIER)
	label.text = str(multiplier)


func _on_ShineTimer_timeout():
	can_shine = true


func set_multiplier(value):
	multiplier = value
