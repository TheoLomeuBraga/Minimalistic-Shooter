extends Node

@export var enemy_list : Array[PackedScene]
var spawners_list : Array[Node3D]

@export var wave_number : int = 0
@export var wave_dificulty : float = 0.0
@export var wave_duration : float = 0.0
var cooldown : float = 0.0

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
func select_random_non_visible_node():
	
	var new_spawners_list : Array[Node3D]
	
	for n in spawners_list:
		if not n.is_visible:
			new_spawners_list.append(n)
	
	if new_spawners_list.size() > 0:
		return new_spawners_list[rng.randi_range(0,new_spawners_list.size() - 1)]
	
	return null
	

func _process(delta: float) -> void:
	
	var random_spawn : Node3D = select_random_non_visible_node()
	if random_spawn != null and cooldown <= 0:
		var enemy_instance : Node3D = enemy_list[0].instantiate()
		enemy_instance.global_position = random_spawn.global_position
		get_tree().get_root().add_child(enemy_instance)
		cooldown = 1.0
	
	wave_duration -= delta
	cooldown -= delta
