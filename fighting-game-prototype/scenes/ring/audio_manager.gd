extends Node

@onready var punch_0: AudioStreamPlayer = %Punch0
@onready var punch_1: AudioStreamPlayer = %Punch1
@onready var punch_2: AudioStreamPlayer = %Punch2
@onready var hurt_0: AudioStreamPlayer = %Hurt0
@onready var hurt_1: AudioStreamPlayer = %Hurt1
@onready var hurt_2: AudioStreamPlayer = %Hurt2
@onready var hurt_3: AudioStreamPlayer = %Hurt3
@onready var kick_0: AudioStreamPlayer = %Kick0
@onready var dying_female: AudioStreamPlayer = %DyingFemale
@onready var character_0: BaseCharacter = %Character0
@onready var character_1: BaseCharacter = %Character1

var sound_has_played = false
var last_attack_index = -1
var last_action = ""
var last_damage_action = ""  # Controle adicional para sons de dano
var hurt_cooldown = 0.2  # Cooldown para sons de dano
var hurt_timer = 0.0  # Temporizador para controle de dano

func _process(delta: float) -> void:
	# Atualiza cooldown do som de dano
	if hurt_timer > 0.0:
		hurt_timer -= delta
	
	_emit_SFX()


func _emit_SFX() -> void:
	var action = ""
	var damage_action = ""

	# Verifica se o Character 0 está socando
	if character_0.is_punching:
		var current_index = character_0.punch_state.attack_index
		if current_index != last_attack_index:
			action = "punch_%d" % current_index
			last_attack_index = current_index

		# Verifica se o soco acertou o Character 1
		if character_1.is_hit and hurt_timer <= 0.0:
			damage_action = "hurt_%d" % current_index
			hurt_timer = hurt_cooldown  # Reinicia cooldown de dano

	# Reseta índice se não está socando
	else:
		last_attack_index = -1

	# Verifica se o Character 0 está chutando
	if character_0.is_kicking:
		action = "kick_0"

		# Verifica se o chute acertou o Character 1
		if character_1.is_hit and hurt_timer <= 0.0:
			damage_action = "hurt_kick"
			hurt_timer = hurt_cooldown  # Reinicia cooldown de dano

	# Verifica se qualquer personagem está morrendo
	if character_0.is_dead or character_1.is_dead:
		action = "dying_female"

	# Reproduz som correspondente ao ataque (soco, chute, etc.)
	if action != last_action:
		match action:
			"punch_0":
				punch_0.play()
			"punch_1":
				punch_1.play()
			"punch_2":
				punch_2.play()
			"kick_0":
				kick_0.play()
			"dying_female":
				dying_female.play()
		
		last_action = action  # Atualiza última ação

	# Reproduz som correspondente ao dano no oponente
	if damage_action != "" and damage_action != last_damage_action:
		match damage_action:
			"hurt_0":
				hurt_0.play()
			"hurt_1":
				hurt_1.play()
			"hurt_2":
				hurt_2.play()
			"hurt_3":
				hurt_3.play()
			"hurt_kick":
				hurt_3.play()  # Som fixo para chute
		
		last_damage_action = damage_action  # Atualiza último som de dano
