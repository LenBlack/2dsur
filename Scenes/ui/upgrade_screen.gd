extends CanvasLayer

@export var upgrade_card: PackedScene
@onready var cards_container:HBoxContainer = $%CardsContainer

signal upgrade_selected(upgrade: AbilityUpgrade)

func _ready() -> void:
	get_tree().paused = true
	## debug
	#var card_instance = upgrade_card.instantiate()
	## 这里有个坑 一定要先add 进入场景树在 引用
	#cards_container.add_child(card_instance)

## 技能池进行赋值操作
func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
	if cards_container == null:
		print("null")
		return 
	if upgrades.size() == 0:
		return 
	for upgrade in upgrades:
		var card_instance = upgrade_card.instantiate()
		# 这里有个坑 一定要先add 进入场景树在 引用
		cards_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
		card_instance.selected.connect(on_upgrade_selected.bind(upgrade))
		
		
func on_upgrade_selected(upgrade: AbilityUpgrade):
	upgrade_selected.emit(upgrade)
	get_tree().paused = false
	queue_free()
		
