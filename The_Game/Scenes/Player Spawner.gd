extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = preload("res://Scenes/Player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_player = player.instance()
	new_player.position = self.position
	owner.call_deferred("add_child", new_player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
