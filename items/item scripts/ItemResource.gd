extends Resource
class_name Item

enum ITEM_TYPE {QUEST, CONSUMABLE, EQUIPMENT, KEY}

# Propriedades comuns aos itens
@export var name:String = ""
@export var icon:Texture = null
@export var type: ITEM_TYPE
@export var hover_text: String = ""
@export var mesh : Mesh = null
@export var item_name:String = ""

var item_scale : Vector3
var hand_position

func equip(parent_node: Node3D, item_socket: Node3D) -> void:
	if mesh == null:
		push_error("Mesh is null")
		return
		
	var equipped_item = MeshInstance3D.new()
	equipped_item.mesh = mesh
	equipped_item.scale = item_scale
	
	item_socket.add_child(equipped_item)
	

func use():
	push_error("The use method must be implemented by the subclasses")
	
