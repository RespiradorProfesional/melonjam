extends Node3D
class_name Ability_base
@export var speed := 10.0
var direction: Vector3 = Vector3.ZERO
@export var power_name : String
@onready var hit_box = $HitBox
@export var knockback_strength : int
@onready var timer: Timer = $Timer
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D


var damage
var cooldown
var area
var projectile_duration


func _ready():
	if direction != Vector3.ZERO:
		look_at(global_transform.origin + direction)
	audio_stream_player_3d.play()
	var data_ability = GlobalDataUser.get_power_stats(power_name)
	damage = data_ability["damage"]
	area = data_ability["area"]
	projectile_duration = data_ability["projectile_duration"]
	timer.wait_time=projectile_duration
	timer.start()
	custom_ready()
func custom_ready():
	pass

func _physics_process(delta):
	if direction != Vector3.ZERO:
		global_translate(direction * speed * delta)
	custom_process()

func custom_process():
	pass




func _on_hit_box_body_entered(body: Node3D) -> void:
	if body is Enemy:
		pass
		#body.damaged(global_position,damage,100,true)


func _on_hit_box_body_exited(body: Node3D) -> void:
	if body is Enemy:
		pass # Replace with function body.


func _on_timer_timeout() -> void:
	queue_free()
