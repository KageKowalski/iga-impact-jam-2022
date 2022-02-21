extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_set_DifficultyButton_label()
	$StartButton.set_text("Start")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	get_tree().change_scene("res://Courtroom.tscn")


func _on_DifficultyButton_pressed():
	if global.difficulty == "Easy":
		global.difficulty = "Medium"
		_set_DifficultyButton_label()
	elif global.difficulty == "Medium":
		global.difficulty = "Hard"
		_set_DifficultyButton_label()
	elif global.difficulty == "Hard":
		global.difficulty = "Easy"
		_set_DifficultyButton_label()


func _set_DifficultyButton_label():
	$DifficultyButton.set_text(global.difficulty)
