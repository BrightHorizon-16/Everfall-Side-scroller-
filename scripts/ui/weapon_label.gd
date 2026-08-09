extends Label
## WeaponLabel
##
## Shows the player's currently equipped weapon name in the UI. Listens
## to PlayerCombat's weapon_changed signal rather than polling.
class_name WeaponLabel


func _ready() -> void:
	var player := get_tree().get_first_node_in_group("player")
	if player:
		var combat: PlayerCombat = player.get_node("Combat")
		combat.weapon_changed.connect(_on_weapon_changed)
		if combat.equipped_weapon:
			_on_weapon_changed(combat.equipped_weapon)


func _on_weapon_changed(weapon: Weapon) -> void:
	text = "Weapon: %s" % weapon.weapon_name
