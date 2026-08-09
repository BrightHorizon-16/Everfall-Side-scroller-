extends Node
## ChaserAI
##
## Single responsibility: move the Chaser toward the player when in
## range, and jump over gaps in its path so basic platforming terrain
## doesn't strand it. Uses a single RayCast2D ("LedgeRay", a sibling
## node) repositioned each frame to look slightly ahead of the direction
## of travel - if it finds no ground there, it jumps. No wall-climbing,
## no pathfinding around obstacles - deliberately simple, matching the
## Chaser's identity as the simplest enemy archetype.
class_name ChaserAI

@export var move_speed: float = 220.0
@export var detection_range: float = 250.0
@export var gravity: float = 980.0
@export var jump_velocity: float = -400.0
@export var ledge_check_ahead: float = 24.0
@export var ledge_check_depth: float = 40.0

@onready var body: CharacterBody2D = get_parent()
@onready var ledge_ray: RayCast2D = get_parent().get_node("LedgeRay")

var player: Node2D
var _facing_direction: int = 1
var _is_moving: bool = false


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_chase_player()
	_update_ledge_ray()
	_check_jump()
	body.move_and_slide()


func _apply_gravity(delta: float) -> void:
	if not body.is_on_floor():
		body.velocity.y += gravity * delta


func _chase_player() -> void:
	if player and body.global_position.distance_to(player.global_position) <= detection_range:
		var direction := signf(player.global_position.x - body.global_position.x)
		body.velocity.x = direction * move_speed
		_is_moving = direction != 0.0
		if _is_moving:
			_facing_direction = int(direction)
	else:
		body.velocity.x = move_toward(body.velocity.x, 0.0, move_speed)
		_is_moving = false


func _update_ledge_ray() -> void:
	ledge_ray.position = Vector2(ledge_check_ahead * _facing_direction, 0)
	ledge_ray.target_position = Vector2(0, ledge_check_depth)
	ledge_ray.force_raycast_update()


func _check_jump() -> void:
	if _is_moving and body.is_on_floor() and not ledge_ray.is_colliding():
		body.velocity.y = jump_velocity
