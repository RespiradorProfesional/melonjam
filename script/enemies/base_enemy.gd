extends CharacterBody3D
class_name Enemy

var state_machine

@export var mesh: MeshInstance3D
@onready var gpu_particles_3d: GPUParticles3D = $GPUParticles3D
@export var hp : int = 100
@export var ATTACK_RANGE :float = 2.0
@export var SPEED :float = 4.0
@export var damamge :float= 4.0
@export var knockback_player: bool= false


@export var player : Player

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var anim_tree: AnimationTree = $AnimationTree

var _target_in_range : bool = false
var knockback_velocity: Vector3 = Vector3.ZERO
var knockback_timer := 0.0
var knockback_duration := 0.2  # cuanto tiempo dura el empujón
var death= false

# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = anim_tree.get("parameters/playback")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector3.ZERO

	# Aplica knockback si está activo
	if knockback_timer > 0:
		knockback_timer -= delta
		velocity += knockback_velocity
	else:
		match state_machine.get_current_node():
			"Run":
				# Navigation
				nav_agent.set_target_position(player.global_transform.origin)
				var next_nav_point = nav_agent.get_next_path_position()
				velocity = (next_nav_point - global_transform.origin).normalized() * SPEED
				rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), delta * 10.0)
			"Attack":
				look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
		
		# Conditions
		anim_tree.set("parameters/conditions/attack", _target_in_range && !death)
		anim_tree.set("parameters/conditions/run", !_target_in_range && !death)
		anim_tree.set("parameters/conditions/death", death)
	
	move_and_slide()





func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		body.hit()

func damaged(from_position: Vector3,damage,knockback_strenght,knockback:bool=false):
	if knockback : 
		# Calcular dirección opuesta al atacante
		var dir = (global_position - from_position).normalized()
		
		# Aplicar knockback
		knockback_velocity = dir * knockback_strenght # Puedes ajustar la fuerza
		knockback_timer = knockback_duration
		
		# Mostrar efecto visual de daño
		
	else:
		pass
	show_damage_feedback()
	print(hp)
	
	if hp - damage <=0:
		$death_timer.start()
		$CollisionShape3D.call_deferred("set", "disabled", true)
		death= true
		
	else:
		hp -= damage
	
	
	

func show_damage_feedback():
	gpu_particles_3d.emitting=true

func _on_attack_area_body_entered(body: Node3D) -> void:
	if body is Player:
		_target_in_range=true


func _on_attack_area_body_exited(body: Node3D) -> void:
	if body is Player:
		_target_in_range=false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name=="death":
		queue_free()


func _on_death_timer_timeout() -> void:
	queue_free()
