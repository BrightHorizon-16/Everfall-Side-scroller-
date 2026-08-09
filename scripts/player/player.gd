extends CharacterBody2D
## Player
##
## Thin coordinator for the Player root. Individual concerns (movement,
## combat, health tracking) live in their own child components; this only
## reacts to top-level events that need to affect the whole entity.
##
## Both combat death (Health's "died" signal) and falling out of the
## world (KillPlane, via reset_to_spawn()) end up doing the same thing
## for the player - reset to spawn, full health.
class_name Player

var respawn_position: Vector2

@onready var health: Health = $Health


func _ready() -> void:
	respawn_position = global_position
	health.died.connect(_on_died)


func _on_died() -> void:
	reset_to_spawn()


func reset_to_spawn() -> void:
	global_position = respawn_position
	velocity = Vector2.ZERO
	health.current_health = health.max_health
	health.health_changed.emit(health.current_health, health.max_health)
