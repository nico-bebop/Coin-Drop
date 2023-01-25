extends RigidBody2D

const LAST_FRAME = 4

var orientation = null
var is_moving = true
var value = 1

onready var coin_collision = $CoinCollision
onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite


func _on_SwitchCollision_body_entered(body):
	is_moving = false
	orientation = body.get("orientation")


func _on_SwitchCollision_body_exited(_body):
	is_moving = true


func _on_CoinCollision_combine(new_value):
	animation_player.play("HorizontalFlip")
	yield(animation_player, "animation_finished")
	value = new_value
	sprite.frame = LAST_FRAME + value
