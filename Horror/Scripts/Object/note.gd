extends Control

@export var number = 0
@export var interface: Control = null

var is_in = false
var is_visible = false
var player = null

func _process(_delta):
	if is_in:
		if Input.is_action_just_pressed("interact"):
			if is_visible:
				AutoLoad.is_in_pause = false
				interface.made_invisible()
				is_visible = false
				queue_free()
			else:
				AutoLoad.is_in_pause = true
				interface.made_visible(number)
				is_visible = true

func _on_area_2d_body_entered(body):
	body.show_key()
	is_in = true
	player = body
	
func _on_area_2d_body_exited(body):
	body.hide_key()
	is_in = false
	player = null
	
