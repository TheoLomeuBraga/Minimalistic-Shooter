extends Node3D

var is_visible : bool

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func _on_screen_entered() -> void:
	is_visible = true


func _on_screen_exited() -> void:
	is_visible = false
