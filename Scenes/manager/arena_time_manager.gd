extends Node

@onready var timer = $Timer
@export var vitory_screen: PackedScene

func _ready() -> void:
	timer.timeout.connect(on_timeout)

func get_time_elapsed():
	return timer.wait_time - timer.time_left

func on_timeout():
	var victory_screen_ins = vitory_screen.instantiate()
	add_child(victory_screen_ins)
