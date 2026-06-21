# CÓDIGO RETIRADO DAS APOSTILAS DE INIMIGO E KILLZONE E REFORMULADO COM BASE NO ESTILO DO JOGO

extends CharacterBody2D

# CONSTANTES
const speed = 80.0
const gravity = 800.0

# VARIÁVEIS

var direction = 1

# VARIÁVEIS REFERENCIAIS
@onready var floor_left: RayCast2D = $FloorLeft 
#variável referenciando o raycast esquerdo quando o jogo for iniciado
@onready var floor_right: RayCast2D = $FloorRight 
#variável referenciando o raycast direito quando o jogo for iniciado
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
#variável referenciando o sprite que contém as animações do personagem

# FUNÇÕES

func _physics_process(delta):
	# Garantindo gravidade aplicada ao inimigo:
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Invertendo posição:
	if not floor_left.is_colliding():
		direction = 1
	if not floor_right.is_colliding():
		direction = -1
	
	# Aplicando velocidade no eixo x:
	velocity.x = direction * speed
	# Rotacionando eixo do personagem:
	anim.flip_h = direction > 0
	# Rodando animação spin_walk:
	anim.play("spin_walk")
	
	# Movendo o inimigo:
	move_and_slide()
