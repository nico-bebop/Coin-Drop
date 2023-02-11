extends "res://board/moving_parts/ball.gd"

const SPARK_POSITIONS = [Vector2(8, -6), Vector2(5, -6), Vector2(2, -8)]

export(int) var ticks_left = 3

var ignited = false

onready var animated_sprite = $AnimatedSprite
onready var label = $Label
onready var spark = $Spark
onready var switch_collision = $SwitchCollision


func _ready():
	update_label()


func tick():
	if ignited:
		ticks_left -= 1
		update_label()
		update_animation()
	else:
		ignite()

	if ticks_left == 0:
		explode()


func update_label():
	label.text = str(ticks_left)


func update_animation():
	match ticks_left:
		3:
			animated_sprite.frame = 0
			spark.position = SPARK_POSITIONS[0]
		2:
			animated_sprite.frame = 1
			spark.position = SPARK_POSITIONS[1]
		1:
			animated_sprite.play("RedGlow")
			spark.position = SPARK_POSITIONS[2]


func ignite():
	ignited = true
	spark.emitting = true


func explode():
	get_colliding_switch().destroy_switch()
	queue_free()


func get_colliding_switch():
	for body in switch_collision.get_overlapping_bodies():
		if body.is_in_group(Globals.GROUP_SWITCHES):
			return body
