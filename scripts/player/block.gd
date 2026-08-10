extends Node2D
## PlayerBlock
##
## Single responsibility: brief active block window on a button press,
## with a cooldown before it can be used again. While active, incoming
## damage is fully negated - Hurtbox checks is_blocking directly, this
## script doesn't touch Health itself. No partial block %, no stamina
## cost yet, since there's no stamina system to hook into.
##
## Extends Node2D (not Node) purely so it can draw a simple debug shield
## visual while active - otherwise blocking would be invisible to test.
class_name PlayerBlock

@export var block_duration: float = 0.4
@export var block_cooldown: float = 1.0
@export var debug_visible: bool = true

var is_blocking: bool = false
var _duration_timer: float = 0.0
var _cooldown_timer: float = 0.0


func _process(delta: float) -> void:
	if _cooldown_timer > 0.0:
		_cooldown_timer -= delta

	if is_blocking:
		_duration_timer -= delta
		if _duration_timer <= 0.0:
			is_blocking = false

	if Input.is_action_just_pressed("block") and _cooldown_timer <= 0.0 and not is_blocking:
		is_blocking = true
		_duration_timer = block_duration
		_cooldown_timer = block_duration + block_cooldown

	if debug_visible:
		queue_redraw()


func _draw() -> void:
	if not (debug_visible and is_blocking):
		return
	draw_circle(Vector2.ZERO, 20.0, Color(0.2, 0.6, 1.0, 0.4))
