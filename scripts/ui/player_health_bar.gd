extends ProgressBar
## PlayerHealthBar
##
## Displays the player's current HP in the fixed UI. Finds the Player via
## the "player" group and listens to its Health component - doesn't need
## a direct scene reference, so it keeps working if Player's position in
## the tree changes.
class_name PlayerHealthBar


func _ready() -> void:
	show_percentage = false
	var player := get_tree().get_first_node_in_group("player")
	if player:
		var health: Health = player.get_node("Health")
		health.health_changed.connect(_on_health_changed)
		_on_health_changed(health.current_health, health.max_health)


func _on_health_changed(current: int, max_hp: int) -> void:
	max_value = max_hp
	value = current
