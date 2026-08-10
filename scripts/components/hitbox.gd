extends Area2D
## Hitbox
##
## Generic "I deal damage to whatever I touch" component. Detects Hurtbox
## areas entering it and calls take_hit() on them, passing damage plus a
## push-direction and force for knockback. Used both for the player's
## attack swing (toggled on/off by Combat) and an enemy's always-on
## contact damage - the same script, different usage.
##
## Also a permanent debug tool: while debug_visible is on, it draws its
## own collision area so hitbox reach/timing is visible during testing.
## This is a dev toggle meant to stay in the code, not scaffolding to
## delete - it'll likely just get switched off by default once real
## swing animations exist to show reach visually instead.
class_name Hitbox

@export var damage: int = 10
@export var knockback_force: float = 0.0
@export var debug_visible: bool = true


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _process(_delta: float) -> void:
	if debug_visible:
		queue_redraw()


func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		var direction := area.global_position - global_position
		if direction == Vector2.ZERO:
			direction = Vector2.RIGHT
		area.take_hit(damage, direction.normalized(), knockback_force)


func _draw() -> void:
	if not debug_visible:
		return
	var shape_node := get_node_or_null("CollisionShape2D") as CollisionShape2D
	if not shape_node or not (shape_node.shape is RectangleShape2D):
		return
	var size: Vector2 = (shape_node.shape as RectangleShape2D).size
	var color := Color(1, 0.3, 0.3, 0.5) if monitoring else Color(1, 0.3, 0.3, 0.15)
	draw_rect(Rect2(-size / 2.0, size), color)
