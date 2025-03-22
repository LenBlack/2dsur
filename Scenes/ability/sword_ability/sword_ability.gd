extends Node2D
class_name SwordAbility

# 这样写的原因：swordinstance一旦实例化，就立刻拥有对hitbox组件功能的访问
@onready var hitbox_component: HitBoxComponent = $HitBoxComponent
