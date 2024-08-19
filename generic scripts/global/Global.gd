extends Node

var mouse_sensitivity : float = 6
var joystick_sensitivity : float = 12

var block_pause_ticks : int = false
var is_paused : bool = false
var player : Node3D

func pause():
	if block_pause_ticks <= 0:
		is_paused = true
		Engine.time_scale = 0
		block_pause_ticks = 2

func unpause():
	if block_pause_ticks <= 0:
		is_paused = false
		Engine.time_scale = 1
		block_pause_ticks = 2

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if block_pause_ticks > 0:
		block_pause_ticks -= 1
	
	if Engine.time_scale == 0:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
