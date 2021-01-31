extends KinematicBody2D

export (PackedScene) var Bullet = load("res://Objects/Bullet.tscn")
export var speed = 150
export var shoot_delay = 0.5
var shoot_timer = shoot_delay
export var health = 6
export var damage_delay = 1.5
var damage_timer = damage_delay
var velocity = Vector2()
onready var anim = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	damage_timer = 0
	shoot_timer = 0

func shoot():
	anim.play("Shooting")
	var b = Bullet.instance()
	get_parent().add_child(b)
	b.transform = $BulletSpawner.global_transform

func get_input():
	look_at(get_global_mouse_position())
	velocity = Vector2(0, 0)
	if Input.is_action_pressed("move_up"):
		velocity.y -= speed
	if Input.is_action_pressed("move_down"):
		velocity.y += speed
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
	if Input.is_action_pressed("fire"):
		if shoot_timer <= 0:
			shoot()
			shoot_timer = shoot_delay
			
func set_animation():
	print(velocity)
	if abs(velocity.x) > 0 or abs(velocity.y) > 0:
		anim.animation = "Moving"
	else:
		anim.animation = "Idle"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	set_animation()
	velocity = move_and_slide(velocity, Vector2.UP)
	print(anim.animation)
		
func _process(delta):
	shoot_timer -= delta
	damage_timer -= delta
	if health <= 0:
		get_tree().change_scene("res://Root.tscn")

func _on_PickupRadius_area_entered(area):
	if area.is_in_group("pickups"):
		area.get_target(self)
		print(area.position.distance_to(position))
