extends PanelContainer

@onready var abilityname = $VBoxContainer/name
@onready var abilitydes = $VBoxContainer/description

signal selected

func _ready() -> void:
	gui_input.connect(on_gui_input)
	
## 这是一个为单个技能卡片UI赋值的函数
func set_ability_upgrade(upgrade: AbilityUpgrade):
	abilityname.text = upgrade.name
	abilitydes.text = upgrade.description

func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_mouse_down"):
		print("鼠标点击选择了")
		selected.emit()
