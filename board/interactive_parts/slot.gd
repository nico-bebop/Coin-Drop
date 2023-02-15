extends Area2D

var clickable = false

onready var animated_sprite = $AnimatedSprite
onready var balls = $"../../Balls"

signal coin_dropped


func _on_Slot_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click") && clickable:
		if !animated_sprite.visible:
			animated_sprite.visible = true
			return

		emit_signal("coin_dropped")
		yield(animated_sprite, "animation_finished")
		animated_sprite.visible = false
		balls.spawn_coin(global_position)


func _on_Slot_mouse_entered():
	if clickable:
		animated_sprite.visible = true


func _on_Slot_mouse_exited():
	if clickable:
		animated_sprite.visible = false
