extends Node

#VARIABLE
var is_in_pause = false
var is_in_menu = null
var actualDonjon = 0
var actualLevel = 0
var langue = 1 #0 = français, 1 = anglais

#TOUCHES
var key_up = "Z"
var key_down = "S"
var key_left = "Q"
var key_right = "D"
var key_small = "A"
var key_big = "E"

#LISTES DES NIVEAUX
var ALL_LEVELS = [["res://Levels/Donjon1/D1L1.tscn"]]

#BESTIAIRE
var BESTIAIRE_VALUES = [0,0]
var note_text_fr = ["Les orcs sont des ennemis basiques. Ils s'attaqueront à toi si tu t'approches trop près. Tu peux les tuer en les éclairant avec ta lampe à puissance maximale.", 
				"Les chiens sont dangereux. Ils s'attaqueront à toi si tu es trop proche et que tu es éclairé. Éteins donc ta lampe à proximité d'eux. Ils n'ont aucun point faible. S'ils t'attaquent, COURS !!!"]
var note_text_ang = ["Orcs are basic enemies. They will attack you if you get too close. You can kill them by shining your lamp at maximum power on them.",
					"Dogs are dangerous. They will attack you if you are too close and illuminated. So, turn off your lamp when near them. They have no weaknesses. If they attack you, RUN!!!"]
var all_note_text = [note_text_fr, note_text_ang]
var note_text = all_note_text[langue]
var note_image_path = ["res://Assets/Graphics/Bestiaire/orc.png", "res://Assets/Graphics/Bestiaire/dog.png"]

#TUTO
var tuto_text_fr = ["Appuyer sur %s, %s, %s, %s pour vous déplacer" % [key_up, key_left, key_down, key_right],
				"Appuyer sur %s et %s pour changer le mode d'éclairage" % [key_small, key_big],
				"Une clé se trouve dans cette pièce il faut l'éclairer pour pouvoir la ramasser. Trouver la pour quitter cette pièce",
				"Trouver les 3 clé afin d'ouvrir la porte de sortie du niveau"]
				
var tuto_text_en = ["Press %s, %s, %s, %s to move" % [key_up, key_left, key_down, key_right],
				"Press %s and %s to change the lighting mode" % [key_small, key_big],
				"A key is in this room, you need to illuminate it to pick it up. Find it to leave this room",
				"Find the 3 keys to open the exit door of the level"]
				
var tuto_all_text = [tuto_text_fr, tuto_text_en]
var tuto_text_list = tuto_all_text[langue]

#DIALOGUE
