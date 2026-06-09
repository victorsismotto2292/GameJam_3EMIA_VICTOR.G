extends CharacterBody2D

signal died

@export var walk_speed: float = 230.0
@export var run_speed: float = 360.0
@export var jump_velocity: float = -520.0
@export var double_jump_velocity: float = -360.0
@export var acceleration: float = 1600.0
@export var friction: float = 1900.0
@export var fall_limit: float = 920.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumps_left: int = 2
var start_position: Vector2
var is_dead: bool = false

func _ready() -> void:
	start_position = global_position
	add_to_group("player")
	animated_sprite.play("idle")

func _physics_process(delta: float) -> void:
	if is_dead:
		return

	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		jumps_left = 2

	_handle_jump()
	_handle_horizontal_movement(delta)
	_update_animation()
	move_and_slide()

	if global_position.y > fall_limit:
		die()

func _handle_jump() -> void:
	if Input.is_action_just_pressed("jump") and jumps_left > 0:
		if is_on_floor():
			velocity.y = jump_velocity
		else:
			velocity.y = double_jump_velocity
		jumps_left -= 1

func _handle_horizontal_movement(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	var target_speed := run_speed if Input.is_action_pressed("run") else walk_speed

	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * target_speed, acceleration * delta)
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

func _update_animation() -> void:
	if not is_on_floor():
		animated_sprite.play("jump")
	elif abs(velocity.x) < 15.0:
		animated_sprite.play("idle")
	elif Input.is_action_pressed("run"):
		animated_sprite.play("run")
	else:
		animated_sprite.play("walk")

func die() -> void:
	if is_dead:
		return
	is_dead = true
	died.emit()

func reset_to_start(new_start: Vector2 = start_position) -> void:
	global_position = new_start
	velocity = Vector2.ZERO
	jumps_left = 2
	is_dead = false
	animated_sprite.play("idle")
