extends Node3D

var inventory_resource = load("res://scripts/inventory.gd")
var inventory = inventory_resource.new()
var inventory_ui 
var inventory_open
var initial_mouse_mode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	inventory_ui = $InventoryUI
	inventory_ui.visible = false
	inventory_open = false
	initial_mouse_mode = Input.mouse_mode


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if inventory_open and Input.is_action_just_pressed("inventory"):
		print("Closing Inventory")
		get_tree().paused = false
		inventory_ui.visible = false
		inventory_open = false
		Input.mouse_mode = initial_mouse_mode
		
	elif Input.is_action_just_pressed("inventory") and !inventory_open:
		print("Opening Inventory")
		get_tree().paused = true
		inventory_ui.visible = true
		inventory_open = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
		
	
		
