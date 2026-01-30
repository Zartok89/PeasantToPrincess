extends Area2D

var isHeld := false
var offset := Vector2.ZERO

func _ready():
	set_process(true)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed:
			if not isHeld:
				isHeld = true
				offset = get_global_mouse_position() - global_position
			else:
				isHeld = false

func _process(delta: float) -> void:
	if isHeld:
		global_position = get_global_mouse_position() - offset
