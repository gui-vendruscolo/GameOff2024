extends Resource

class_name Inventory

signal inventory_changed


@export var _items: Array:
	set = set_items,
	get = get_items

func set_items(new_items:Array):
	_items = new_items
	emit_signal("inventory_changed", self)
	
func get_items():
	return _items
	
func get_item(index: int):
	return _items[index]
	
func check_key_by_id(key_id : int) -> bool:
	for item in _items:
		print(item.name)
		if item.type == item.ITEM_TYPE.KEY:
			print(item.key_id)
			if item.key_id == key_id:
				return true
	return false
	
	
func add_item(item_name: String, quantity: int):
	if quantity <= 0:
		push_error("cant add 0 or less items")
		return
		
	var item = ItemDatabase.get_item(item_name)
	if not item: 
		push_error("Could not find item with name %s" % item_name)
		return
	#var remaining_quantity = quantity
	#var max_stack_size = item.max_stack_size if item.stackable else 1
	_items.append(item)
	emit_signal("inventory_changed", self)
	
func add_item_by_res(item_data: Item, quantity: int):
	if quantity <= 0:
		push_error("cant add 0 or less items")
		return
	if not item_data: 
		push_error("Could not find item with name %s" % item_data.name)
		return
	#var remaining_quantity = quantity
	#var max_stack_size = item.max_stack_size if item.stackable else 1
	_items.append(item_data)
	emit_signal("inventory_changed", self)
