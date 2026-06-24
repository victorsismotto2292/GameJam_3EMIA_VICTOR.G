extends CanvasLayer

# menu escondido
func _ready() -> void:
	hide()

# função para abrir ou fechar o menu
func _input(event) -> void:
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			hide()
			get_tree().paused = false
		else:
			show()
			get_tree().paused = true

# função do botão continuar
func _on_continuar_button_pressed() -> void:
	hide()
	get_tree().paused = false

# função para abrir o menu inicial
func _on_menu_principal_button_pressed() -> void:
	get_tree().paused = false
	GameManager.vida = GameManager.vida_inicial # Reseta vida ao voltar ao menu
	GameManager.resetar_pontos() # Reseta pontos ao voltar ao menu
	get_tree().change_scene_to_file("res://scenes/menu_inicial.tscn")
