extends Node

@export var enemy_list : Array[PackedScene]
var spawners_list : Array[Node3D]
var healt_pack_list : Array[Node3D]

@export var wave_number : int = 0
@export var wave_dificulty : float = 0.0
@export var wave_max_dificulty : float = 10.0
@export var wave_duration : float = 0.0
var cooldown : float = 0.0

func restore_health_packs():
	for n in healt_pack_list:
			n.utilized = false

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
func select_random_non_visible_node():
	
	var new_spawners_list : Array[Node3D]
	
	for n in spawners_list:
		if not n.is_visible:
			new_spawners_list.append(n)
	
	if new_spawners_list.size() > 0:
		return new_spawners_list[rng.randi_range(0,new_spawners_list.size() - 1)]
	
	return null
	

var wave_break : bool = true
func start_wave() -> void:
	wave_dificulty += 1
	wave_duration = 30.0
	wave_break = false

var spawn_enemy_count_down_to_stronger_enemy : float = 0
func spawn_enemy(position : Vector3):
	var selected_enemy : int = 0
	
	if spawn_enemy_count_down_to_stronger_enemy > 2:
		selected_enemy = 1
		spawn_enemy_count_down_to_stronger_enemy = 0
	
	var enemy_instance : Node3D = enemy_list[selected_enemy].instantiate()
	enemy_instance.global_position = position
	get_tree().current_scene.add_child(enemy_instance)
	spawn_enemy_count_down_to_stronger_enemy += 1
	




func _ready() -> void:
	#start_wave()
	$intro_song.play()

func spawn_enemy_on_random_spawner():
	var random_spawn : Node3D = select_random_non_visible_node()
	if random_spawn != null and cooldown <= 0:
		spawn_enemy(random_spawn.global_position)
		cooldown = 2.05


func update_wave(delta: float) -> void:
	if not wave_break:
		if wave_duration > 0:
			spawn_enemy_on_random_spawner()
				
			wave_duration -= delta
			cooldown -= delta
	$CenterContainer/display.text = "TIME UNTIL WAVE END: " + str(int(wave_duration))

func _process(delta: float) -> void:
	update_wave(delta)
