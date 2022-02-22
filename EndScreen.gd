extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$EndScreenScoreLabel.set_text("Score:  " + str(global.score))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_EndScreenYesButton_pressed():
	global.score = 0
	global.difficulty = "Easy"
	get_tree().change_scene("res://TitleScreen.tscn")


func _on_EndScreenNoButton_pressed():
	get_tree().quit()
