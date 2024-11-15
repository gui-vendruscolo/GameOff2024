extends GridContainer


var player
var player_inventory
var item_socket

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.connect("player_initialized", _on_player_initialized)


func _on_player_initialized(player) -> void:
	player_inventory = player.get_node("InventoryManager").inventory
	player_inventory.inventory_changed.connect(_on_inventory_changed)
	item_socket = GameManager.player_item_socket
	self.player = player
	
func _on_inventory_changed(inventory):
	for n in get_children():
		n.queue_free()
	for item in inventory.get_items():
		var item_label = Label.new()
		var item_button = Button.new()
		var equip_callable = Callable(item, "equip")
		equip_callable = equip_callable.bind(player, item_socket)
		item_label.text = "%s" % item.name
		item_button.text = item_label.text
		item_button.pressed.connect(equip_callable)
		add_child(item_button)	
