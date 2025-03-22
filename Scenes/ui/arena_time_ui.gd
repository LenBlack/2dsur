extends CanvasLayer

@export var arena_time_manager: Node
@onready var label = $MarginContainer/Label

func _process(delta: float) -> void:
	if arena_time_manager == null:
		return 
		
	var arena_time = arena_time_manager.get_time_elapsed()
	var arena_time_label = "时间：%.2fs"%arena_time
	label.text = arena_time_label
