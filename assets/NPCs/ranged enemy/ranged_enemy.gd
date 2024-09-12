extends GenericPathFinder

@export var health := 50

@export var explosion_sceane : PackedScene

func hit_damage(damage : int):
	health -= damage
	
	$hit.play()
	
	for m in meshes:
		var mat : Material = m.get_surface_override_material(0)
		mat.emission = Color.WHITE
		m.set_surface_override_material(0,mat)
	
	if health < 0:
		queue_free()
		
		for i in range(0,10):
			var explosion : Node3D = explosion_sceane.instantiate()
			get_tree().current_scene.add_child(explosion)
			explosion.global_position = global_position
		
		

func _ready() -> void:
	look_mode = look_modes.look_target

@export var meshes : Array[MeshInstance3D] 
func update_damage_color(delta: float) -> void:
	for m in meshes:
		var mat : Material = m.get_surface_override_material(0)
		mat.emission = lerp(mat.emission,Color.BLACK,delta)
		m.set_surface_override_material(0,mat)

@export var contact_damage_explosion : PackedScene

var cool_down : float = 3.0
func manage_contact_damage(delta: float) -> void:
	if cool_down <= 0 and Global.player.global_position.distance_to(global_position) < 4:
		var explosion : Node3D = contact_damage_explosion.instantiate() 
		get_tree().current_scene.add_child(explosion)
		explosion.global_position = global_position
		cool_down = 1.0

func manage_shoot(delta: float) -> void:
	pass


func movement_plugin(delta: float) -> void:
	
	if cool_down > 0:
		cool_down -= delta
	
	update_damage_color(delta)
	manage_contact_damage(delta)
	manage_shoot(delta)
	
	
	if Global.player != null:
		target_location = Global.player.global_position
		go = global_position.distance_to(target_location) > 10
