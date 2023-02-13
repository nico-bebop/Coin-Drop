extends Node

const DOWN = "DOWN"
const LEFT = "LEFT"
const RIGHT = "RIGHT"

const FINAL_ROUND = 4

const NO_SCORE = " - "

const ROUNDS = ["Round One", "Round Two", "Round Three", "Final Round!"]

const GROUP_BOMBS = "Bombs"
const GROUP_COINS = "Coins"
const GROUP_PLAYERS = "Players"
const GROUP_SWITCHES = "Switches"
const GROUP_SLOTS = "Slots"

enum GameModes { SINGLE_PLAYER, VERSUS }
var game_mode
