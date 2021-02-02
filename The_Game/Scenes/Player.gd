extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 5
var total_vel = Vector2(0, 0)
var weapon = null
# Called when the node enters the scene tree for the first time.
func _ready():
	weapon = get_child(0)
	weapon.switch_weapon("pistol")

func process_input():
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
	self.total_vel = vel_x + vel_y
	
	if Input.is_action_pressed("fire"):
		#TODO replace with weapon fire script
		weapon.fire()
	

#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	process_input()
	look_at(get_global_mouse_position())
	self.position += total_vel * speed
