extends Area2D

const Coin = preload("res://board/moving_parts/coin.tscn")
const Bomb = preload("res://board/moving_parts/bomb.tscn")

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
		spawn_coin()


func spawn_coin():
	var coin = Coin.instance()
	coin.position = global_position
	balls.call_deferred("add_child", coin)


func spawn_bomb():
	var bomb = Bomb.instance()
	bomb.position = global_position
	bomb_alert()
	yield(animated_sprite, "animation_finished")
	balls.call_deferred("add_child", bomb)


func bomb_alert():
	animated_sprite.visible = true
	animated_sprite.play("BombAlert")
	yield(animated_sprite, "animation_finished")
	animated_sprite.visible = false
	animated_sprite.animation = "HorizontalFlip"


func _on_Slot_mouse_entered():
	if clickable:
		animated_sprite.visible = true


func _on_Slot_mouse_exited():
	if clickable:
		animated_sprite.visible = false
