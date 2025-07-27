extends Node
var fire_amount=10000
var wind_amount=1000
var water_amount=1000




var active_powers=["basic_projectile"]
var powers_and_level = [
	{"power": "basic_projectile", "level": 1},
	{"power": "flare", "level": 0},
	{"power": "wind_spear", "level": 0},
	{"power": "water_shoot", "level": 0},
	{"power": "steam", "level": 0},
	{"power": "fire_tornado", "level": 0},
	{"power": "huracan", "level": 0},
	{"power": "black_laser", "level": 0}
]


var powers_data = {
"steam": {
	0: {"upgrade_item": [{"type": "water", "amount": 2}, {"type": "fire", "amount": 2}]},
	1: {"damage": 10, "cooldown": 2.5, "area": 1.5, "projectile_duration": 2.0, "upgrade_item": [{"type": "water", "amount": 3}, {"type": "fire", "amount": 3}]},
	2: {"damage": 14, "cooldown": 2.3, "area": 1.7, "projectile_duration": 2.2, "upgrade_item": [{"type": "water", "amount": 4}, {"type": "fire", "amount": 4}]},
	3: {"damage": 18, "cooldown": 2.1, "area": 1.9, "projectile_duration": 2.4, "upgrade_item": [{"type": "water", "amount": 6}, {"type": "fire", "amount": 6}]},
	4: {"damage": 23, "cooldown": 2.0, "area": 2.1, "projectile_duration": 2.6, "upgrade_item": [{"type": "water", "amount": 8}, {"type": "fire", "amount": 8}]},
	5: {"damage": 28, "cooldown": 1.8, "area": 2.3, "projectile_duration": 2.8, "upgrade_item": [{"type": "water", "amount": 10}, {"type": "fire", "amount": 10}]},
	6: {"damage": 34, "cooldown": 1.6, "area": 2.5, "projectile_duration": 3.0, "upgrade_item": null}
},

"black_laser": {
	0: {"upgrade_item": [{"type": "water", "amount": 2}, {"type": "wind", "amount": 2}, {"type": "fire", "amount": 2}]},
	1: {"damage": 25, "cooldown": 3.5, "beam": true, "projectile_duration": 0.5, "area": 1.2, "upgrade_item": [{"type": "water", "amount": 3}, {"type": "wind", "amount": 3}, {"type": "fire", "amount": 3}]},
	2: {"damage": 35, "cooldown": 3.2, "beam": true, "projectile_duration": 0.6, "area": 1.4, "upgrade_item": [{"type": "water", "amount": 5}, {"type": "wind", "amount": 5}, {"type": "fire", "amount": 5}]},
	3: {"damage": 50, "cooldown": 3.0, "beam": true, "projectile_duration": 0.7, "area": 1.6, "upgrade_item": [{"type": "water", "amount": 7}, {"type": "wind", "amount": 7}, {"type": "fire", "amount": 7}]},
	4: {"damage": 65, "cooldown": 2.8, "beam": true, "projectile_duration": 0.8, "area": 1.8, "upgrade_item": [{"type": "water", "amount": 9}, {"type": "wind", "amount": 9}, {"type": "fire", "amount": 9}]},
	5: {"damage": 85, "cooldown": 2.5, "beam": true, "projectile_duration": 0.9, "area": 2.0, "upgrade_item": [{"type": "water", "amount": 12}, {"type": "wind", "amount": 12}, {"type": "fire", "amount": 12}]},
	6: {"damage": 110, "cooldown": 2.2, "beam": true, "projectile_duration": 1.0, "area": 2.2, "upgrade_item": null}
},

"water_shoot": {
	0: {"upgrade_item": [{"type": "water", "amount": 3}]},
	1: {"damage": 12, "cooldown": 1.6, "projectile_duration": 2.5, "area": 1.0, "upgrade_item": [{"type": "water", "amount": 5}]},
	2: {"damage": 18, "cooldown": 1.5, "projectile_duration": 2.7, "area": 1.1, "upgrade_item": [{"type": "water", "amount": 7}]},
	3: {"damage": 22, "cooldown": 1.4, "projectile_duration": 2.9, "area": 1.2, "upgrade_item": [{"type": "water", "amount": 10}]},
	4: {"damage": 28, "cooldown": 1.3, "projectile_duration": 3.1, "area": 1.3, "upgrade_item": [{"type": "water", "amount": 13}]},
	5: {"damage": 35, "cooldown": 1.2, "projectile_duration": 3.3, "area": 1.4, "upgrade_item": [{"type": "water", "amount": 17}]},
	6: {"damage": 42, "cooldown": 1.0, "projectile_duration": 3.5, "area": 1.5, "upgrade_item": null}
},

"fire_tornado": {
	0: {"upgrade_item": [{"type": "fire", "amount": 2}, {"type": "wind", "amount": 2}]},
	1: {"damage": 16, "cooldown": 3.0, "area": 1.5, "projectile_duration": 4, "upgrade_item": [{"type": "fire", "amount": 3}, {"type": "wind", "amount": 3}]},
	2: {"damage": 22, "cooldown": 2.8, "area": 1.7, "projectile_duration": 5, "upgrade_item": [{"type": "fire", "amount": 5}, {"type": "wind", "amount": 5}]},
	3: {"damage": 30, "cooldown": 2.5, "area": 1.9, "projectile_duration": 6, "upgrade_item": [{"type": "fire", "amount": 7}, {"type": "wind", "amount": 7}]},
	4: {"damage": 38, "cooldown": 2.3, "area": 2.0, "projectile_duration": 6.5, "upgrade_item": [{"type": "fire", "amount": 9}, {"type": "wind", "amount": 9}]},
	5: {"damage": 46, "cooldown": 2.0, "area": 2.2, "projectile_duration": 7, "upgrade_item": [{"type": "fire", "amount": 11}, {"type": "wind", "amount": 11}]},
	6: {"damage": 55, "cooldown": 1.8, "area": 2.5, "projectile_duration": 8, "upgrade_item": null}
},

"basic_projectile": {
	1: {"damage": 30, "cooldown": 2.5, "projectile_duration": 1.0, "area": 1.2, "upgrade_item": [{"type": "fire", "amount": 2}]},
	2: {"damage": 38, "cooldown": 2.2, "projectile_duration": 1.1, "area": 1.3, "upgrade_item": [{"type": "water", "amount": 5}]},
	3: {"damage": 47, "cooldown": 2.0, "projectile_duration": 1.2, "area": 1.4, "upgrade_item": [{"type": "wind", "amount": 7}]},
	4: {"damage": 58, "cooldown": 1.8, "projectile_duration": 1.3, "area": 1.5, "upgrade_item": [{"type": "fire", "amount": 10}]},
	5: {"damage": 70, "cooldown": 1.6, "projectile_duration": 1.4, "area": 1.6, "upgrade_item": [{"type": "water", "amount": 15}]},
	6: {"damage": 85, "cooldown": 1.5, "projectile_duration": 1.5, "area": 1.8, "upgrade_item": null}
},

"flare": {
	0: {"upgrade_item": [{"type": "fire", "amount": 3}]},
	1: {"damage": 10, "cooldown": 2.5, "projectile_duration": 2.5, "area": 1.2, "upgrade_item": [{"type": "fire", "amount": 5}]},
	2: {"damage": 14, "cooldown": 2.3, "projectile_duration": 2.7, "area": 1.3, "upgrade_item": [{"type": "fire", "amount": 7}]},
	3: {"damage": 18, "cooldown": 2.1, "projectile_duration": 2.9, "area": 1.4, "upgrade_item": [{"type": "fire", "amount": 10}]},
	4: {"damage": 22, "cooldown": 2.0, "projectile_duration": 3.1, "area": 1.5, "upgrade_item": [{"type": "fire", "amount": 13}]},
	5: {"damage": 27, "cooldown": 1.8, "projectile_duration": 3.3, "area": 1.6, "upgrade_item": [{"type": "fire", "amount": 17}]},
	6: {"damage": 32, "cooldown": 1.6, "projectile_duration": 3.5, "area": 1.7, "upgrade_item": null}
},

"wind_spear": {
	0: {"upgrade_item": [{"type": "wind", "amount": 3}]},
	1: {"damage": 20, "cooldown": 1.8, "projectile_duration": 1.2, "area": 1.0, "upgrade_item": [{"type": "wind", "amount": 5}]},
	2: {"damage": 28, "cooldown": 1.6, "projectile_duration": 1.3, "area": 1.1, "upgrade_item": [{"type": "wind", "amount": 7}]},
	3: {"damage": 36, "cooldown": 1.4, "projectile_duration": 1.4, "area": 1.2, "upgrade_item": [{"type": "wind", "amount": 10}]},
	4: {"damage": 45, "cooldown": 1.2, "projectile_duration": 1.5, "area": 1.3, "upgrade_item": [{"type": "wind", "amount": 13}]},
	5: {"damage": 55, "cooldown": 1.0, "projectile_duration": 1.6, "area": 1.4, "upgrade_item": [{"type": "wind", "amount": 17}]},
	6: {"damage": 66, "cooldown": 0.8, "projectile_duration": 1.8, "area": 1.5, "upgrade_item": null}
},

"huracan": {
	0: {"upgrade_item": [{"type": "water", "amount": 2}, {"type": "wind", "amount": 2}]},
	1: {"damage": 10, "cooldown": 3.0, "area": 1.6, "projectile_duration": 0.5, "upgrade_item": [{"type": "water", "amount": 3}, {"type": "wind", "amount": 3}]},
	2: {"damage": 14, "cooldown": 2.8, "area": 1.8, "projectile_duration": 0.6, "upgrade_item": [{"type": "water", "amount": 5}, {"type": "wind", "amount": 5}]},
	3: {"damage": 18, "cooldown": 2.6, "area": 2.0, "projectile_duration": 0.7, "upgrade_item": [{"type": "water", "amount": 7}, {"type": "wind", "amount": 7}]},
	4: {"damage": 22, "cooldown": 2.4, "area": 2.2, "projectile_duration": 0.8, "upgrade_item": [{"type": "water", "amount": 9}, {"type": "wind", "amount": 9}]},
	5: {"damage": 26, "cooldown": 2.2, "area": 2.4, "projectile_duration": 0.9, "upgrade_item": [{"type": "water", "amount": 11}, {"type": "wind", "amount": 11}]},
	6: {"damage": 30, "cooldown": 2.0, "area": 2.6, "projectile_duration": 1.0, "upgrade_item": null}
}
}

