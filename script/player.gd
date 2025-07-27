extends CharacterBody3D
class_name Player

@onready var neck = $Neck # Nodo hijo de player que hace de transform de la cámaray y el raycast
@onready var camera = $Neck/Camera3D # Cámara del jugador
@onready var ray_interact = $Neck/Camera3D/RayCast3D # Raycast del centro de la cámara del jugador
@export var hp : int = 200
@onready var cetrum: Node3D = $Neck/cetrum

var knockback_velocity: Vector3 = Vector3.ZERO
var knockback_timer := 0.0
var knockback_duration := 0.2  # duración del empuje en segundos

const sensitivy_mouse = 0.001 # Sensibilidad del ratón
const SPEED = 5.0 # Velocidad de movimiento
const JUMP_VELOCITY = 4.5 # Velocidad de salto

var mouse_released : bool = false # Comprobación de uso del ratón en partida

var current_interactable : Interactable = null # Interactuable detectado por raycast

var camera_shake_strength := 0.1
var camera_shake_duration := 1
var camera_shake_timer := 0.0
var original_camera_position := Vector3.ZERO

@onready var hp_label: Label = $CanvasLayer/hp_label


#region Máquina de estados del jugador
enum PlayerState { FREE, INTERACTING, DISABLED }
var state: PlayerState = PlayerState.FREE
func set_state(new_state: PlayerState) -> void:
	state = new_state
#endregion

func _ready():
	original_camera_position = camera.position

func _unhandled_input(event: InputEvent) -> void:
	vision(event)

func _process(delta):
	camera_shake(delta)
	match state:
		PlayerState.FREE:
			movement(delta)
		PlayerState.INTERACTING:
			current_interactable.check_object()
		PlayerState.DISABLED:
			pass # Nada, está desactivado
	interaction()
func movement(delta):
	# Gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Saltar
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movimiento normal
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# Aplicar knockback si está activo
	if knockback_timer > 0:
		knockback_timer -= delta
		velocity += knockback_velocity
		# Disminuir gradualmente la fuerza del knockback
		knockback_velocity = knockback_velocity.move_toward(Vector3.ZERO, 20 * delta)

	move_and_slide()

func vision(event: InputEvent):
	# ESC: liberar el ratón completamente
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouse_released = true
		return

	# Si hace clic en la ventana y el ratón está liberado, recapturarlo según estado
	if event is InputEventMouseButton and event.pressed and mouse_released:
		if state == PlayerState.FREE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		elif state == PlayerState.INTERACTING:
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			
		mouse_released = false

	# Si el ratón está liberado, no hacer nada más
	if mouse_released:
		return

	# Comportamiento mientras no esté liberado
	match state:
		PlayerState.FREE:
			# Asegurarnos de estar en CAPTURED
			if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

			if event is InputEventMouseMotion:
				neck.rotate_y(-event.relative.x * sensitivy_mouse)
				camera.rotate_x(-event.relative.y * sensitivy_mouse)
				camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))

		PlayerState.INTERACTING:
			# Asegurarnos de estar en CONFINED
			if Input.get_mouse_mode() != Input.MOUSE_MODE_CONFINED:
				Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			# (Aquí no rotamos la cámara)

		PlayerState.DISABLED:
			pass

func interaction():
	if Input.is_action_just_pressed("interact"):
		#print("INTENTANDO OPENING")
		if current_interactable != null and state == PlayerState.FREE:
			current_interactable.interact(self)

	if Input.is_action_just_pressed("detach"):
		#print("INTENTANDO ENDING")
		if current_interactable != null and state == PlayerState.INTERACTING:
			current_interactable.detach()

func hit(from_position: Vector3, damage: int = 10, knockback_strength: float = 5.0):
	
	
	print("hit! hp =", hp, "damage = " , damage)
	camera_shake_timer = camera_shake_duration
	# Calcular dirección de knockback
	var dir = (global_position - from_position).normalized()
	knockback_velocity = dir * knockback_strength
	knockback_timer = knockback_duration
	update_hp(hp - damage)

func camera_shake(delta):
	if camera_shake_timer > 0:
		camera_shake_timer -= delta
		var random_offset = Vector3(
			randf_range(-1.0, 1.0),
			randf_range(-1.0, 1.0),
			randf_range(-1.0, 1.0)
		) * camera_shake_strength
		camera.position = original_camera_position + random_offset
	else:
		camera.position = original_camera_position

func update_hp(new_hp):
	if new_hp<=0:
		call_deferred("change_scene_deferred")
	hp=new_hp
	hp_label.text = str(new_hp)



func change_scene_deferred():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://scene/ui/defeat_screen.tscn")
