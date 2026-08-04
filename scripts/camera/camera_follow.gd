extends Camera2D
## CameraFollow
##
## Single responsibility: smoothly follow a target node's global position.
## Lives on the Camera node, which is a SIBLING of Player (not a child) so
## the follow behavior can be tuned/smoothed independently of the player's
## own transform.
class_name CameraFollow

@export var target_path: NodePath
@export var follow_speed: float = 5.0

var target: Node2D


func _ready() -> void:
	enabled = true
	if target_path != NodePath(""):
		target = get_node(target_path)


func _process(delta: float) -> void:
	if target:
		global_position = global_position.lerp(target.global_position, follow_speed * delta)
