extends Position2D

const VELOCITY = Vector2(0, -15)

onready var label = $Label
onready var timer = $Timer

var text = ""


func _ready():
	label.text = text
	timer.start()


func _process(delta):
	position += VELOCITY * delta


func _on_Timer_timeout():
	queue_free()
