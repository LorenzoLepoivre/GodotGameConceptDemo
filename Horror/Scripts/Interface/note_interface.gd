extends Control

@onready var zone_text = %zone_text
@onready var new_text = %new_text
@onready var new = $new
@onready var image = %image
@onready var open_sound = $open

var is_in = false
var is_visible = false
var player = null

func _ready():
	hide()
	new_text.hide()

func made_visible(number):
	open_sound.play()
	show()
	if AutoLoad.BESTIAIRE_VALUES[number] == 0:
		AutoLoad.BESTIAIRE_VALUES[number] = 1
		new_text.show()
		new.start()
	zone_text.text = AutoLoad.note_text[number]
	image.texture = load(AutoLoad.note_image_path[number])

func made_invisible():
	hide()

func _on_new_timeout():
	new_text.hide()
