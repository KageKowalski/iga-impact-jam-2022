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
var mob_index = 0
var ran_num = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	courtroom_timer.start()
	rand.randomize()
	ran_num = rand.randf_range(0, 10000)
	
	for mob_scene in mob_scenes:
		mob_instances.append(mob_scene.instance())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Calculate and display score
	global.score = 0
	for mob_instance in mob_instances:
		global.score += mob_instance.total_points
	$CourtroomScoreLabel.set_text("Score:  " + str(global.score))
	
	# Handle mobs based on difficulty
	if global.difficulty == "Easy":
		ran_num -= 20
		if ran_num < 50:
			ran_num = rand.randf_range(0, 10000)
			_spawn_mob_instance()
	elif global.difficulty == "Medium":
		ran_num -= 40
		if ran_num < 50:
			ran_num = rand.randf_range(0, 10000)
			_spawn_mob_instance()
	elif global.difficulty == "Hard":
		ran_num -= 80
		if ran_num < 50:
			ran_num = rand.randf_range(0, 10000)
			_spawn_mob_instance()


# Remove old mob instance and spawn a new one
func _spawn_mob_instance():
	remove_child(mob_instances[mob_index])
	var x = rand.randf_range(0, 1920)
	var y = rand.randf_range(0, 1080)
	mob_index = rand.randi_range(0, mob_instances.size()-1)
	mob_instances[mob_index].position.x = x
	mob_instances[mob_index].position.y = y
	add_child(mob_instances[mob_index])


# Sets minutes and seconds and prints to CourtroomTimerLabel
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
	
	if minutes == 1 and seconds == 0:
		get_tree().change_scene("res://EndScreen.tscn")
