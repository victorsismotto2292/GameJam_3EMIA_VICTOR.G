extends CharacterBody2D

# Configurações de Movimento
const SPEED = 300
const RUN_SPEED = 375
const JUMP_VELOCITY = -400.0
const DOUBLE_JUMP_VELOCITY = -450.0 # Para pulo-duplo
const MAX_JUMPS = 2 # Para pulo-duplo

var current_jumps = 0
var is_dead = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if is_dead:
		return
		
	# Aplicar Gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		current_jumps = 0 # Reseta os pulos ao tocar o chão

	# Lógica de Pulo e Pulo Duplo
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			current_jumps = 1
		elif current_jumps < MAX_JUMPS:
			velocity.y = DOUBLE_JUMP_VELOCITY
			current_jumps += 1

	# Direção e Velocidade (Caminhada vs Corrida)
	var input_direction = Input.get_axis("left", "right")
	var target_speed = SPEED

	if Input.is_action_pressed("run") and is_on_floor():
		target_speed = RUN_SPEED

	if input_direction:
		velocity.x = input_direction * target_speed
	else:
		velocity.x = move_toward(velocity.x, 0, target_speed)

	# Atualizar Animações e Direção do Sprite
	update_animations(input_direction, target_speed)
	
	if input_direction > 0:
		animated_sprite_2d.flip_h = false
	elif input_direction < 0:
		animated_sprite_2d.flip_h = true
		
	move_and_slide()

func update_animations(direction: float, current_speed: float) -> void:
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		elif current_speed == RUN_SPEED:
			animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("jump")
