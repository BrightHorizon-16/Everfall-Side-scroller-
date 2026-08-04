extends Node
## PlayerMovement
##
## Single responsibility: horizontal movement, jumping, and gravity for the
## Player it is attached under. Nothing else (no combat, no health, no
## animation) lives in this script on purpose.
##
## Expected setup: attach to a "Movement" child Node under a CharacterBody2D
## named "Player". Reads input actions "move_left", "move_right", "jump".
class_name PlayerMovement

@export var speed: float = 300.0
@export var jump_velocity: float = -400.0
@export var gravity: float = 980.0

@onready var body: CharacterBody2D = get_parent()

## 1 = facing right, -1 = facing left. Read by Combat to place the hitbox.
var facing_direction: int = 1


func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_handle_jump()
	_handle_horizontal_movement()
	body.move_and_slide()


func _apply_gravity(delta: float) -> void:
	if not body.is_on_floor():
		body.velocity.y += gravity * delta


func _handle_jump() -> void:
	if Input.is_action_just_pressed("jump") and body.is_on_floor():
		body.velocity.y = jump_velocity


func _handle_horizontal_movement() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0.0:
		body.velocity.x = direction * speed
		facing_direction = int(signf(direction))
	else:
		body.velocity.x = move_toward(body.velocity.x, 0.0, speed)
