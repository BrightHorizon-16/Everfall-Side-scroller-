extends Area2D
## EndPoint
##
## Goal trigger for a region. When the player reaches it, emits a signal
## (for UI to react to) and loops them back to the region's spawn point.
## There's no next region to send them to yet and no win/save system -
## this is a testable checkpoint, not a full level-complete system.
class_name EndPoint

signal reached


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		reached.emit()
		if body.has_method("reset_to_spawn"):
			body.reset_to_spawn()
