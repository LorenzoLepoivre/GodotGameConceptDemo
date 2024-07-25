extends Control  # Assumes the script is attached to a Control node or its descendant

@onready var orc_b = %OrcB
@onready var dog_b = %DogB

var button_list = [orc_b, dog_b]

func _ready():
	for i in range(AutoLoad.BESTIAIRE_VALUES.size()):
		if AutoLoad.BESTIAIRE_VALUES[i] == 1:
			var icon_path = AutoLoad.note_image_path[i]  # Renommé en icon_path pour plus de clarté
			var icon_texture = load(icon_path)  # Utilise load pour charger l'icône
			if button_list[i] and icon_texture:  # Vérifie que le bouton et l'icône sont chargés correctement
				button_list[i].icon = icon_texture
			else:
				if not button_list[i]:
					print("Erreur: Bouton à l'index ", i, " est invalide.")
				if not icon_texture:
					print("Erreur: Impossible de charger l'icône depuis le chemin: ", icon_path)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Levels/main_menu.tscn")
