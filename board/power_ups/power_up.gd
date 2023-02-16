extends RigidBody2D

onready var animation_player = $AnimationPlayer
onready var destroy_audio = $DestroyAudio
onready var power_up_audio = $PowerUpAudio


func _ready():
	animation_player.play("Appear")
	yield(animation_player, "animation_finished")
	animation_player.play("Idle")


func disappear():
	$BallCollision.queue_free()
	$CollisionShape2D.queue_free()
	$Sprite.visible = false
	$Sparkle.emitting = false
