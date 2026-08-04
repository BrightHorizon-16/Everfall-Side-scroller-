extends CharacterBody2D
## Chaser
##
## Thin coordinator for the Chaser root, mirroring Player's pattern.
## Reacts to Health's "died" signal by removing itself from the scene.
## AI/movement logic stays entirely in ChaserAI.
class_name Chaser

@onready var health: Health = $Health


func _ready() -> void:
	health.died.connect(_on_died)


func _on_died() -> void:
	queue_free()
