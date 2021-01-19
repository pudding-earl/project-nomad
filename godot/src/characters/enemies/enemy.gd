extends KinematicBody2D


const GRAVITY = 9.8

export var speed = 100.0
export var jump_force = 300.0
export var wake_time = 0.0

var awake = false # Whether the enemy is idle or targetting the player

var velocity = Vector2()
var target

onready var sprite = get_node("Sprite")
onready var animation = get_node("Animation")


func _ready():
	animation.play("idle")


func _physics_process(_delta):
	velocity.x = 0
	if awake:
		pursue()
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)


func pursue():
	if target.position.x > position.x:
		sprite.flip_h = false
		velocity.x += speed
	else:
		sprite.flip_h = true
		velocity.x -= speed
	if animation.current_animation != "walk":
		animation.play("walk")


func wake(body):
	if awake:
		return
	if wake_time > 0.0:
		animation.play("wake")
	target = body
	awake = true
