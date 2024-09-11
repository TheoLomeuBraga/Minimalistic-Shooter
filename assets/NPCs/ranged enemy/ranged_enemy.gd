extends GenericPathFinder

@export var health := 50

func hit_damage(damage : int):
	health -= damage
	if health < 0:
		queue_free()
		

func _ready() -> void:
	look_mode = look_modes.look_target


func movement_plugin(delta: float) -> void:
	
	if Global.player != null:
		target_location = Global.player.global_position
		go = global_position.distance_to(target_location) > 2
