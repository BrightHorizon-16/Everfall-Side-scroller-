extends Node
## Knockback
##
## Generic decaying-impulse knockback, usable by Player or any enemy.
## While active, overrides this frame's horizontal velocity (set earlier
## by Movement/ChaserAI) with the knockback velocity instead - so this
## node must come AFTER the movement component in the scene tree's node
## order, since siblings process in that order and this needs to run
## later in the frame to win.
class_name Knockback

@export var friction: float = 900.0  ## How fast the knockback velocity decays.

@onready var body: CharacterBody2D = get_parent()

var _velocity: Vector2 = Vector2.ZERO
var _active: bool = false


func apply(direction: Vector2, force: float) -> void:
	if direction == Vector2.ZERO or force <= 0.0:
		return
	_velocity = direction.normalized() * force
	_active = true


func _physics_process(delta: float) -> void:
	if not _active:
		return
	body.velocity.x = _velocity.x
	_velocity = _velocity.move_toward(Vector2.ZERO, friction * delta)
	if _velocity.length() < 10.0:
		_active = false
