extends Area2D

var is_held := false
var offset := Vector2.ZERO

const TARGET_GROUP := "face"

var nice_face: Node2D
var nice_face2: Node2D

func _ready():
	set_process(true)
	nice_face = get_node("/root/Phase3_Dressup/Character/Peasant1Nice") as Node2D
	nice_face2 = get_node("/root/Phase3_Dressup/Character/Lips") as Node2D

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
		_trigger_next_function()

func _trigger_next_function():
	if nice_face:
		nice_face.visible = true
		await get_tree().create_timer(5.0).timeout
		get_tree().change_scene_to_file("res://Scenes/phase_4_BeforeAfter.tscn")
		queue_free()
		
	if nice_face2:
		nice_face2.visible = true
		
	self.visible = false
	is_held = false
