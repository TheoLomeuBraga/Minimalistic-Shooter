extends Node3D

var is_visible : bool = true


func _ready() -> void:
	DungeonMaster.spawners_list.append(self)

func _process(delta: float) -> void:
	pass

func _on_screen_entered() -> void:
	is_visible = true

func _on_screen_exited() -> void:
	is_visible = false
