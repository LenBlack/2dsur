extends Node

@export var upgrade_pool: Array[AbilityUpgrade]
@export var experience_manager: Node
@export var upgrades_scence: PackedScene

# 字典保存的技能列表 技能resource 和 对应的等级
var currenct_upgrades = {}

func _ready() -> void:
	experience_manager.level_up.connect(on_level_up)
	
func pick_upgrade():
	var chosen_upgrades: Array[AbilityUpgrade] = []
	var filter_pool = upgrade_pool.duplicate() # 复制一份 
	# 这里要实现消除重复选择，所以要filter 为了避免对upgrade——pool的影响所以复制了一份
	for i in 2:
		var chosen_upgrade = filter_pool.pick_random()
		chosen_upgrades.append(chosen_upgrade)
		filter_pool = filter_pool.filter(func (upgrade): return chosen_upgrade.id != upgrade.id )
	return chosen_upgrades
	
func on_level_up(new_level:int):
	#从技能池中选择技能，如果技能被选择过就升级，如果没有选择过就新增
	var chosen_upgrades = pick_upgrade()
	var upgrade_scene_instance = upgrades_scence.instantiate()
	add_child(upgrade_scene_instance)
	upgrade_scene_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
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
	
	# 告诉全局选择了哪些技能
	GameEvent.emit_event_upgrade_add(upgrade, currenct_upgrades)
	
	print(currenct_upgrades)
