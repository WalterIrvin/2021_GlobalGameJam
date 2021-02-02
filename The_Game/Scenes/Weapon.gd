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
export var cur_weapon = "pistol"
export var weapon_dict = {}  # "name" : [fire-rate, damage, shells, spread]
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()

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

func fire():
	"""Fires the current weapon using data from weapon dictionary"""
	if self.fired:
		return
	else:
		var forward = get_global_transform().x.normalized()
		var angle = rad2deg(atan2(forward.y, forward.x))
		var deviance = rng.randf_range(-self.spread, self.spread)
		# print("deviation:", deviance)
		var dev_angle = deg2rad(angle + deviance)
		var new_forward = Vector2(cos(dev_angle), sin(dev_angle))
		# print("Forward:", forward, "New Forward:", new_forward)
		var new_bullet = bullet.instance()
		new_bullet.forward_vec = new_forward
		new_bullet.position = self.position
		owner.owner.add_child(new_bullet)
		self.fired = true
		
	
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.fired:
		self.fire_limiter -= delta
		if self.fire_limiter <= 0:
			self.fire_limiter = self.fire_rate
			self.fired = false
	self.position = owner.position
