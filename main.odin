package game

import "core:fmt"
import "vendor:raylib"
import "entities"


Bullet :: struct {
	x: i32,
	y: i32,
	isVisible: bool,
}


createBullet::proc() -> ^Bullet {
	bullet := new(Bullet)
	return bullet
}

main :: proc() {
	using raylib

	InitWindow(1280, 960, "Shavaders v.0.01dev")

	screenWidth: i32 = GetScreenWidth()
	screenHeight: i32 = GetScreenHeight()
	player: ^entities.Player =  entities.InitPlayer(screenWidth, screenHeight)

	isShot: bool = false

	DisableCursor()
	
	SetTargetFPS(60)

	currentBullet: ^Bullet = nil
	
	for !WindowShouldClose() {
		BeginDrawing()
		ClearBackground(WHITE)
		
		DrawRectangle(player.position.x, player.position.y, player.size.x, player.size.y, RED)
		
		if IsKeyDown(.LEFT) || IsKeyDown(.A) {
			player.position.x -= player.speed
			} 
			if IsKeyDown(.RIGHT) || IsKeyDown(.D) {
				player.position.x += player.speed
			}
		
		
		if IsKeyPressed(.SPACE) {
			if !isShot {
				isShot = true
				currentBullet = createBullet()
				currentBullet.x = player.position.x + player.size.x /2
				currentBullet.y = player.position.y - player.size.y / 2
				DrawRectangle(currentBullet.x, currentBullet.y, 5, 10, GREEN)
				fmt.printf("Shooting Bullet %d", currentBullet.y)
			}
		}

		if isShot && currentBullet != nil {
			currentBullet.y -= 10
			if currentBullet.y <= 0 {
				free(currentBullet)
				isShot = false
			} else {
				DrawRectangle(currentBullet.x, currentBullet.y, 5, 10, GREEN)
			}
		}

		if player.position.x < player.size.x {
			player.position.x = player.size.x
		}

		if player.position.x >= screenWidth - player.size.x * 2 {
			player.position.x = screenWidth - player.size.x * 2
		}

		EndDrawing()
	}
	defer free(player)
	defer CloseWindow()
}