extends Node

var gameData = {
	"board": {},
	"players": {},
	"round": 0,
	"whoseTurn": player_slot.player1
}

enum player_slot {
	player1 = 0,
	player2 = 1,
	player3 = 2,
	player4 = 3
}

enum tile_type {
	blank,
	home,
	clue,
	haunt,
	dash
}

enum IO {
	none = -1,
	i = 0,
	o = 1
}

# Called when the node enters the scene tree for the first time.
func _ready():
	_load_map()
	_load_players()

func _load_map():
	#TODO replace with actual load when actual map select is in
	_temp_function_load_graveyard()

func _load_players():
	pass


func handle_next_turn():
	if gameData.whoseTurn == player_slot.player1:
		handle_round_start()
	
	



func handle_round_start():
	gameData.round += 1
	game_session

func handle_round_end():
	pass

func handle_turn_start():
	
	
func handle_turn_end():
	if gameData.whoseTurn == player_slot.player4:
		gameData.whoseTurn == 
	gameData.whoseTurn += 1
	if gameData.whoseTurn 

func _temp_function_load_graveyard():
	var graveyard_board = {
		Vector2i(7,0): {"tyle_type": tile_type.home,  "n":IO.o,    "w":IO.i,    "e":IO.none, "s":IO.none},
		Vector2i(7,1): {"tyle_type": tile_type.dash,  "n":IO.o,    "w":IO.none, "e":IO.none, "s":IO.i   },
		Vector2i(7,2): {"tyle_type": tile_type.clue,  "n":IO.o,    "w":IO.none, "e":IO.none, "s":IO.i   },
		Vector2i(7,3): {"tyle_type": tile_type.blank, "n":IO.o,    "w":IO.none, "e":IO.none, "s":IO.i   },
		Vector2i(7,4): {"tyle_type": tile_type.haunt, "n":IO.o,    "w":IO.none, "e":IO.none, "s":IO.i   },
		Vector2i(7,5): {"tyle_type": tile_type.blank, "n":IO.o,    "w":IO.none, "e":IO.none, "s":IO.i   },
		Vector2i(7,6): {"tyle_type": tile_type.dash,  "n":IO.none, "w":IO.o,    "e":IO.none, "s":IO.i   },
		Vector2i(6,6): {"tyle_type": tile_type.blank, "n":IO.none, "w":IO.o,    "e":IO.i,    "s":IO.none},
		Vector2i(5,6): {"tyle_type": tile_type.dash,  "n":IO.none, "w":IO.o,    "e":IO.i,    "s":IO.o   },
		
		Vector2i(4,6): {"tyle_type": tile_type.blank, "n":IO.none, "w":IO.o,    "e":IO.i,    "s":IO.none},
		Vector2i(3,6): {"tyle_type": tile_type.blank, "n":IO.none, "w":IO.none, "e":IO.i,    "s":IO.o   },
		Vector2i(3,5): {"tyle_type": tile_type.clue,  "n":IO.i,    "w":IO.none, "e":IO.none, "s":IO.o   },
		Vector2i(3,4): {"tyle_type": tile_type.blank, "n":IO.i,    "w":IO.o,    "e":IO.none, "s":IO.none},
		Vector2i(2,4): {"tyle_type": tile_type.blank, "n":IO.none, "w":IO.o,    "e":IO.i,    "s":IO.none},
		Vector2i(1,4): {"tyle_type": tile_type.clue,  "n":IO.none, "w":IO.o,    "e":IO.i,    "s":IO.none},
		Vector2i(0,4): {"tyle_type": tile_type.blank, "n":IO.none, "w":IO.none, "e":IO.i,    "s":IO.o   },
		Vector2i(0,3): {"tyle_type": tile_type.blank, "n":IO.i,    "w":IO.none, "e":IO.none, "s":IO.o   },
		
		Vector2i(5,5): {"tyle_type": tile_type.haunt, "n":IO.i,    "w":IO.none, "e":IO.none, "s":IO.o   },
		Vector2i(5,4): {"tyle_type": tile_type.clue,  "n":IO.i,    "w":IO.none, "e":IO.none, "s":IO.o   },
		Vector2i(5,3): {"tyle_type": tile_type.haunt, "n":IO.i,    "w":IO.none, "e":IO.none, "s":IO.o   },
		Vector2i(5,2): {"tyle_type": tile_type.dash,  "n":IO.i,    "w":IO.o,    "e":IO.none, "s":IO.none},
		Vector2i(4,2): {"tyle_type": tile_type.haunt, "n":IO.none, "w":IO.o,    "e":IO.i,    "s":IO.none},
		Vector2i(3,2): {"tyle_type": tile_type.clue,  "n":IO.none, "w":IO.o,    "e":IO.i,    "s":IO.none},
		Vector2i(2,2): {"tyle_type": tile_type.haunt, "n":IO.none, "w":IO.o,    "e":IO.i,    "s":IO.none},
		Vector2i(1,2): {"tyle_type": tile_type.clue,  "n":IO.none, "w":IO.o,    "e":IO.i,    "s":IO.none},
		
		Vector2i(0,2): {"tyle_type": tile_type.dash,  "n":IO.i,    "w":IO.none, "e":IO.i,    "s":IO.o   },
		Vector2i(0,1): {"tyle_type": tile_type.blank, "n":IO.i,    "w":IO.none, "e":IO.none, "s":IO.o   },
		Vector2i(0,0): {"tyle_type": tile_type.dash,  "n":IO.i,    "w":IO.none, "e":IO.o,    "s":IO.none},
		Vector2i(1,0): {"tyle_type": tile_type.blank, "n":IO.none, "w":IO.i,    "e":IO.o,    "s":IO.none},
		Vector2i(2,0): {"tyle_type": tile_type.clue,  "n":IO.none, "w":IO.i,    "e":IO.o,    "s":IO.none},
		Vector2i(3,0): {"tyle_type": tile_type.blank, "n":IO.none, "w":IO.i,    "e":IO.o,    "s":IO.none},
		Vector2i(4,0): {"tyle_type": tile_type.haunt, "n":IO.none, "w":IO.i,    "e":IO.o,    "s":IO.none},
		Vector2i(5,0): {"tyle_type": tile_type.haunt, "n":IO.none, "w":IO.i,    "e":IO.o,    "s":IO.none},
		Vector2i(6,0): {"tyle_type": tile_type.haunt, "n":IO.none, "w":IO.i,    "e":IO.o,    "s":IO.none},
	}
	gameData.board = graveyard_board

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
