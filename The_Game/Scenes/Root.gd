extends Node2D
var death_screen = null
var dead = false
func _ready():
	pass

func death_cam():
	# sets a death_screen while dead
	self.dead = true

func spawn_cam():
	# returns camera to normal after respawn
	self.dead = false

func _process(_delta):
	if self.death_screen == null:
		self.death_screen = get_child(0).get_child(0)
	if self.death_screen != null:
		self.death_screen.visible = self.dead
