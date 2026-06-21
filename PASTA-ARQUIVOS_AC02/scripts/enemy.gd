# CÓDIGO RETIRADO DAS APOSTILAS DE INIMIGO E KILLZONE E REFORMULADO COM BASE NO ESTILO DO JOGO

extends CharacterBody2D

# CONSTANTES
const speed = 60.0 # Velocidade levemente reduzida para patrulha mais estável
const gravity = 980.0

# VARIÁVEIS
var direction = -1 # Começa indo para a esquerda (padrão comum)

# VARIÁVEIS REFERENCIAIS
@onready var floor_left: RayCast2D = $FloorLeft 
@onready var floor_right: RayCast2D = $FloorRight 
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

# FUNÇÕES

func _physics_process(delta):
	# Aplicando gravidade
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
		
	# Lógica de patrulha: vira ao chegar na borda ou bater na parede
	# Importante: verificamos a colisão do RayCast oposto à direção para saber se deve virar
	if is_on_floor():
		if direction == 1:
			if not floor_right.is_colliding() or is_on_wall():
				direction = -1
		else:
			if not floor_left.is_colliding() or is_on_wall():
				direction = 1
	
	# Aplica velocidade horizontal
	velocity.x = direction * speed
	
	# Visual e animação
	# Ajuste do flip: Kenney spinner geralmente olha para frente
	anim.flip_h = direction > 0
	anim.play("spin_walk")
	
	# Movimentação física
	move_and_slide()
