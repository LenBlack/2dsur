extends Node
# 管理和增加经验

signal experience_updated(current_exp:float, target_exp: float)
signal level_up(new_level:int)

const TARGE_EXP_GROTH = 1
var current_experience = 0
var target_experience = 2
var current_level = 1

func _ready() -> void:
	GameEvent.experience_vial_collected.connect(on_experience_vial_collected)

func increment_experience(number: float):
	current_experience = min(current_experience + number, target_experience)
	experience_updated.emit(current_experience, target_experience)
	if current_experience == target_experience:
		current_level+=1
		current_experience = 0
		target_experience += TARGE_EXP_GROTH
		experience_updated.emit(current_experience, target_experience)
		level_up.emit(current_level) # 发送升级的信号
	
func on_experience_vial_collected(number:float):
	increment_experience(number)
