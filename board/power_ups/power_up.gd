extends RigidBody2D

export(String) var pickup_text

onready var animation_player = $AnimationPlayer
onready var effects = $"../../AfterFreeEffects"


func _ready():
	animation_player.play("Appear")
	yield(animation_player, "animation_finished")
	animation_player.play("Idle")


func disappear():
	$BallCollision.queue_free()
	$CollisionShape2D.queue_free()
	$Sprite.visible = false
	$Sparkle.emitting = false


func pick_up():
	effects.instance_floating_text(pickup_text, global_position)
