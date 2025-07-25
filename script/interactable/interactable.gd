extends Node3D
"""
Clase Interactuable:

Base de los objetos interactuables que utilizaremos 
para tanto objetos con los que queramos interactuar,
como para minijuegos.

"""
class_name Interactable

# Nombre y descripción del objeto interactuable
@export var prompt_name : String="INTERACTABLE_NAME"
@export var prompt_description : String="INTERACTABLE_DESCRIPTION"
var current_player = null

# Función base del objeto interactuable.
# Toma como parámetro al jugador con el que interactua.
func interact(_player):
	pass

func detach():
	pass

func start_object():
	pass

func check_object():
	pass

func end_object():
	pass
