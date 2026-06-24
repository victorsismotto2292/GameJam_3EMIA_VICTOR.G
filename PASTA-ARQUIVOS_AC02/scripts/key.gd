extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		GameManager.tem_chave = true
		var hud = get_tree().current_scene.find_child("Hud", true, false)
		if hud and hud.has_method("atualizar_chave"):
			hud.atualizar_chave()
		queue_free()
