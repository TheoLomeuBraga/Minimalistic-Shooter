extends GenericPathFinder


var damage_color_time := 0.0
var original_color : Color

func _ready() -> void:
	look_mode = 1
	original_color = $MeshInstance3D.get_surface_override_material(0).albedo_color

@export var health := 20

@export var explosion_sceane : PackedScene

@export var projectile : PackedScene

func hit_damage(damage : int) -> void:
	
	health -= damage
	damage_color_time = 0.25
	if health < 0:
		queue_free()
		var explosion : Node3D = explosion_sceane.instantiate()
		get_tree().current_scene.add_child(explosion)
		explosion.global_position = global_position
	

@export var array_meshes_display_damage : Array[MeshInstance3D]
func manage_damage(delta: float) -> void:
	damage_color_time -= delta
	if damage_color_time < 0:
		damage_color_time = 0
	
	for mi in array_meshes_display_damage:
		var material : Material = mi.get_surface_override_material(0)
		if material == null:
			material = mi.mesh.surface_get_material(0)
		
		if damage_color_time > 0:
			material.emission = lerp(Color.BLACK,Color.WHITE,damage_color_time * 4) 
		else:
			material.emission = Color.BLACK
		mi.set_surface_override_material(0,material)

var gun_cooldown : float = 2.0
func manage_gum(delta: float) -> void:
	$muzle.look_at(Global.player.global_position)
	if gun_cooldown <= 0.0:
		var p : Node3D = projectile.instantiate()
		
		get_tree().current_scene.add_child(p)
		p.global_position = $muzle.global_position
		p.global_rotation = $muzle.global_rotation
		
		gun_cooldown = 2.0
	
	#$enemy_soldier/AnimationPlayer.play("shoot")
	gun_cooldown -= delta

enum test_enemy_states {
	walk = 0,
	shoot = 1,
}
var test_enemy_state : test_enemy_states

func movement_plugin(delta: float) -> void:
	target_location = Global.player.global_position
	go = global_position.distance_to(target_location) > 5
	if test_enemy_state == test_enemy_states.walk:
		
		if go == false:
			test_enemy_state = test_enemy_states.shoot
		
	elif test_enemy_state == test_enemy_states.shoot:
		manage_gum(delta)
		if go == true:
			test_enemy_state = test_enemy_states.walk
	if go:
		look_mode = 1
		$enemy_soldier/AnimationPlayer.play("walk")
		$enemy_soldier/AnimationPlayer.speed_scale = 2
	else:
		look_mode = 2
		if $enemy_soldier/AnimationPlayer.current_animation == "walk":
			$enemy_soldier/AnimationPlayer.speed_scale = 1
			$enemy_soldier/AnimationPlayer.stop()
	
	
	
	manage_damage(delta)
	
	
	
