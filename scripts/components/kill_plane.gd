extends Area2D
## KillPlane
##
## Resets anything with a reset_to_spawn() method back to its spawn point
## when it touches this - used for level boundaries (falling off the
## map). Deliberately separate from the Health/combat-damage pipeline:
## falling out of the world isn't a combat death, so it doesn't go
## through take_damage() and won't trigger despawn-on-death logic that's
## meant for actually being defeated in a fight.
class_name KillPlane


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("reset_to_spawn"):
		body.reset_to_spawn()
