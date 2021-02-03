extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = preload("res://Scenes/Player.tscn")
var player_ref = null
var spawn_delay = 2.5
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn()

func spawn():
	var new_player = player.instance()
	new_player.position = self.position
	self.player_ref = new_player
	owner.call_deferred("add_child", new_player)
	get_tree().root.get_child(0).spawn_cam()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_ref == null:  #player is ded
		self.spawn_delay -= delta
		if self.spawn_delay <= 0:
			self.spawn_delay = 2.5
			spawn()
