extends Node2D

# Game state management
enum GameState {PLAYING, PAUSED, GAME_OVER}
var game_state = GameState.PLAYING
var map_size = Vector2(800, 600)  # Example game map size

# Initialize the world and spawn players.
func _ready():
	initialize_world()
	spawn_players()

# Set up the game world environment.
func initialize_world():
	# Setup environment like camera, lighting, etc.
	pass

# Spawn player characters based on the selection from the Global script.
func spawn_players():
	var num_players = Global.players_info.size()
	var positions = get_positions(num_players)
	for i in range(num_players):
		var player_info = Global.players_info[i]
		var character_index = player_info["character"]
		var character_scene = get_character_scene_by_index(character_index)
		var character_instance = character_scene.instantiate()
		add_child(character_instance)
		# Set the position from the calculated positions
		character_instance.position = positions[i]

# Calculate player positions dynamically based on the number of players.
func get_positions(num_players: int) -> Array:
	var positions = []
	var center = map_size / 2
	var radius = min(map_size.x, map_size.y) / 5  # Ensure a smaller radius to keep characters within bounds

	if num_players == 2:
		# Place two players horizontally centered relative to the game map center.
		positions.append(center + Vector2(-radius / 2, 0))
		positions.append(center + Vector2(radius / 2, 0))
	elif num_players == 3:
		# Place three players in an isosceles triangle formation.
		positions.append(center + Vector2(0, -radius / 2))  # Front character
		positions.append(center + Vector2(-radius / 2, radius / 4))  # Left rear character
		positions.append(center + Vector2(radius / 2, radius / 4))  # Right rear character
	elif num_players == 4:
		# Place four players in a smaller square formation.
		positions.append(center + Vector2(-radius / 2, -radius / 2))
		positions.append(center + Vector2(radius / 2, -radius / 2))
		positions.append(center + Vector2(-radius / 2, radius / 2))
		positions.append(center + Vector2(radius / 2, radius / 2))

	return positions

# Helper function to get the character scene based on index.
func get_character_scene_by_index(index: int) -> PackedScene:
	if index == 0:
		return Global.ARTIST_SCENE
	elif index == 1:
		return Global.ASTROLOGER_SCENE
	elif index == 2:
		return Global.CITIZEN_SCENE
	return null

# Game state controls (for example, pausing and resuming the game).
func pause_game():
	game_state = GameState.PAUSED

func resume_game():
	game_state = GameState.PLAYING

func end_game():
	game_state = GameState.GAME_OVER
	# Transition to a game over screen or similar

# Handle game logic in the physics update step.
func _physics_process(delta):
	if game_state == GameState.PLAYING:
		# Update gameplay logic such as movement and interactions
		pass

