extends Item

class_name Key

@export var key_id : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func equip(parent_node: Node3D, item_socket: Node3D) -> void:
	return
