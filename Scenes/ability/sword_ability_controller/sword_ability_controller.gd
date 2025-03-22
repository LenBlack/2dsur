extends Node2D
const MAX_DIS:int = 200
@export var sword: PackedScene

var base_wait_time = 1.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)
	GameEvent.event_upgrade_add.connect(on_event_upgrade_add)

func on_event_upgrade_add(upgrade: AbilityUpgrade, current_grade: Dictionary):
	if upgrade.id != "sword_rate":
		return
	var upgrade_persent = current_grade["sword_rate"]["quantity"] * 0.1
	$Timer.wait_time = base_wait_time * (1-upgrade_persent)
	$Timer.start() # 因为默认是只启动一次，所以修改后需要手动重新启动Timer
	print("当前sword_rate:%.2f"%$Timer.wait_time)
	
func on_timer_timeout():
	var sword_instance = sword.instantiate() as Node2D
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	var enemes = get_tree().get_nodes_in_group("enemy")
	
	enemes = enemes.filter(func(enemy: Node2D):
		return enemy.global_position.distance_squared_to(player.global_position)<pow(MAX_DIS, 2)  
	)
	
	enemes.sort_custom(func(a:Node2D, b:Node2D):
		var disa = a.global_position.distance_squared_to(player.global_position)	
		var disb = b.global_position.distance_squared_to(player.global_position)
		return disa < disb
	)
	
	if enemes.size() == 0:
		return
	
	sword_instance.global_position = enemes[0].global_position
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	
	if foreground_layer == null:
		return
	foreground_layer.add_child(sword_instance)
	
