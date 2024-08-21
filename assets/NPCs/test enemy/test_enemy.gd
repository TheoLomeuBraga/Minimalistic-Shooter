extends GenericPathFinder

var health : int = 10

func _ready() -> void:
	look_mode = 2

func movement_plugin(delta: float) -> void:
	target_location = Global.player.global_position
	go = global_position.distance_to(Global.player.global_position) > 5
	
