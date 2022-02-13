extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var courtroom_timer = get_node("CourtroomTimer")
var seconds = 0
var minutes = 0
var mob_scenes = [load("res://ArabWoman.tscn"), load("res://BlackMan.tscn"),
	load("res://WhiteMan.tscn"), load("res://WhiteWoman.tscn")]
var mob_instances = []
var rand = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	courtroom_timer.start()
	rand.randomize()
	
	for mob_scene in mob_scenes:
		mob_instances.append(mob_scene.instance())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Calculate and display score
	var score = 0
	for mob_instance in mob_instances:
		score += mob_instance.total_points
	$CourtroomScoreLabel.set_text("Score:  " + str(score))


# Sets minutes and seconds and prints to CourtroomTimerLabel
var mob_index = 0
func _on_CourtroomTimer_timeout():
	# Set minutes + seconds, and stop timer at 1:00
	if minutes == 1:
		courtroom_timer.stop()
	elif seconds == 59:
		minutes += 1
		seconds = 0
	else:
		seconds += 1
	
	# Print time to CourtroomTimerLabel
	$CourtroomTimerLabel.set_text("Time:  " + str(minutes).pad_zeros(1) +
		" : " + str(seconds).pad_zeros(2))
	
	# Spawn and remove mob instances
	remove_child(mob_instances[mob_index])
	var x = rand.randf_range(0, 1920)
	var y = rand.randf_range(0, 1080)
	mob_index = rand.randi_range(0, mob_instances.size()-1)
	mob_instances[mob_index].position.x = x
	mob_instances[mob_index].position.y = y
	add_child(mob_instances[mob_index])
