extends Area2D
## Hurtbox
##
## Generic "this is where I can be hit" marker. Exposes take_hit() for a
## Hitbox to call, forwards damage to a sibling Health component, and
## triggers a sibling Knockback component if one exists. Also checks for
## an optional sibling "Block" component (Player-only) and skips damage
## entirely while it's active - Chaser has no Block node, so this never
## affects enemies. Attach as a child Area2D under any entity that also
## has a Health node.
class_name Hurtbox

## Optional override if Health isn't a direct sibling named "Health".
@export var health_path: NodePath
## Optional override if Knockback isn't a direct sibling named "Knockback".
@export var knockback_path: NodePath

var health: Health
var knockback: Knockback


func _ready() -> void:
	if health_path != NodePath(""):
		health = get_node(health_path)
	else:
		health = get_parent().get_node("Health")

	if knockback_path != NodePath(""):
		knockback = get_node(knockback_path)
	elif get_parent().has_node("Knockback"):
		knockback = get_parent().get_node("Knockback")


func take_hit(amount: int, knockback_direction: Vector2 = Vector2.ZERO, knockback_force: float = 0.0) -> void:
	if _is_blocking():
		return
	if health:
		health.take_damage(amount)
	if knockback:
		knockback.apply(knockback_direction, knockback_force)


func _is_blocking() -> bool:
	var blocker := get_parent().get_node_or_null("Block") as PlayerBlock
	return blocker != null and blocker.is_blocking
