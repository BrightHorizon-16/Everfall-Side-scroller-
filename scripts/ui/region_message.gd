extends Label
## RegionMessage
##
## Shows a brief centered message when something triggers it (right now,
## any EndPoint's "reached" signal - found via the "end_point" group, so
## this doesn't need a direct scene reference). Hides itself again after
## a short delay.
class_name RegionMessage

@export var display_seconds: float = 2.5
@export var message_text: String = "Region Complete!"

@onready var _timer: Timer = Timer.new()


func _ready() -> void:
	text = ""
	add_child(_timer)
	_timer.one_shot = true
	_timer.timeout.connect(_on_timeout)

	for end_point in get_tree().get_nodes_in_group("end_point"):
		end_point.reached.connect(_on_reached)


func _on_reached() -> void:
	text = message_text
	_timer.start(display_seconds)


func _on_timeout() -> void:
	text = ""
