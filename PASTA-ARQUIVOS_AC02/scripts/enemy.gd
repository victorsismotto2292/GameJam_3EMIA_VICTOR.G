# CÓDIGO RETIRADO DAS APOSTILAS DE INIMIGO E KILLZONE E REFORMULADO COM BASE NO ESTILO DO JOGO

extends CharacterBody2D

# CONSTANTES
const speed = 80.0
const gravity = 1200.0

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
		velocity.y = 0
		
	# Lógica de movimentação e detecção de bordas/paredes:
	if is_on_floor():
		var should_turn = false
		
		# Verifica borda à frente
		if direction == 1 and not floor_right.is_colliding():
			should_turn = true
		elif direction == -1 and not floor_left.is_colliding():
			should_turn = true
			
		# Verifica parede à frente
		if is_on_wall():
			should_turn = true
			
		if should_turn:
			direction *= -1
	
	# Aplica velocidade
	velocity.x = direction * speed
	
	# Visual e animação
	anim.flip_h = direction > 0
	anim.play("spin_walk")
	
	# Move_and_slide lida com a física e colisões
	move_and_slide()
	
	# ESCAPE DE SEGURANÇA: Se estiver travado no chão com velocidade zero, sobe um pouco
	if is_on_floor() and abs(velocity.x) < 1.0:
		position.y -= 1.0
