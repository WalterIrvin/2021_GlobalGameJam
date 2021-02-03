extends KinematicBody2D

export var weapon_type = "pistol"


var health = 100
var dead = false
var cur_target = null
var retarget_timer = 2.75  # how long to check for new closest target
var weapon = null
# Called when the node enters the scene tree for the first time.
func _ready():
	self.weapon = get_child(2)
	self.weapon.switch_weapon(self.weapon_type)

func damage(damage_amt):
	self.health -= damage_amt
	if self.health <= 0:
		self.dead = true

func find_closest_player():
	var group = get_tree().get_nodes_in_group("Players")
	var closest_dist = INF
	var closest_player = null
	for player in group:
		var cur_dist = (player.position - self.position).length()
		if cur_dist < closest_dist:
			closest_player = player
	self.cur_target = closest_player
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.dead:
		queue_free()
		
	self.retarget_timer -= delta
	if self.retarget_timer <= 0:
		self.retarget_timer = 0.75
		find_closest_player()
	
	if self.cur_target != null:
		look_at(self.cur_target.global_position)
		self.weapon.fire()
