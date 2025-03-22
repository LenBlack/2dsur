#extends Camera2D
#
#var target_position = Vector2.ZERO
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#make_current()
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#acquire_target()
	## 增加相机移动的平滑效果 后面这个数学表达式的效果是实现 平滑效果和帧率无关
	##global_position = target_position
	#global_position = global_position.lerp(target_position, 1.0-exp(-delta * 10))
	#
	#
#func acquire_target():
	## 获取player的位置
	#var player_nodes = get_tree().get_nodes_in_group("player")
	#if player_nodes.size() > 0:
		#var player = player_nodes[0] as Node2D
		#target_position = player.global_position
