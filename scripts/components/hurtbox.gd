extends Area2D
## Hurtbox
##
## Generic "this is where I can be hit" marker. Exposes take_hit() for a
## Hitbox to call, and forwards the damage to a sibling Health component.
## Attach as a child Area2D under any entity that also has a Health node.
class_name Hurtbox

## Optional override if Health isn't a direct sibling named "Health".
@export var health_path: NodePath

var health: Health


func _ready() -> void:
	if health_path != NodePath(""):
		health = get_node(health_path)
	else:
		health = get_parent().get_node("Health")


func take_hit(amount: int) -> void:
	if health:
		health.take_damage(amount)
