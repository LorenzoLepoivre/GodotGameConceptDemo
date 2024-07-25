extends CharacterBody2D

const MAX_SPEED = 90
const ACCELERATION = 500
const FRICTION = 500
const LIGHT_SMALL = 0.7
const LIGHT_BIG = 1.4
const LIST_LIGHT_VALUES = [0, LIGHT_SMALL, LIGHT_BIG]

@onready var light = $PointLight2D
@onready var anim = $AnimatedSprite2D
@onready var power_bar = %PowerBar
@onready var life_bar = $CanvasLayer/LifeBar
@onready var fKey = $F
@onready var animation_key = $AnimationPlayer
@onready var key_1 = %key1
@onready var key_2 = %key2
@onready var key_3 = %key3
@onready var dammage_cooldown = $DammageCooldown
@onready var key_sound = $keySound
@onready var random_lightning = $randomLightning
@onready var stop_lightning = $stopLightning
@onready var canvas_layer = $CanvasLayer
@onready var dead_timer = $dead_timer

#SONS
@onready var get_battery = $getBattery
@onready var power_down = $powerDown
@onready var lightning_sound = $lightningSound
@onready var switch_sound = $switchSound
@onready var dammage_1_sound = $dammage1
@onready var dammage_2_sound = $dammage2
@onready var dammage_3_sound = $dammage3
@onready var dammage_4_sound = $dammage4
var dammage_sounds = [dammage_1_sound, dammage_2_sound, dammage_3_sound, dammage_4_sound]
var dammage_index = 0
@onready var dead = $dead


var rng = RandomNumberGenerator.new()
var direct
var input_vector = Vector2.ZERO
var light_statue = 1
var health = 100
var power = 100
var door 
var keyNumber = 0
var is_intouchable = false
var is_lightning = false
var has_battery = true

func _ready():
	canvas_layer.show()
	life_bar.init(health)
	direct = "right"
	anim.flip_h = false
	light.texture_scale = LIGHT_SMALL
	power_bar.value = 100
	random_lightning.wait_time = rng.randi_range(60, 180)
	random_lightning.start()
	set_openDoor_prompt(false, null)
	
func _physics_process(delta):
	if AutoLoad.is_in_pause == false:
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		input_vector = input_vector.normalized()
		change_light_intensity()
		move_and_anim(delta)
		move_and_slide()
		if door != null:
			if Input.is_action_just_pressed("interact"):
				door.open()
	if AutoLoad.is_in_pause:
		anim.stop()
		
func move_and_anim(delta):
	if input_vector != Vector2.ZERO:
		if input_vector.x > 0:
			direct = "right"
			anim.play("side_walk")
			anim.flip_h = false
		elif input_vector.x < 0:
			direct = "left"
			anim.play("side_walk")
			anim.flip_h = true
		elif input_vector.y < 0:
			anim.play("back_walk")
			direct = "back"
		elif input_vector.y > 0:
			anim.play("front_walk")
			direct = "front"
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		if direct == "right":
			anim.play("side_idle")
			anim.flip_h = false
		elif direct == "left":
			anim.play("side_idle")
			anim.flip_h = true
		elif direct == "back":
			anim.play("back_idle")
		elif direct == "front":
			anim.play("front_idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

#LIGHT
func change_light(x):
	if not is_lightning:
		light_statue += x
		if light_statue < 0:
			light_statue = 0
		elif  light_statue > 2:
			light_statue = 2
		else:
			switch_sound.play()
		light.texture_scale = LIST_LIGHT_VALUES[light_statue]
		
func getPower(x):
	power += x
	get_battery.play()
	change_powerBar()
	
func change_light_intensity():
	if power > 0:
		if Input.is_action_just_pressed("small"):
			change_light(-1)
		if Input.is_action_just_pressed("big"):
			change_light(1)
		
func change_powerBar():
	if power > 100:
		power = 100
	elif power < 0:
		if has_battery:
			power_down.play()
		power = 0
		has_battery = false
		change_light(-5)
	power_bar.value = power
	
func _on_power_tick_timeout():
	if light_statue == 1:
		power -= 0.1
	elif light_statue == 2:
		power -= 0.5
	change_powerBar()

func _on_light_big_area_body_entered(body):
	if body.name.substr(0, 3) == "Orc":
		body.getDammage(true)

func _on_light_big_area_body_exited(body):
	if body.name.substr(0, 3) == "Orc":
		body.getDammage(false)

#HEALTH
func changeHealth(x):
	if not is_intouchable:
		if x < 0:
			dammage_index = rng.randi_range(0, 3)
			dammage_2_sound.play()
			#dammage_sounds[dammage_index].play()
		health += x
		if health > 100:
			health = 100
		elif health < 0:
			AutoLoad.is_in_pause = true
			dead.play()
			dead_timer.start()
		life_bar.setHealth(health)
		is_intouchable = true
		dammage_cooldown.start()
	
func _on_dammage_cooldown_timeout():
	is_intouchable = false

#TOUCH
func show_key():
	fKey.show()
	animation_key.play("KeyPrompt")
func hide_key():
	fKey.hide()
	animation_key.stop()
#DOOR
func set_openDoor_prompt(x, d):
	if x:
		show_key()
	else:
		hide_key()
	door = d

func getKey():
	key_sound.play()
	keyNumber += 1
	if keyNumber == 1:
		key_1.play("color")
	elif keyNumber == 2:
		key_2.play("color")
	elif keyNumber == 3:
		key_3.play("color")

#LIGHTNING
func _on_random_lightning_timeout():
	is_lightning = true
	stop_lightning.start()
	light_statue = 2
	lightning_sound.play()
	light.texture_scale = 2
	
func _on_stop_lightning_timeout():
	is_lightning = false
	light.texture_scale = LIST_LIGHT_VALUES[light_statue]
	getPower(20)
	random_lightning.wait_time = rng.randi_range(55, 110)
	random_lightning.start()
	
#GETTER
func getKeyNumber():
	return keyNumber

func _on_dead_timer_timeout():
	AutoLoad.is_in_pause= false
	get_tree().change_scene_to_file("res://Levels/dead_scene.tscn")
