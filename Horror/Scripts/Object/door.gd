extends AnimatedSprite2D

var state = 0
var player = null
var is_anim = false
@export_file var dest_scene
@onready var open_sound = $open

func _ready():
	self.play("close")

func _on_area_2d_body_entered(body):
	if body.name == "Player" and not is_anim:
		body.set_openDoor_prompt(true, self)
		player = body

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		body.set_openDoor_prompt(false, null)
		player = null

func open():
	if player != null and player.getKeyNumber() == 3:
		state += 1
		if state > 2:
			state = 2
		if state == 1:
			player.set_openDoor_prompt(false, null)
			self.play("transform")
			open_sound.play()
			is_anim = true
		if state == 2:
			player.set_openDoor_prompt(false, null)
			AutoLoad.actualDonjon += 1
			AutoLoad.actualLevel += 1
			get_tree().change_scene_to_file(dest_scene) 

func _on_animation_looped():
	if state == 1:
		is_anim = false
		self.play("open")
		if player != null:
			player.set_openDoor_prompt(true, self)
