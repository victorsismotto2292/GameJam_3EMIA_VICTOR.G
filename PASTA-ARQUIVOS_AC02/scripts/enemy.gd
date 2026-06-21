# CÓDIGO RETIRADO DAS APOSTILAS DE INIMIGO E KILLZONE E REFORMULADO COM BASE NO ESTILO DO JOGO

extends CharacterBody2D

# CONSTANTES
const speed = 80.0
const gravity = 980.0 # Gravidade padrão mais forte para evitar flutuação

# VARIÁVEIS
var direction = 1

# VARIÁVEIS REFERENCIAIS
@onready var floor_left: RayCast2D = $FloorLeft 
@onready var floor_right: RayCast2D = $FloorRight 
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

# FUNÇÕES

func _physics_process(delta):
	# Aplicando gravidade:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 10.0 # Pequena força para baixo constante para manter contato com o chão
		
	# Invertendo direção ao detectar fim da plataforma (somente se estiver no chão):
	if is_on_floor():
		if direction == 1 and not floor_right.is_colliding():
			direction = -1
		elif direction == -1 and not floor_left.is_colliding():
			direction = 1
	
	# Aplicando velocidade no eixo x:
	velocity.x = direction * speed
	
	# Rotacionando eixo do personagem:
	anim.flip_h = direction > 0
	# Rodando animação spin_walk:
	anim.play("spin_walk")
	
	# Movendo o inimigo:
	move_and_slide()
