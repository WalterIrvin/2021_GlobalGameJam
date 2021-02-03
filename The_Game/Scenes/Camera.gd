extends Node2D

onready var window_size = OS.get_window_size()
var player_ref = null
var old_player_grid_pos = null
var first_check = true  # auto sets to player location

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_player():
	var group = get_tree().get_nodes_in_group("Players")
	var closest_dist = INF
	var closest_player = null
	for player in group:
		var cur_dist = (player.position - self.position).length()
		if cur_dist < closest_dist:
			closest_player = player
	self.player_ref = closest_player

func get_player_grid_pos():
	if self.player_ref != null:
		var pos = self.player_ref.global_position
		var x = floor(pos.x / window_size.x)
		var y = floor(pos.y / window_size.y)
		return Vector2(x, y)
	else:
		return null

func update_camera():
	self.window_size = OS.get_window_size()
	var new_player_grid_pos = get_player_grid_pos()
	var transform = Transform2D()
	var old_transform = Transform2D()
	
	if new_player_grid_pos != old_player_grid_pos or first_check:
		old_player_grid_pos = new_player_grid_pos
		old_transform = get_viewport().get_canvas_transform()
		transform = get_viewport().get_canvas_transform()
		transform[2] = -new_player_grid_pos * window_size
		get_viewport().set_canvas_transform(transform)
		first_check = false
	return transform

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.player_ref == null:
		get_player()
		old_player_grid_pos = get_player_grid_pos()
	else:
		update_camera()
