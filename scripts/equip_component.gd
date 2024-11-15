extends Node3D

var item_data

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_data = get_parent().item_data
	
	if not item_data:
		push_error("Please, put the item resource in the item_script")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func equip():
	var item_socket = get_tree().get_root().get_child(2).player_item_socket
	item_data.equip(get_parent(), item_socket)
