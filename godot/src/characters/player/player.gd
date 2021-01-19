extends KinematicBody2D


const GRAVITY = 9.8

export var speed = 100.0
export var jump_force = 300.0

var velocity = Vector2()

onready var sprite = get_node("Sprite")
onready var animation = get_node("Animation")
onready var camera = get_node("Camera")


func _ready():
	animation.play("idle")


func _physics_process(_delta):
	
	# Movement
	velocity.x = 0.0
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
		if animation.current_animation == "idle":
			animation.play("walk")
		if !sprite.flip_h:
			sprite.flip_h = true
	elif Input.is_action_pressed("move_right"):
		velocity.x += speed
		if animation.current_animation == "idle":
			animation.play("walk")
		if sprite.flip_h:
			sprite.flip_h = false
	elif animation.current_animation == "walk":
		animation.play("idle")
	
	# Jumping/Air
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y -= jump_force
			animation.play("jump")
		elif animation.current_animation == "fall":
			animation.play("idle")
	else:
		if velocity.y > 30:
			animation.play("fall")

	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)