var powers_meta = {
	"basic_projectile":{
		"scene_path": "res://scene/abilities/basic_projectile.tscn",
		"icon_path": "res://assets/ui/abilities_icon/basic_projectile.png"
	},
	"flare": {
		"scene_path": "res://scene/abilities/flare.tscn",
		"icon_path": "res://assets/ui/abilities_icon/flare.png"
	},
	"wind_spear": {
		"scene_path": "res://scene/abilities/wind_spear.tscn",
		"icon_path": "res://assets/ui/abilities_icon/wind_spear.png"
	},
	"water_shoot": {
		"scene_path":"res://scene/abilities/water_shoot.tscn" ,
		"icon_path": "res://assets/ui/abilities_icon/water_shoot.png"
	},
	"steam": {
		"scene_path":"res://scene/abilities/steam.tscn",
		"icon_path": "res://assets/ui/abilities_icon/steam.png"
	},
	"fire_tornado": {
		"scene_path": "res://scene/abilities/fire_tornado.tscn",
		"icon_path":"res://assets/ui/abilities_icon/fire_tornado.png"
	},
	"huracan": {
		"scene_path": "res://scene/abilities/huracan.tscn",
		"icon_path":"res://assets/ui/abilities_icon/huracan.png"
	},
	"black_laser": {
		"scene_path": "res://scene/abilities/black_laser.tscn",
		"icon_path":"res://assets/ui/abilities_icon/black_laser.png"
	}
}


