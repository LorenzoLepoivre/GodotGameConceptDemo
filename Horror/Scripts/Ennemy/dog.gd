extends CharacterBody2D

var speed = 60
var health = 100
var is_chasing = false
var is_attacking = false
var player = null

@onready var anim = $AnimatedSprite2D
@onready var life_bar = $LifeBar
@onready var in_zone = $InZone
@onready var timer_attack = $TimerAttack

func _ready():
	anim.play("idle")
	life_bar.init(health)
	
func _physics_process(_delta):
	if AutoLoad.is_in_pause == false:
		animation()
		if is_chasing and player != null:
			velocity = (player.position - position).normalized() * speed
		else:
			velocity = Vector2()
		move_and_slide()
	if AutoLoad.is_in_pause:
		anim.stop()
	
func animation():
	if player != null:
		if(player.position.x - position.x) < 1:
			anim.flip_h = false
		else:
			anim.flip_h = true
			
	if is_attacking:
		anim.play("jump")
	elif is_chasing:
		anim.play("run")
	else:
		anim.play("idle")
		

func _on_dectetion_area_body_entered(body):
	if body.name == "Player":
		player = body
		in_zone.start()
		
func _on_dectetion_area_body_exited(body):
	if body.name == "Player":
		player = null
		in_zone.stop()
		is_chasing = false
		is_attacking = false
		
func _on_in_zone_timeout():
	if player != null and player.light_statue > 0:
		is_chasing = true
		in_zone.stop()
		
func _on_timer_attack_timeout():
	if player != null and is_attacking and AutoLoad.is_in_pause == false:
		player.changeHealth(-20)

func _on_attack_area_body_entered(body):
	if body.name == "Player":
		is_attacking = true
		timer_attack.start()

func _on_attack_area_body_exited(body):
	if body.name == "Player":
		is_attacking = false
		timer_attack.stop()
