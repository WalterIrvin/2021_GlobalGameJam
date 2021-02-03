extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 500
var total_vel = Vector2(0, 0)
var weapon = null
var health = 100
var dead = false
# Called when the node enters the scene tree for the first time.
func _ready():
	weapon = get_child(1)
	weapon.switch_weapon("pistol")

func damage(damage):
	self.health -= damage
	if self.health <= 0:
		self.dead = true

func process_input():
	# process input for movement and weapon switching
	if Input.is_action_just_pressed("hotkey_1"):
		weapon.switch_weapon("pistol")
	if Input.is_action_just_pressed("hotkey_2"):
		weapon.switch_weapon("shotgun")
	if Input.is_action_just_pressed("hotkey_3"):
		weapon.switch_weapon("chaingun")

	var vel_x = Vector2(0, 0)
	var vel_y = Vector2(0, 0)
	if Input.is_action_pressed("move_forward"):
		vel_y.y = -1
	if Input.is_action_pressed("move_backward"):
		vel_y.y = 1
	if Input.is_action_pressed("move_left"):
		vel_x.x = -1
	if Input.is_action_pressed("move_right"):
		vel_x.x = 1
	self.total_vel = (vel_x + vel_y) * self.speed
	
	if Input.is_action_pressed("fire"):
		#TODO replace with weapon fire script
		weapon.fire()
	

#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.dead:
		get_tree().root.get_child(0).death_cam()
		queue_free()
	process_input()
	look_at(get_global_mouse_position())
	self.total_vel  = move_and_slide(self.total_vel)