var stone_icon = {
	"fire":"res://assets/ui/stones/stone_fire.png",
	"wind":"res://assets/ui/stones/stone_air.png",
	"water":"res://assets/ui/stones/stone_water.png"
}


func get_power_meta(power_name: String) -> Dictionary:
	if powers_meta.has(power_name):
		return powers_meta[power_name]
	else:
		push_warning("Poder no encontrado en powers_meta: " + power_name)
		return {}

func get_power_data(power_name: String) -> Dictionary:
	# Buscar el nivel del poder en powers_and_level
	for power_dict in powers_and_level:
		if power_dict.power == power_name:
			var level = power_dict.level
			# Devolver los datos del poder al nivel correspondiente
			if powers_data.has(power_name):
				if powers_data[power_name].has(level):
					return powers_data[power_name][level]
				else:
					push_error("Nivel %d no encontrado para el poder %s" % [level, power_name])
					return {}
			else:
				push_error("Poder %s no encontrado en powers_data" % power_name)
				return {}
	# Si no se encontró el poder
	push_error("Poder %s no encontrado en powers_and_level" % power_name)
	return {}

func get_power_level(power_name: String) -> int:
	for power_dict in powers_and_level:
		if power_dict["power"] == power_name:
			return power_dict["level"]
	return 0

