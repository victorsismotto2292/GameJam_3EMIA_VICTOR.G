# CÓDIGO RETIRADO DAS APOSTILAS DE INIMIGO E KILLZONE E REFORMULADO COM BASE NO ESTILO DO JOGO

extends CharacterBody2D

# CONSTANTES
const speed = 80.0
const gravity = 1000.0

# VARIÁVEIS
var direction = 1

# VARIÁVEIS REFERENCIAIS
@onready var floor_left: RayCast2D = $FloorLeft 
@onready var floor_right: RayCast2D = $FloorRight 
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

# FUNÇÕES

func _physics_process(delta):
	# Gravidade simples
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
		
	# Detecção de virada (borda ou parede)
	if is_on_floor():
		if direction == 1 and (not floor_right.is_colliding() or is_on_wall()):
			direction = -1
		elif direction == -1 and (not floor_left.is_colliding() or is_on_wall()):
			direction = 1
	
	# Movimento horizontal
	velocity.x = direction * speed
	
	# Visual
	anim.flip_h = direction > 0
	anim.play("spin_walk")
	
	# Movimentação física
	move_and_slide()
