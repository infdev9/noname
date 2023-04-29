extends Node

const TILE_SIZE: int = 64
const TILE_SIZE_SQUARED: int = TILE_SIZE ** 2
const PLAYER_SPEED: int = 400
const CAMERA_ANGLE: int = 45

const SCENES: Dictionary = {
	"MENU": "res://scenes/menu.tscn",
	"LOBBY": "res://scenes/lobby.tscn",
	"GAME": "res://scenes/game.tscn",
}

const ACTIONS: Dictionary = {
	"UP": "up",
	"DOWN": "down",
	"LEFT": "left",
	"RIGHT": "right",
}

const CAMERA_ANGLES: Dictionary = {
	"UP_LEFT": -(180 - CAMERA_ANGLE),
	"UP_RIGHT": -(90 - CAMERA_ANGLE),
	"DOWN_RIGHT": 90 - CAMERA_ANGLE,
	"DOWN_LEFT": 180 - CAMERA_ANGLE,
}
