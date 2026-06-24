extends Control

# função que executa ao receber o sinal de botão clicado, tirado
# das apostilas de HUD e Menus
func _on_jogar_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")
