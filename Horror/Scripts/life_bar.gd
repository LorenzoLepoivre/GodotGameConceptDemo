extends ProgressBar

@onready var dammage_bar = $DammageBar
@onready var timer = $Timer

var health

func init(h):
	health = h
	value = h
	dammage_bar.value = h
	
func setHealth(h):
	var prev_health = health
	health = min(max_value, h)
	value = health
	
	if health < prev_health:
		timer.start()
	else:
		dammage_bar.value = health

func _on_timer_timeout():
	dammage_bar.value = health
