extends Node3D

signal request_key_check(key_id)

enum DOOR_STATE { OPEN, CLOSED }
enum LOCK_STATE { LOCKED, UNLOCKED }

@export var mesh : Mesh
@export var key_id : int
@export var door_state : DOOR_STATE
@export var lock_state : LOCK_STATE
var can_interact : bool
var can_open : bool
var animation_player


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	can_interact = false
	door_state = DOOR_STATE.CLOSED
	if mesh:
		$MeshInstance3D.mesh = mesh
	
	animation_player = $AnimationPlayer
	GameManager.connect("unlock_door_by_id", _check_unlock_test)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_interact:
		if Input.is_action_just_pressed("interact"):
			if lock_state == LOCK_STATE.LOCKED:
				try_unlock()

func try_unlock() -> void:
	emit_signal("request_key_check", key_id)
	
func _check_unlock_test(id : int):
	if key_id == id:
		print("The door has been unlocked")
		animation_player.play("open_door")
	else: 
		print("Could not unlock door")
	

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		can_interact = true
		print("Can interact")

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		print("Cannot interact")
		
		can_interact = false
