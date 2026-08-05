extends Node
## PlayerCombat
##
## Single responsibility: trigger an attack using whichever Weapon is
## currently equipped, and position/activate the Hitbox while swinging.
## All stats (damage, speed, reach) come from the equipped Weapon
## resource - this script doesn't know or care which weapon it is. No
## combo chains, no heavy attacks yet - deferred to a later milestone.
class_name PlayerCombat

@export var equipped_weapon: Weapon

@onready var hitbox: Hitbox = get_parent().get_node("Hitbox")
@onready var hitbox_shape: CollisionShape2D = hitbox.get_node("CollisionShape2D")
@onready var movement: PlayerMovement = get_parent().get_node("Movement")

var _cooldown_timer: float = 0.0
var _attack_timer: float = 0.0


func _ready() -> void:
	if equipped_weapon:
		equip_weapon(equipped_weapon)


## Swap the active weapon. Updates the Hitbox's damage and collision
## shape size to match. Safe to call at any time (e.g. from an inventory
## system later, or the temporary WeaponTestSwitcher for now).
func equip_weapon(weapon: Weapon) -> void:
	equipped_weapon = weapon
	hitbox.damage = weapon.damage
	var rect_shape := hitbox_shape.shape as RectangleShape2D
	if rect_shape:
		rect_shape.size = weapon.hitbox_size


func _process(delta: float) -> void:
	_update_hitbox_position()
	_tick_timers(delta)
	if Input.is_action_just_pressed("attack") and _cooldown_timer <= 0.0:
		_start_attack()


func _update_hitbox_position() -> void:
	if equipped_weapon:
		hitbox.position.x = equipped_weapon.hitbox_reach * movement.facing_direction


func _tick_timers(delta: float) -> void:
	if _cooldown_timer > 0.0:
		_cooldown_timer -= delta
	if _attack_timer > 0.0:
		_attack_timer -= delta
		if _attack_timer <= 0.0:
			_end_attack()


func _start_attack() -> void:
	if not equipped_weapon:
		return
	_attack_timer = equipped_weapon.attack_duration
	_cooldown_timer = equipped_weapon.attack_duration + equipped_weapon.attack_cooldown
	hitbox.monitoring = true


func _end_attack() -> void:
	hitbox.monitoring = false
