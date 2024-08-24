extends Node

@export var enemy_list : Array[PackedScene]
var spawners_list : Array[Node3D]

@export var wave_number : int = 0
@export var wave_dificulty : float = 0.0
@export var wave_max_dificulty : float = 10.0
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
	

func start_wave() -> void:
	wave_dificulty += 1
	if wave_dificulty > wave_max_dificulty:
		wave_dificulty = wave_max_dificulty
	wave_duration = 30.0

func spawn_enemy(position : Vector3):
	var selected_enemy : int = 0
	var enemy_instance : Node3D = enemy_list[selected_enemy].instantiate()
	enemy_instance.global_position = position
	get_tree().get_root().add_child(enemy_instance)
	

func update_wave(delta: float) -> void:
	if wave_duration > 0:
		var random_spawn : Node3D = select_random_non_visible_node()
		if random_spawn != null and cooldown <= 0:
			spawn_enemy(random_spawn.global_position)
			cooldown = min(max(wave_max_dificulty - wave_dificulty,1),3)
			
		wave_duration -= delta
		cooldown -= delta

func _ready() -> void:
	start_wave()

func _process(delta: float) -> void:
	update_wave(delta)
