extends Control

@onready var text_area = %text_area
@onready var dep = $dep
@onready var final = $final

@export var door: StaticBody2D
@export var player: CharacterBody2D = null

var text_list = AutoLoad.tuto_text_list
var text_x = 0
var wait = false

func _ready():
	print(text_list)
	print(text_list[text_x])
	text_area.text = text_list[text_x]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not wait:
		if text_x == 0:
			if player != null and player.input_vector != Vector2.ZERO:
				wait = true
				dep.start()	
		if text_x == 1:
			if Input.is_action_just_pressed("small") or Input.is_action_just_pressed("big"):
				wait = true
				dep.start()	
		if text_x == 2:
			if player.keyNumber == 1:
				wait = true
				change_text()
				door.queue_free()
				final.start()	

func change_text():
	text_x += 1
	if text_x >= text_list.size():
		queue_free()
	else:
		text_area.text = text_list[text_x]
	
func _on_dep_timeout():
	wait = false
	change_text()
	
func _on_final_timeout():
	wait = false
	change_text()
