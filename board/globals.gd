extends Node

const DOWN = "DOWN"
const LEFT = "LEFT"
const RIGHT = "RIGHT"

const FINAL_ROUND = 4

const ROUNDS = ["ROUND ONE", "ROUND TWO", "ROUND THREE", "FINAL ROUND"]

const GROUP_SWITCHES = "Switches"
const GROUP_SLOTS = "Slots"
const GROUP_COINS = "Coins"
const GROUP_PLAYERS = "Players"

enum GameModes { SINGLE_PLAYER, VERSUS }
var game_mode
