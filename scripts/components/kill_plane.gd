extends Area2D
## KillPlane
##
## Generic instant-death trigger for anything with a Health component that
## touches it. Used for level boundaries (falling off the map) - reuses
## the same Health -> "died" signal pipeline as normal combat death, so
## respawn (Player) / despawn (enemies) behavior doesn't get duplicated.
class_name KillPlane


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	var health := body.get_node_or_null("Health") as Health
	if health:
		health.take_damage(health.max_health)
