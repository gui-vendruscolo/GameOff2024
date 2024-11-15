extends Node

signal player_initialized(player)
signal unlock_door_by_id(key_id)

var player
var player_inventory
var inventory_manager
var player_item_socket

func _ready():
	for door in get_tree().get_nodes_in_group("doors"):
		door.connect("request_key_check", _on_request_key_check)

func _process(delta):
	if not player:
		initialize_player()
		return
		
func initialize_player():
	player = get_tree().get_root().get_child(3).get_node("Player")
	
	if not player:
		push_error("Could not find player")
		return
	inventory_manager = player.get_node("InventoryManager")
	player_item_socket = player.get_node("CharacterController").get_node("Head").get_node("Camera").get_node("Arms").get_node("ItemSocket")
	player_inventory = inventory_manager.inventory
	player_inventory.inventory_changed.connect(_on_player_inventory_changed)
	emit_signal("player_initialized", player)
	
	
	#var existing_inventory = load("user://inventory.tres")
	#if existing_inventory:
		#player_inventory.set_items(existing_inventory.get_items())

func _on_request_key_check(key_id : int) -> void:
	var has_key = player_inventory.check_key_by_id(key_id)
	
	if has_key:
		emit_signal("unlock_door_by_id", key_id)
	else: 
		emit_signal("unlock_door_by_id", -1)
		
func _on_player_inventory_changed(inventory):
	print("Saving inventory")
	ResourceSaver.save(inventory, "user://inventory.tres")
