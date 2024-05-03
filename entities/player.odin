package entities

myVector2D::struct {x, y: i32}

Player :: struct {
	position: myVector2D,
	size: myVector2D,
	speed: i32,
	lives: i32,
}

playerWidth: i32 = 50
playerHeight: i32 = 20
playerSpeed: i32 = 10
playerLives: i32 = 3

InitPlayer :: proc (screenWidth: i32, screenHeight: i32) -> ^Player {
	player := new(Player)
	player.position = myVector2D{screenWidth/2, screenHeight * 8 / 9}
	player.size 	 = myVector2D{playerWidth, playerHeight}
	player.speed 	 = playerSpeed
	player.lives 	 = playerLives
	return player
}

    