extends Area2D
## Hitbox
##
## Generic "I deal damage to whatever I touch" component. Detects Hurtbox
## areas entering it and calls take_hit() on them. Used both for the
## player's attack swing (toggled on/off by Combat) and an enemy's
## always-on contact damage - the same script, different usage.
class_name Hitbox

@export var damage: int = 10


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		area.take_hit(damage)
