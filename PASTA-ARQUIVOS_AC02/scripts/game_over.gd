extends Control

# Tela de Game Over: exibida quando a vida do GameManager chega a 0.

func _ready() -> void:
	# Garante que o jogo não fique pausado ao cair nessa tela
	# (ex.: se o player morreu enquanto o pause estava ativo).
	get_tree().paused = false

# Função chamada pelo sinal "pressed" do botão TentarNovamenteButton
func _on_tentar_novamente_button_pressed() -> void:
	# Reseta a vida antes de recarregar o nível
	GameManager.vida = GameManager.vida_inicial
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_menu_principal_button_pressed() -> void:
	GameManager.vida = GameManager.vida_inicial # reseta a vida
	get_tree().change_scene_to_file("res://scenes/menu_inicial.tscn")
