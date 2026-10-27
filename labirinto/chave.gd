extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$Label.visible = true
		$Sprite2D.visible = false
		$CollisionShape2D.visible = false
		body.chave += 1
