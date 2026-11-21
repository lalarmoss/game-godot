extends Node2D

func _process(delta: float) -> void:
	$CanvasLayer/vidas.text = "Vidas: " + str($player.vidas)
	
	$CanvasLayer/vidas.text = "Vidas: " + str($player.vidas)
	
	if $player.vidas <= 0:
		get_tree().change_scene_to_file("res://game_over.tscn")
