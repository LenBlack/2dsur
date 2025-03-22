extends Area2D
class_name HurtBoxComponent
@export var health_component:HealthComponent

# 这个组件是用来 收到伤害的
func _ready() -> void:
	area_entered.connect(on_area_enter)
	
func on_area_enter(otherArea: Area2D):
	if not otherArea is HitBoxComponent:
		print("攻击的不是hitbox类型")
		return
	if health_component == null:
		print("没有健康组件")
		return

	health_component.on_damage((otherArea as HitBoxComponent).damage)
	
