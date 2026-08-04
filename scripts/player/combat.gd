extends Node
## PlayerCombat
##
## Single responsibility: trigger the player's one basic attack and
## position/activate the Hitbox while it's swinging. No combo chains, no
## weapon variety yet - that's deferred to a later milestone.
class_name PlayerCombat

@export var attack_damage: int = 10
@export var attack_duration: float = 0.2
@export var attack_cooldown: float = 0.3
@export var hitbox_offset: float = 16.0

@onready var hitbox: Hitbox = get_parent().get_node("Hitbox")
@onready var movement: PlayerMovement = get_parent().get_node("Movement")

var _cooldown_timer: float = 0.0
var _attack_timer: float = 0.0


func _ready() -> void:
	hitbox.damage = attack_damage
	hitbox.monitoring = false


func _process(delta: float) -> void:
	_update_hitbox_position()
	_tick_timers(delta)
	if Input.is_action_just_pressed("attack") and _cooldown_timer <= 0.0:
		_start_attack()


func _update_hitbox_position() -> void:
	hitbox.position.x = hitbox_offset * movement.facing_direction


func _tick_timers(delta: float) -> void:
	if _cooldown_timer > 0.0:
		_cooldown_timer -= delta
	if _attack_timer > 0.0:
		_attack_timer -= delta
		if _attack_timer <= 0.0:
			_end_attack()


func _start_attack() -> void:
	_attack_timer = attack_duration
	_cooldown_timer = attack_duration + attack_cooldown
	hitbox.monitoring = true


func _end_attack() -> void:
	hitbox.monitoring = false
