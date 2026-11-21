extends CharacterBody2D

var velocidade = 150.0
var direcao_atual = Vector2.RIGHT
var player = null

func _ready():
	$Area2D.body_entered.connect(_on_encostou)
	player = get_tree().root.find_child("player", true, false)
	escolher_nova_direcao()

func _physics_process(delta):
	if player and global_position.distance_to(player.global_position) < 180:
		direcao_atual = global_position.direction_to(player.global_position)
	
	velocity = direcao_atual * velocidade
	move_and_slide()
	
	if get_slide_collision_count() > 0:
		escolher_nova_direcao()

func escolher_nova_direcao():
	var opcoes = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
	opcoes.erase(direcao_atual)
	direcao_atual = opcoes.pick_random()

func _on_encostou(body):
	if body.has_method("levar_dano"):
		body.levar_dano()
		teletransportar(body.global_position)

func teletransportar(pos_player):
	var pontos_seguros = [
		Vector2(50, 50),
		Vector2(500, 50),
		Vector2(50, 350),
		Vector2(500, 350),
		Vector2(280, 200)
	]
	
	pontos_seguros.shuffle()
	for ponto in pontos_seguros:
		if ponto.distance_to(pos_player) > 150:
			global_position = ponto
			break
			
	escolher_nova_direcao()
