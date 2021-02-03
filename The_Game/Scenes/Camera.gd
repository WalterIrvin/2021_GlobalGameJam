extends Node2D

onready var window_size = OS.get_window_size()
var player_ref = null
var old_player_grid = null
var desired_position = Vector2(0, 0)
var follow_speed = 3
var first_snap = true

# The following script makes a LoZ-style camera
func _ready():
	pass
	
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
	var new_player_grid = get_player_grid_pos()
	
	if new_player_grid != old_player_grid:
		old_player_grid = new_player_grid
		if first_snap:
			self.position = self.window_size * new_player_grid
			self.desired_position = self.position
			self.first_snap = false
		else:
			self.desired_position = self.window_size * new_player_grid
			var offset = self.desired_position - self.player_ref.global_position
			print(offset)
	
func _process(delta):
	if player_ref == null:
		player_ref = get_tree().get_nodes_in_group("Players")[0]
	else:
		update_camera()
		self.position = self.position.linear_interpolate(self.desired_position, follow_speed * delta)
		# self.position = player_ref.global_position
