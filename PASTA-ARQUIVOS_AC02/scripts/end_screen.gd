extends Control

func _ready():
	get_tree().paused = false

func _on_jogar_novamente_pressed():
	GameManager.vida = GameManager.vida_inicial
	GameManager.tem_chave = false
	GameManager.resetar_pontos()
	get_tree().change_scene_to_file("res://scenes/level.tscn")

func _on_menu_principal_pressed():
	GameManager.vida = GameManager.vida_inicial
	GameManager.tem_chave = false
	GameManager.resetar_pontos()
	get_tree().change_scene_to_file("res://scenes/menu_inicial.tscn")
