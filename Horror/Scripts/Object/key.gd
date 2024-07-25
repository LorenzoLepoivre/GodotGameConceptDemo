extends Area2D


func _on_body_entered(body):
	if body.name == "Player" and body.light_statue > 0:
		queue_free()
		body.getKey()
