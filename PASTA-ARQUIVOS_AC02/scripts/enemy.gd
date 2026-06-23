extends CharacterBody2D

const SPEED = 360.0
const GRAVITY = 800.0

var direction = 1
var gravity_real: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var floor_left: RayCast2D = $FloorLeft
@onready var floor_right: RayCast2D = $FloorRight
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	add_to_group("enemy")

func _physics_process(delta: float) -> void:
	# Aplicar gravidade
	if not is_on_floor():
		velocity.y += gravity_real * delta
	else:
		velocity.y = 0

	# Inverter direção ao detectar ausência de chão à frente (borda de plataforma)
	# floor_left está em (-30, 0) → detecta chão à esquerda
	# floor_right está em (30, 0) → detecta chão à direita
	if direction < 0: # Indo para a esquerda, checa chão à esquerda
		if not floor_left.is_colliding():
			direction = 1
	elif direction > 0: # Indo para a direita, checa chão à direita
		if not floor_right.is_colliding():
			direction = -1

	# Aplicando velocidade no eixo x
	velocity.x = direction * SPEED
	anim.flip_h = direction < 0
	anim.play("walk")

	move_and_slide()

	# Após mover, checa se bateu em PAREDE (não chão) — usa tolerância
	# Colisão de chão tem normal.y ~ -1; colisão de parede tem normal.x ~ ±1
	# Usar abs(normal.x) > 0.5 para garantir que é parede, não chão inclinado
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var collider := collision.get_collider()
		if collider == null:
			continue
		if collider.is_in_group("player") and collider.has_method("die"):
			collider.die()
		elif abs(collision.get_normal().x) > 0.5:
			direction = -direction
			anim.flip_h = direction < 0
