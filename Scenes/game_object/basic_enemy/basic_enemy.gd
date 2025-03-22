extends CharacterBody2D
const MAX_SPEED = 200


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player_direction = get_player_direction()
	velocity = player_direction * MAX_SPEED
	move_and_slide()


func get_player_direction():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
	
	return Vector2.ZERO
