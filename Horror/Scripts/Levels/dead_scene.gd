extends Control

@onready var rich_text_label = $RichTextLabel
@onready var menu_but = $menuBut
var langue = AutoLoad.langue 
var texts = ["TU ES MORT", "YOU ARE DEAD"]
var texts_button = ["Retour au menu", "Go back to menu"]
# Called when the node enters the scene tree for the first time.
func _ready():
	menu_but.text = texts_button[langue]
	rich_text_label.text = texts[langue]
func _on_menu_but_pressed():
	get_tree().change_scene_to_file("res://Levels/main_menu.tscn")

