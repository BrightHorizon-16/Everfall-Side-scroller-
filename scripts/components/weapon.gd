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
