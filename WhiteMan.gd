extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var POINTS = 2
var total_points = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_WhiteMan_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		total_points += POINTS
		get_parent().remove_child(self)
