extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var bullet = preload("res://Scenes/Bullet.tscn")
var fired = false
var fire_limiter = 0
var fire_rate = 0
var damage = 0
var shells = 0
var spread = 0
# these variables help with bullet spawning by locating weapon
var distance_to_parent = 0
var local_angle_to_parent = 0

# used for the animation swapping
var animator = null

export var cur_weapon = "pistol"
export var weapon_dict = {}  # "name" : [fire-rate, damage, shells, spread]
# Called when the node enters the scene tree for the first time.
func _ready():
	animator = get_child(0)
	rng.randomize()
	var local_delta = self.position - owner.position
	print(self.position, owner.position)
	var local_dir = local_delta.normalized()
	self.local_angle_to_parent = atan2(local_dir.y, local_dir.x)
	self.distance_to_parent = local_delta.length()

func switch_weapon(weapon):
	"""The following function swaps weapons, locking the weapon from
	firing for as long its fire rate initially."""
	self.cur_weapon = weapon
	self.fired = true
	var weapon_array = self.weapon_dict[cur_weapon]
	self.fire_rate = weapon_array[0]
	self.damage = weapon_array[1]
	self.shells = weapon_array[2]
	self.spread = weapon_array[3]
	self.fire_limiter = fire_rate
	swap_anim(weapon)

func swap_anim(weapon):
	animator.play(weapon)
	#self.get_child(0).set_texture(load(sprite_path))

func fire():
	"""Fires the current weapon using data from weapon dictionary"""
	if self.fired:
		return
	else:
		var forward = get_global_transform().x.normalized()
		# For each shell, make a randomized offset from true forward
		for i in range(self.shells):
			var angle = rad2deg(atan2(forward.y, forward.x))
			var deviance = rng.randf_range(-self.spread, self.spread)
			# print("deviation:", deviance)
			var dev_angle = deg2rad(angle + deviance)
			var new_forward = Vector2(cos(dev_angle), sin(dev_angle))
			# print("Forward:", forward, "New Forward:", new_forward)
			var new_bullet = bullet.instance()
			new_bullet.forward_vec = new_forward
			
			# Get the angle of rotation relative to parent, and the parents
			# global rotation angle, combining the two to get our total rotation
			# then we proceed to get the weapon position by multipling
			# the new direction vector by the distance to weapon.
			var combined_angle = self.local_angle_to_parent + owner.rotation
			var weapon_dir = Vector2(cos(combined_angle), sin(combined_angle))
			var weapon_pos = (weapon_dir * self.distance_to_parent) + owner.position
			new_bullet.position = weapon_pos
			owner.owner.add_child(new_bullet)
		self.fired = true
		
	
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.fired:
		self.fire_limiter -= delta
		if self.fire_limiter <= 0:
			self.fire_limiter = self.fire_rate
			self.fired = false
	#self.position = owner.position
