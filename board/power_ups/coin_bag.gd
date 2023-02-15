extends RigidBody2D

const COINS_IN_BAG = 5

onready var animation_player = $AnimationPlayer
onready var destroy_audio = $DestroyAudio
onready var power_up_audio = $PowerUpAudio

signal throw_coins(quantity)


func _ready():
	var _err = connect("throw_coins", get_tree().current_scene, "throw_random_coins")
	animation_player.play("Appear")
	yield(animation_player, "animation_finished")
	animation_player.play("Idle")


func _on_BallCollision_body_entered(body):
	disappear()

	if body.is_in_group(Globals.GROUP_COINS):
		emit_signal("throw_coins", COINS_IN_BAG)
		for coin in COINS_IN_BAG:
			power_up_audio.play()
			yield(get_tree().create_timer(0.3), "timeout")

	elif body.is_in_group(Globals.GROUP_BOMBS):
		destroy_audio.play()
		yield(destroy_audio, "finished")

	queue_free()


func disappear():
	$BallCollision.queue_free()
	$CollisionShape2D.queue_free()
	$Sprite.visible = false
	$Sparkle.emitting = false
