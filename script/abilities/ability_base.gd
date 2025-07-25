extends Node3D
class_name Ability_base
@export var speed := 10.0
var direction: Vector3 = Vector3.ZERO
@export var power_name : String
@onready var hit_box = $HitBox

var damage
var cooldown
var area
var projectile_duration

func _ready():
	if direction != Vector3.ZERO:
		look_at(global_transform.origin + direction)
	
	var data_ability = GlobalDataUser.get_power_stats(power_name)
	print(data_ability)
	damage = data_ability["damage"]
	area = data_ability["area"]
	projectile_duration = data_ability["projectile_duration"]
	
	hit_box.scale = Vector3.ONE * area

func _physics_process(delta):
	if direction != Vector3.ZERO:
		global_translate(direction * speed * delta)


func _on_hit_box_area_entered(area: Area3D) -> void:
	pass # Replace with function body.
