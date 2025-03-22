extends Node

signal	experience_vial_collected(number:float)
signal event_upgrade_add(upgrade: AbilityUpgrade, current_grade: Dictionary)

# 发射信号
func emit_experience_vial_collected(number: float):
	experience_vial_collected.emit(number)
	
# 全局发送升级的技能的信号
func emit_event_upgrade_add(upgrade: AbilityUpgrade, current_grade: Dictionary):
	event_upgrade_add.emit(upgrade, current_grade)
