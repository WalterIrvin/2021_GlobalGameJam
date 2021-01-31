extends Node2D

export (PackedScene) var Player
var p = null

func _ready():
	p = Player.instance()
	add_child(p)
	p.position = $PlayerSpawner.global_position
