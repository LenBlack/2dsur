extends CharacterBody2D

@export var MAX_SPEED:int = 500
@onready var collision_area = $CollisionArea2D
@onready var damage_interval_timer = $DamageInterValTimer
@onready var health_component = $HealthComponent
# collisionArea2d的用处是检测敌人进入 然后收到伤害
var number_collision_bodies = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_component.died.connect(on_died)
	collision_area.body_entered.connect(on_body_entered)
	collision_area.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(on_timeout_damage_timer)

func on_died():
	print("Player died!")
	
func on_timeout_damage_timer():
	check_damage()
	
func check_damage():
	if number_collision_bodies == 0:
		return
	$HealthComponent.on_damage(1)
	damage_interval_timer.start()
	print($HealthComponent.current_health)

func on_body_entered(body: Node2D):
	number_collision_bodies += 1
	check_damage()
	
	
func on_body_exited(body: Node2D):
	number_collision_bodies -= 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movemont_vector = get_movement_vector()
	var direction = movemont_vector.normalized()
	var targe_velocity = direction * MAX_SPEED
	velocity = velocity.lerp(targe_velocity, 1.0-exp(-delta * 15))
	move_and_slide() # 按照velocity进行移动


func get_movement_vector() -> Vector2:
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)
