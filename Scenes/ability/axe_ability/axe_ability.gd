extends Node2D

const MAX_RADIUS = 100
@onready var hitbox = $HitBoxComponent
func _ready() -> void:
	var tween = create_tween()
	tween.tween_method(rotate_axe, 0., 2., 2)
	tween.tween_callback(queue_free)

func rotate_axe(rotation: float):
	var current_direction = Vector2.RIGHT.rotated(rotation *  TAU * 0.5)
	var player = get_tree().get_first_node_in_group("player") as Node2D
	global_position = player.global_position + (current_direction * MAX_RADIUS)
	
