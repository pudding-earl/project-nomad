extends KinematicBody2D


const GRAVITY = 9.8

export var speed = 100.0
export var jump_force = 300.0

var velocity = Vector2()

onready var animation = get_node("Animation")
onready var sprite = get_node("Sprite")


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
	
	velocity.y += GRAVITY
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jump_force
	
	velocity = move_and_slide(velocity, Vector2.UP)
