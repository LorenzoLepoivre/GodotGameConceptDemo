extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		if body.health < 100:
			queue_free()
			body.changeHealth(10)
		
