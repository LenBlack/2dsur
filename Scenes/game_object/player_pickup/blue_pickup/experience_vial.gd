extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.area_entered.connect(on_area_enter)
	
@warning_ignore("unused_parameter")
func on_area_enter(otherArea: Area2D):
	GameEvent.emit_experience_vial_collected(1)
	queue_free()
