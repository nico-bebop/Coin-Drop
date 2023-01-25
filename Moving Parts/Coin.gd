extends RigidBody2D

const LAST_FRAME = 9

var orientation = null
var is_moving = true
var value = 1
var can_shine = true

onready var coin_collision = $CoinCollision
onready var animation_player = $AnimationPlayer
onready var sprite = $Sprite
onready var shine_timer = $ShineTimer


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


func _on_CoinCollision_combine(new_value):
	animation_player.play("HorizontalFlip")
	yield(animation_player, "animation_finished")
	value = new_value
	sprite.frame = LAST_FRAME + value


func _on_ShineTimer_timeout():
	can_shine = true
