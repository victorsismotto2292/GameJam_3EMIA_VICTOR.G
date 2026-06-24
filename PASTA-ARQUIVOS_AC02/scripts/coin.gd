# CÓDIGO INICIAL ATUALIZADO COM AS PARTÍCULAS E HUD:

extends Area2D

signal collected

# Chamando as variáveis dos nós
@onready var particles: GPUParticles2D = $Particles
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

# função do parâmetro body_entered:
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# Adiciona ponto através do GameManager (Autoload)
		GameManager.adicionar_ponto()
		
		collected.emit()
		sprite_2d.visible = false
		collision_shape_2d.set_deferred("disabled", true)
		particles.emitting = true
		await particles.finished
		queue_free()
