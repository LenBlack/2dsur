extends Node
@export var vial_experince_scence: PackedScene
@export var health_component:HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_component.died.connect(on_died)
	

func on_died():
	if owner == null:
		return
	
	if vial_experince_scence == null:
		return
		
	var owner_pos = (owner as Node2D).global_position
	var vial_experince_instance = vial_experince_scence.instantiate() as Node2D	
	var entity_layer = get_tree().get_first_node_in_group("entity_layer")
	
	if entity_layer == null:
		return 
	entity_layer.add_child(vial_experince_instance)
	vial_experince_instance.global_position = owner_pos
