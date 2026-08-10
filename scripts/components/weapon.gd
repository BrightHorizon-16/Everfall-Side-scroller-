extends Resource
## Weapon
##
## Data-only definition of a melee weapon's basic stats. Combat.gd reads
## from whichever Weapon is currently equipped instead of having stats
## hardcoded in the script - this is what lets weapons be swapped later
## via inventory without touching Combat's code.
##
## Movesets (combo chains, heavy attacks, poise damage, crit chance) are
## NOT modeled yet - deferred to a later milestone. This only covers a
## single basic attack per weapon.
class_name Weapon

@export var weapon_name: String = "Weapon"
@export var damage: int = 10
@export var attack_duration: float = 0.2
@export var attack_cooldown: float = 0.3
## How far in front of the player the hitbox is placed.
@export var hitbox_reach: float = 16.0
@export var hitbox_size: Vector2 = Vector2(20, 24)
@export var knockback_force: float = 200.0

## Placeholder visual only - a flat polygon silhouette, not real art. No
## image-generation tool is available in this environment, so this is as
## far as "seeing the weapon" goes for now. Points are local to the
## Hitbox's origin, drawn pointing away from the player (+X); Combat.gd
## mirrors the whole Hitbox via scale.x so it flips correctly either way.
@export var silhouette: PackedVector2Array = PackedVector2Array()
@export var silhouette_color: Color = Color(0.8, 0.8, 0.8, 1)
