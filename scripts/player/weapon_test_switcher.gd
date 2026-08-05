extends Node
## WeaponTestSwitcher
##
## TEMPORARY test-only scaffolding. Lets you swap the player's equipped
## weapon with number keys since there's no inventory system yet.
## Delete this whole node/script once real weapon-swapping (inventory,
## pickups, etc.) exists - it's not meant to survive to that point.
class_name WeaponTestSwitcher

@export var sword: Weapon
@export var dagger: Weapon
@export var spear: Weapon

@onready var combat: PlayerCombat = get_parent().get_node("Combat")


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		match event.physical_keycode:
			KEY_1:
				combat.equip_weapon(sword)
			KEY_2:
				combat.equip_weapon(dagger)
			KEY_3:
				combat.equip_weapon(spear)
