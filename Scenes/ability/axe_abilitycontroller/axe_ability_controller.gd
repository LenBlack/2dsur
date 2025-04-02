extends Node2D

@export var axe_ability_scence: PackedScene
@export var axe_damage = 50

func _ready() -> void:
	var timer = $Timer
	timer.timeout.connect(on_timer_timeout)
	GameEvent.event_upgrade_add.connect(on_event_upgrade_add)
	
func on_event_upgrade_add(upgrade: AbilityUpgrade, current_grade: Dictionary):
	if upgrade.id != "axe":
		return 
	if current_grade["axe"]["quantity"] > 2:
		print("斧头技能已经最高")
		return
	
func on_timer_timeout():
	var axe_ability_scence_ins = axe_ability_scence.instantiate() as Node2D
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		print("player null")
		return 
	
	var foregroudlayer = get_tree().get_first_node_in_group("foreground_layer") as Node2D
	if foregroudlayer == null:
		return
		
	foregroudlayer.add_child(axe_ability_scence_ins)
	axe_ability_scence_ins.global_position = player.global_position
	axe_ability_scence_ins.hitbox.damage = axe_damage
