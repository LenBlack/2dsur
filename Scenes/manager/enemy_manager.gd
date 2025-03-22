extends Node

@export var basic_enemy_scene:PackedScene
const MAX_VIWE:int = 350

func _ready() -> void:
	$Timer.timeout.connect(on_timeout)
	
	
func on_timeout():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node == null:
		return 
	
	# 生成一个随机的方向
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var basic_enemy = basic_enemy_scene.instantiate() as Node2D
	basic_enemy.global_position = player_node.global_position + (random_direction * MAX_VIWE)
	var entity_layer = get_tree().get_first_node_in_group("entity_layer")
	
	if entity_layer == null:
		return 
	
	entity_layer.add_child(basic_enemy)
	
