extends Node
## Health
##
## Generic hit-point tracker. Attach as a child Node under any entity
## (Player, enemy, etc.) that needs HP. Deliberately knows nothing about
## who is attacking or how - Hitbox/Hurtbox handle that; this only tracks
## numbers and announces when they change or hit zero.
class_name Health

signal health_changed(current: int, max: int)
signal died

@export var max_health: int = 100

var current_health: int


func _ready() -> void:
	current_health = max_health


func take_damage(amount: int) -> void:
	if current_health <= 0:
		return
	current_health = max(current_health - amount, 0)
	health_changed.emit(current_health, max_health)
	if current_health <= 0:
		died.emit()


func heal(amount: int) -> void:
	current_health = min(current_health + amount, max_health)
	health_changed.emit(current_health, max_health)
