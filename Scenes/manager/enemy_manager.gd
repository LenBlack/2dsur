extends Node

@export var basic_enemy_scene:PackedScene

@onready var timer = $Timer
const MAX_VIWE:int = 350
var enemy_span_time = 1

func _ready() -> void:
	timer.wait_time = enemy_span_time
	timer.timeout.connect(on_timeout)
	
func get_spawn_position():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node == null:
		return 
	
	# 生成一个随机的方向
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_postion = Vector2.ZERO
	for i in 4:
		spawn_postion = player_node.global_position + (random_direction * MAX_VIWE)
		var query_parameters = PhysicsRayQueryParameters2D.create(player_node.global_position, spawn_postion, 1)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)
		if result.is_empty(): # 说明没有玩家和生成的敌人生成的射线直接没有墙的碰撞
			return spawn_postion
		else:
			random_direction = random_direction.rotated(deg_to_rad(90)) 
	
func on_timeout():
	timer.wait_time = max(timer.wait_time * 0.9, 0.2)
	timer.start()
	var basic_enemy = basic_enemy_scene.instantiate() as Node2D
	basic_enemy.global_position = get_spawn_position()
	var entity_layer = get_tree().get_first_node_in_group("entity_layer")
	
	if entity_layer == null:
		return 
	
	entity_layer.add_child(basic_enemy)
	
