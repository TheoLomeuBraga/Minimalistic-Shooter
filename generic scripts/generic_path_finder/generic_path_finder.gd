extends CharacterBody3D
class_name GenericPathFinder

@export var speed := 500.0

@export var target_position : Vector3
@export var go : bool = false

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var random_countdown : float = 0



func movement_plugin(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	
	
	if random_countdown <= 0:
		target_position = $NavigationAgent3D.get_next_path_position()
		$NavigationAgent3D.target_position = Global.player.global_position
		random_countdown = rng.randf_range(0.5,1.5)
	
	if go:
		velocity = (target_position - global_position).normalized() * speed * delta
		move_and_slide()
	
	random_countdown -= delta
	
	movement_plugin(delta)
	
