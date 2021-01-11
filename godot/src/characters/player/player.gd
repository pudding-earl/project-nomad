extends KinematicBody2D


export var speed = 3000000.0

var velocity = Vector2()

onready var animation = get_node("Animation")


func _ready():
	animation.play("idle")


func _physics_process(_delta):
	
	# Movement
	velocity.x = 0
	
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
	
	velocity = move_and_slide(velocity, Vector2.UP)
