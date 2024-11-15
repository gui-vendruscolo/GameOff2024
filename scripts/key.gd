extends Node3D

@export var item_data: Item
@export var mesh : Mesh

func _ready():
	if mesh:
		$KeyMesh.mesh = mesh
