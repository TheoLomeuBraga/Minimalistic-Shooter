extends Node

var mouse_sensitivity : float = 6
var joystick_sensitivity : float = 12

var is_paused : bool = false
var player : Node3D
var camera : Camera3D

var unpause_lock := 0

func pause():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	unpause_lock = 2
	$Pause.visible = true
	

func unpause():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	$Pause.visible = false
	unpause_lock = 2

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	
	if get_tree().paused and unpause_lock <= 0 and Input.is_action_just_pressed("pause"):
		unpause()
	
	
	unpause_lock -= 1

func reload():
	DungeonMaster.spawners_list.clear()
	DungeonMaster.healt_pack_list.clear()
	get_tree().reload_current_scene()
