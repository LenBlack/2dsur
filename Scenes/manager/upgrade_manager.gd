extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: Node
@export var upgrades_scence: PackedScene

# 字典保存的技能列表 技能resource 和 对应的等级
var currenct_upgrades = {}

func _ready() -> void:
	experience_manager.level_up.connect(on_level_up)
	
func on_level_up(new_level:int):
	#从技能池中选择技能，如果技能被选择过就升级，如果没有选择过就新增
	var chosen_upgrade = upgrade_pool.pick_random()
	print(chosen_upgrade)
	if chosen_upgrade == null:
		print("No resource")
		return 
		
	var upgrade_scene_instance = upgrades_scence.instantiate()
	add_child(upgrade_scene_instance)
	upgrade_scene_instance.set_ability_upgrades([chosen_upgrade] as Array[AbilityUpgrade])
	upgrade_scene_instance.upgrade_selected.connect(on_upgrade_selected)
		
func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)

func apply_upgrade(upgrade: AbilityUpgrade):
	
	var has_upgrade = currenct_upgrades.has(upgrade.id)
	
	if !has_upgrade:
		currenct_upgrades[upgrade.id] = {
			"resource": upgrade,
			"quantity": 1
		}
	else:
		currenct_upgrades[upgrade.id]["quantity"] += 1
		
	GameEvent.emit_event_upgrade_add(upgrade, currenct_upgrades)
	
	print(currenct_upgrades)
