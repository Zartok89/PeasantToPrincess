extends Area2D

var is_held := false
var offset := Vector2.ZERO

var hidden_count := 0
const REQUIRED_HIDES := 13
const TARGET_GROUP := "Cysts"

func _ready():
	set_process(true)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed:
			if not is_held:
				is_held = true
				offset = get_global_mouse_position() - global_position
			else:
				is_held = false

func _process(delta: float) -> void:
	if is_held:
		global_position = get_global_mouse_position() - offset

func _on_area_entered(area):
	if area.is_in_group(TARGET_GROUP):
		if area.visible:
			area.visible = false
			hidden_count += 1
			_check_trigger_next()

func _check_trigger_next():
	if hidden_count >= REQUIRED_HIDES:
		_trigger_next_function()

func _trigger_next_function():
	self.visible = false
	is_held = false
	print("Triggered next function: 12 cysts hidden.")
	var next_scene_path := "res://Scenes/phase_2_makeup.tscn"
	get_tree().change_scene_to_file(next_scene_path)
