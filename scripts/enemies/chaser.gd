extends CharacterBody2D
## Chaser
##
## Thin coordinator for the Chaser root, mirroring Player's pattern.
##
## Combat death (Health's "died" signal - defeated by the player)
## despawns it entirely, same as before. Falling out of the world
## (KillPlane, via reset_to_spawn()) is handled separately - it resets
## back to its spawn point instead, so a testing enemy doesn't just
## vanish because its pathing sent it into a pit.
class_name Chaser

var _spawn_position: Vector2

@onready var health: Health = $Health


func _ready() -> void:
	_spawn_position = global_position
	health.died.connect(_on_died)


func _on_died() -> void:
	queue_free()


func reset_to_spawn() -> void:
	global_position = _spawn_position
	velocity = Vector2.ZERO
	health.current_health = health.max_health
	health.health_changed.emit(health.current_health, health.max_health)
