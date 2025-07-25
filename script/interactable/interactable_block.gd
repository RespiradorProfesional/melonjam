extends Interactable
class_name InteractableBlock

@onready var target = $target


func interact(player):
	# Declaramos el player
	current_player = player

func detach():
	# Lo devolvemos
	#print("ENDING")
	end_object()
