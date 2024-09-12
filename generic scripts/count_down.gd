extends Node

@export var life_time := 1.0

func _ready() -> void:
	$AudioStreamPlayer.play()
	pass

func _process(delta: float) -> void:
	
	if life_time <= 0:
		queue_free()
	life_time -= delta
