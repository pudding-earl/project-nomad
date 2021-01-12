extends KinematicBody2D


const GRAVITY = 9.8

export var speed = 30.0

var velocity = Vector2()

onready var animation = get_node("Animation")


func _ready():
	animation.play("idle")


func _physics_process(_delta):
	
	# Movement
	velocity.x = 0.0
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
		if animation.current_animation == "idle":
			animation.play("walk")
	elif Input.is_action_pressed("move_right"):
		velocity.x += speed
		if animation.current_animation == "idle":
			animation.play("walk")
	elif animation.current_animation == "walk":
		animation.play("idle")
	
	velocity.y -= GRAVITY
	
	move_and_slide(velocity, Vector2.UP)
