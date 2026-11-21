extends CharacterBody2D

@export var velocidade_patrulha: float = 60.0
@export var velocidade_perseguicao: float = 85.0

var direcao: Vector2 = Vector2.ZERO
var alvo_player: Node2D = null
var tempo_preso: float = 0.0

var pontos_teleporte = [
	Vector2(100, 100),
	Vector2(450, 80),
	Vector2(250, 200),
	Vector2(450, 300),
	Vector2(100, 300)
]

func _ready() -> void:
	escolher_nova_direcao()

func _physics_process(delta: float) -> void:
	if alvo_player != null:
		direcao = (alvo_player.global_position - global_position).normalized()
		velocity = direcao * velocidade_perseguicao
	else:
		velocity = direcao * velocidade_patrulha

	move_and_slide()

	if alvo_player == null:
		if get_real_velocity().length() < 5.0:
			tempo_preso += delta
			if tempo_preso >= 0.25:
				tempo_preso = 0.0
				escolher_nova_direcao()
		else:
			tempo_preso = 0.0

func escolher_nova_direcao() -> void:
	var direcoes_possiveis = [
		Vector2.UP,
		Vector2.DOWN,
		Vector2.LEFT,
		Vector2.RIGHT
	]
	direcoes_possiveis.erase(direcao)
	direcao = direcoes_possiveis.pick_random()

func _on_timer_patrulha_timeout() -> void:
	if alvo_player == null:
		escolher_nova_direcao()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		alvo_player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == alvo_player:
		alvo_player = null
		escolher_nova_direcao()

func _on_area_dano_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.vidas -= 1
		$risada.play()
		global_position = pontos_teleporte.pick_random()
		alvo_player = null
		escolher_nova_direcao()
		
		
		
		
