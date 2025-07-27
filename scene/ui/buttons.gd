extends Button

@export var audio_stream_player: AudioStreamPlayer

func _ready():
	# Conectamos la señal 'pressed' a la función personalizada 'on_button_pressed'
	self.pressed.connect(on_button_pressed)

func on_button_pressed():
	if audio_stream_player:
		audio_stream_player.play()
	else:
		print("No hay AudioStreamPlayer asignado.")
