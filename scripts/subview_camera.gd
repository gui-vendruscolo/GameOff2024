extends Camera3D


var main_camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_camera = $"../../.."
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_global_transform(main_camera.get_global_transform())
	pass
