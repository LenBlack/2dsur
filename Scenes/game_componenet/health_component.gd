extends Node
class_name HealthComponent

@export var max_health:int
signal  died
signal health_changed

var current_health

func _ready() -> void:
	current_health = max_health

func on_damage(damage_amount: float):
	current_health = max(current_health - damage_amount, 0)	
	health_changed.emit()
	Callable(check_died).call_deferred() 
	# 延迟调用 因为godot需要完成物理检测之后，才能修改场景树，释放节点


func get_health_percent():
	if max_health <= 0:
		return 0
	return min(current_health/max_health, 1)
	
func check_died():
	if current_health == 0:
		died.emit()
		owner.queue_free() # 释放拥有这个组件的节点
		
	