func get_power_stats(power_name: String) -> Dictionary:
	var level = get_power_level(power_name)
	if power_name in powers_data and level in powers_data[power_name]:
		return powers_data[power_name][level]
	return {}

func upgrade_power_level(power_name: String) -> bool:
	for item in powers_and_level:
		if item["power"] == power_name:
			var current_level = item["level"]
			if current_level < 6:
				item["level"] += 1
				return true
			else:
				return false
	return false

func try_upgrade_power(power_name: String) -> bool:
	for power_data in powers_and_level:
		if power_data["power"] == power_name:
			var current_level = power_data["level"]
			if current_level >= 6:
				return false
			
			# Obtener los requisitos del próximo nivel
			var upgrade_info = powers_data[power_name].get(current_level)
			if upgrade_info == null or not upgrade_info.has("upgrade_item"):
				return false

			var can_upgrade = true
			for requirement in upgrade_info["upgrade_item"]:
				match requirement["type"]:
					"fire":
						if fire_amount < requirement["amount"]:
							can_upgrade = false
					"wind":
						if wind_amount < requirement["amount"]:
							can_upgrade = false
					"water":
						if water_amount < requirement["amount"]:
							can_upgrade = false

			if not can_upgrade:
				return false

			# Consumir recursos
			for requirement in upgrade_info["upgrade_item"]:
				match requirement["type"]:
					"fire":
						fire_amount -= requirement["amount"]
					"wind":
						wind_amount -= requirement["amount"]
					"water":
						water_amount -= requirement["amount"]

			# Subir nivel
			power_data["level"] += 1

			# Si subió de 0 a 1, añadirlo a active_powers
			if power_data["level"] == 1 and not power_name in active_powers:
				active_powers.append(power_name)

			return true

	return false
func set_actual_amount_element(name: String, value: int) -> void:
	match name:
		"fire":
			fire_amount = value
		"wind":
			wind_amount = value
		"water":
			water_amount = value
		_:
			push_error("Elemento desconocido: %s" % name)
			
func get_actual_amount_element(name: String) -> int:
	match name:
		"fire":
			return fire_amount
		"wind":
			return wind_amount
		"water":
			return water_amount
		_:
			push_error("Elemento desconocido: %s" % name)
			return -1

func add_elemnt(name: String):
	match name:
		"fire":
			fire_amount+=1
		"wind":
			wind_amount+=1
		"water":
			water_amount+=1
		"nothing":
			pass
		_:
			push_error("Elemento desconocido: %s" % name)
			return

func get_most_demanding_upgrade_power(max_fire: int, max_wind: int, max_water: int) -> String:
	var best_power = ""
	var highest_cost = -1

	for power_dict in powers_and_level:
		var power_name = power_dict["power"]
		var level = power_dict["level"]

		# Ignorar poderes ya al máximo o sin datos de mejora
		if level >= 6 or not powers_data.has(power_name):
			continue

		var level_data = powers_data[power_name].get(level, null)
		if level_data == null or not level_data.has("upgrade_item"):
			continue

		var upgrade_items = level_data["upgrade_item"]
		var total_cost = 0
		var temp_fire = 0
		var temp_wind = 0
		var temp_water = 0
		var can_afford = true

		for req in upgrade_items:
			match req["type"]:
				"fire":
					temp_fire += req["amount"]
				"wind":
					temp_wind += req["amount"]
				"water":
					temp_water += req["amount"]

		# Validar si podemos permitirnos este poder
		if temp_fire > max_fire or temp_wind > max_wind or temp_water > max_water:
			continue

		total_cost = temp_fire + temp_wind + temp_water

		# Guardar si es el más caro que podemos permitir
		if total_cost > highest_cost:
			highest_cost = total_cost
			best_power = power_name

	return best_power

