@tool

extends Area3D

class_name PickupComponent

signal item_picked(item_name:String, quantity:int)

var interaction_area
var can_interact
var player_inventory
var item_data : Item

var pickup_area

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	item_data = get_parent().item_data
	item_data.item_scale = scale
	
	GameManager.connect("player_initialized", _on_player_initialized)
	self.connect("body_entered", _on_body_entered)
	self.connect("body_exited", _on_body_exited)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_interact:
		if Input.is_action_just_pressed("interact"):
			pick_up()

func pick_up() -> void:
	print("Trying to pick up item")
	if item_data and player_inventory:
		player_inventory.add_item_by_res(item_data, 1)
		print("Picking item up")
		get_parent().queue_free()

func _on_player_initialized(player) -> void:
	print("Inventory gotten")
	player_inventory = player.get_node("InventoryManager").inventory

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		print("get item bro")
		can_interact = true

func _on_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		print("getnt item bro")
		can_interact = false
