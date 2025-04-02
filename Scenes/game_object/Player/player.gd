extends CharacterBody2D

@export var MAX_SPEED:int = 500
@export var gameover_sceen: PackedScene

@onready var collision_area = $CollisionArea2D
@onready var damage_interval_timer = $DamageInterValTimer
@onready var health_component = $HealthComponent
@onready var health_bar = $HealthBar
@onready var ability_manager = $AbilityManager
# collisionArea2d的用处是检测敌人进入 然后收到伤害
var number_collision_bodies = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_component.died.connect(on_died)
	collision_area.body_entered.connect(on_body_entered)
	collision_area.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(on_timeout_damage_timer)
	health_component.health_changed.connect(on_health_changed)
	GameEvent.event_upgrade_add.connect(on_event_upgrade_add)
	display_health()

func on_event_upgrade_add(upgrade: AbilityUpgrade, current_grade: Dictionary):
	if not upgrade is Ability:
		return
	ability_manager.add_child(upgrade.ability_controller_scene.instantiate())
	
	
func on_health_changed():
	display_health()

func display_health():
	health_bar.value = health_component.get_health_percent()

func on_died():
	var gameover_sceen_ins = gameover_sceen.instantiate()
	get_parent().add_child(gameover_sceen_ins)
	
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