var world_levels = {
	0: {"gnomes": 10, "minotaurs": 0, "gnome_hp": 120, "gnome_damage": 10, "gnome_knockback": 1.2, "gnome_speed": 1.5, "minotaur_hp": 0, "minotaur_damage": 0, "minotaur_knockback": 0, "minotaur_speed": 0},
	1: {"gnomes": 12, "minotaurs": 1, "gnome_hp": 130, "gnome_damage": 12, "gnome_knockback": 1.3, "gnome_speed": 1.5, "minotaur_hp": 250, "minotaur_damage": 35, "minotaur_knockback": 0.8, "minotaur_speed": 1.0},
	2: {"gnomes": 14, "minotaurs": 2, "gnome_hp": 140, "gnome_damage": 14, "gnome_knockback": 1.4, "gnome_speed": 1.55, "minotaur_hp": 270, "minotaur_damage": 40, "minotaur_knockback": 0.8, "minotaur_speed": 1.05},
	3: {"gnomes": 15, "minotaurs": 3, "gnome_hp": 150, "gnome_damage": 16, "gnome_knockback": 1.5, "gnome_speed": 1.55, "minotaur_hp": 290, "minotaur_damage": 45, "minotaur_knockback": 0.8, "minotaur_speed": 1.1},
	4: {"gnomes": 13, "minotaurs": 5, "gnome_hp": 160, "gnome_damage": 18, "gnome_knockback": 1.6, "gnome_speed": 1.6, "minotaur_hp": 310, "minotaur_damage": 50, "minotaur_knockback": 0.75, "minotaur_speed": 1.15},
	5: {"gnomes": 10, "minotaurs": 7, "gnome_hp": 170, "gnome_damage": 20, "gnome_knockback": 1.7, "gnome_speed": 1.6, "minotaur_hp": 330, "minotaur_damage": 55, "minotaur_knockback": 0.75, "minotaur_speed": 1.2},
	6: {"gnomes": 8, "minotaurs": 10, "gnome_hp": 185, "gnome_damage": 22, "gnome_knockback": 1.8, "gnome_speed": 1.6, "minotaur_hp": 360, "minotaur_damage": 60, "minotaur_knockback": 0.7, "minotaur_speed": 1.25},
	7: {"gnomes": 6, "minotaurs": 13, "gnome_hp": 200, "gnome_damage": 24, "gnome_knockback": 1.9, "gnome_speed": 1.65, "minotaur_hp": 390, "minotaur_damage": 65, "minotaur_knockback": 0.7, "minotaur_speed": 1.3},
	8: {"gnomes": 4, "minotaurs": 16, "gnome_hp": 220, "gnome_damage": 26, "gnome_knockback": 2.0, "gnome_speed": 1.65, "minotaur_hp": 420, "minotaur_damage": 70, "minotaur_knockback": 0.65, "minotaur_speed": 1.35},
	9: {"gnomes": 2, "minotaurs": 20, "gnome_hp": 240, "gnome_damage": 28, "gnome_knockback": 2.1, "gnome_speed": 1.7, "minotaur_hp": 450, "minotaur_damage": 75, "minotaur_knockback": 0.65, "minotaur_speed": 1.4},
	10: {"gnomes": 1, "minotaurs": 24, "gnome_hp": 260, "gnome_damage": 30, "gnome_knockback": 2.2, "gnome_speed": 1.75, "minotaur_hp": 470, "minotaur_damage": 78, "minotaur_knockback": 0.6, "minotaur_speed": 1.45},
	11: {"gnomes": 0, "minotaurs": 28, "gnome_hp": 0, "gnome_damage": 0, "gnome_knockback": 0, "gnome_speed": 0, "minotaur_hp": 490, "minotaur_damage": 82, "minotaur_knockback": 0.6, "minotaur_speed": 1.5},
	12: {"gnomes": 0, "minotaurs": 30, "gnome_hp": 0, "gnome_damage": 0, "gnome_knockback": 0, "gnome_speed": 0, "minotaur_hp": 500, "minotaur_damage": 85, "minotaur_knockback": 0.55, "minotaur_speed": 1.55},
	13: {"gnomes": 5, "minotaurs": 30, "gnome_hp": 280, "gnome_damage": 32, "gnome_knockback": 2.3, "gnome_speed": 1.75, "minotaur_hp": 500, "minotaur_damage": 85, "minotaur_knockback": 0.55, "minotaur_speed": 1.6},
	14: {"gnomes": 10, "minotaurs": 30, "gnome_hp": 280, "gnome_damage": 34, "gnome_knockback": 2.4, "gnome_speed": 1.8, "minotaur_hp": 500, "minotaur_damage": 85, "minotaur_knockback": 0.55, "minotaur_speed": 1.65},
	15: {"gnomes": 15, "minotaurs": 35, "gnome_hp": 280, "gnome_damage": 36, "gnome_knockback": 2.5, "gnome_speed": 1.85, "minotaur_hp": 500, "minotaur_damage": 90, "minotaur_knockback": 0.5, "minotaur_speed": 1.7},
	16: {"gnomes": 20, "minotaurs": 38, "gnome_hp": 280, "gnome_damage": 38, "gnome_knockback": 2.6, "gnome_speed": 1.9, "minotaur_hp": 510, "minotaur_damage": 92, "minotaur_knockback": 0.5, "minotaur_speed": 1.75},
	17: {"gnomes": 22, "minotaurs": 40, "gnome_hp": 280, "gnome_damage": 40, "gnome_knockback": 2.7, "gnome_speed": 1.95, "minotaur_hp": 520, "minotaur_damage": 95, "minotaur_knockback": 0.5, "minotaur_speed": 1.8},
	18: {"gnomes": 24, "minotaurs": 42, "gnome_hp": 280, "gnome_damage": 42, "gnome_knockback": 2.8, "gnome_speed": 2.0, "minotaur_hp": 530, "minotaur_damage": 98, "minotaur_knockback": 0.45, "minotaur_speed": 1.85},
	19: {"gnomes": 26, "minotaurs": 45, "gnome_hp": 280, "gnome_damage": 44, "gnome_knockback": 2.9, "gnome_speed": 2.0, "minotaur_hp": 540, "minotaur_damage": 100, "minotaur_knockback": 0.45, "minotaur_speed": 1.9},
	20: {"gnomes": 30, "minotaurs": 50, "gnome_hp": 280, "gnome_damage": 46, "gnome_knockback": 3.0, "gnome_speed": 2.05, "minotaur_hp": 550, "minotaur_damage": 105, "minotaur_knockback": 0.4, "minotaur_speed": 2.0},
	21: {"gnomes": 40, "minotaurs": 60, "gnome_hp": 280, "gnome_damage": 48, "gnome_knockback": 3.1, "gnome_speed": 2.1, "minotaur_hp": 560, "minotaur_damage": 110, "minotaur_knockback": 0.4, "minotaur_speed": 2.1},
	22: {"gnomes": 50, "minotaurs": 75, "gnome_hp": 280, "gnome_damage": 50, "gnome_knockback": 3.2, "gnome_speed": 2.15, "minotaur_hp": 570, "minotaur_damage": 115, "minotaur_knockback": 0.4, "minotaur_speed": 2.2},
	23: {"gnomes": 60, "minotaurs": 90, "gnome_hp": 280, "gnome_damage": 52, "gnome_knockback": 3.3, "gnome_speed": 2.2, "minotaur_hp": 580, "minotaur_damage": 120, "minotaur_knockback": 0.35, "minotaur_speed": 2.3},
	24: {"gnomes": 70, "minotaurs": 105, "gnome_hp": 280, "gnome_damage": 54, "gnome_knockback": 3.4, "gnome_speed": 2.25, "minotaur_hp": 590, "minotaur_damage": 125, "minotaur_knockback": 0.35, "minotaur_speed": 2.4},
	25: {"gnomes": 80, "minotaurs": 120, "gnome_hp": 280, "gnome_damage": 56, "gnome_knockback": 3.5, "gnome_speed": 2.3, "minotaur_hp": 600, "minotaur_damage": 130, "minotaur_knockback": 0.3, "minotaur_speed": 2.5}
};
