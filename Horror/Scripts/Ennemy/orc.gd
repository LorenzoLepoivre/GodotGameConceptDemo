extends CharacterBody2D

var is_attacking = false
var is_chasing = false
var player = null
var speed = 40
var is_hurt = false
var health = 100

@onready var anim = $AnimatedSprite2D
@onready var timer_attack = $TimerAttack
@onready var life_bar = $LifeBar
@onready var dammage_tick = $DammageTick

func _ready():
	anim.play("default")
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
			anim.flip_h = true
		else:
			anim.flip_h = false
			
	if is_attacking:
		anim.play("attack")
	elif is_chasing:
		anim.play("walk")
	else:
		anim.play("default")

func getDammage(x):
	is_hurt = x
	if is_hurt:
		dammage_tick.start()
	else:
		dammage_tick.stop()

func changeHealth(x):
	health += x
	if health > 100:
		health = 100
	elif health <= 0:
		queue_free()
	life_bar.setHealth(health)
	
#GESTION DES AREA
func _on_detection_area_body_entered(body):
	if body.name == "Player":
		is_chasing = true
		player = body
	
func _on_detection_area_body_exited(body):
	if body.name == "Player":
		is_chasing = false
		player = null
		
func _on_attack_area_body_entered(body):
	if body.name == "Player":
		is_attacking = true
		timer_attack.start()

func _on_attack_area_body_exited(body):
	if body.name == "Player":
		is_attacking = false
		timer_attack.stop()

#TIMER
func _on_timer_attack_timeout():
	if is_attacking:
		player.changeHealth(-10)

func _on_dammage_tick_timeout():
	if is_hurt and player.light_statue == 2 and AutoLoad.is_in_pause==false:
		changeHealth(-10)
		
