extends Node2D

@onready var canvas_modulate = $CanvasModulate
@onready var canvas_layer = $CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	canvas_modulate.show()
	canvas_layer.show()
