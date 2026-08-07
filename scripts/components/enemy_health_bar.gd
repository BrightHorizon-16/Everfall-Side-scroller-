extends Node2D
## EnemyHealthBar
##
## Small world-space health bar drawn above whatever entity this is a
## child of. Generic - works for any entity with a sibling Health
## component, not just Chaser, so future enemy types can reuse it as-is.
class_name EnemyHealthBar

@export var bar_size: Vector2 = Vector2(28, 4)
@export var offset_above: float = 24.0

var _health: Health
var _health_percent: float = 1.0


func _ready() -> void:
	position = Vector2(0, -offset_above)
	_health = get_parent().get_node("Health")
	_health.health_changed.connect(_on_health_changed)
	queue_redraw()


func _on_health_changed(current: int, max_hp: int) -> void:
	_health_percent = float(current) / float(max_hp) if max_hp > 0 else 0.0
	queue_redraw()


func _draw() -> void:
	var half := bar_size / 2.0
	var top_left := -half
	draw_rect(Rect2(top_left, bar_size), Color(0.1, 0.1, 0.1, 0.8))
	var fill_width := bar_size.x * _health_percent
	draw_rect(Rect2(top_left, Vector2(fill_width, bar_size.y)), Color(0.8, 0.15, 0.15, 1))
