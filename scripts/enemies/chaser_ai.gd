extends Node
## ChaserAI
##
## Single responsibility: move the Chaser toward the player when in range.
## Simplest enemy archetype in the design doc ("staggered easily, weak to
## fast weapons") - no ranged attacks, no special patterns. Contact damage
## is handled separately by an always-on Hitbox, not by this script.
class_name ChaserAI

@export var move_speed: float = 120.0
@export var detection_range: float = 250.0
@export var gravity: float = 980.0

@onready var body: CharacterBody2D = get_parent()

var player: Node2D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_chase_player()
	body.move_and_slide()


func _apply_gravity(delta: float) -> void:
	if not body.is_on_floor():
		body.velocity.y += gravity * delta


func _chase_player() -> void:
	if player and body.global_position.distance_to(player.global_position) <= detection_range:
		var direction := signf(player.global_position.x - body.global_position.x)
		body.velocity.x = direction * move_speed
	else:
		body.velocity.x = move_toward(body.velocity.x, 0.0, move_speed)
