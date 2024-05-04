package game

import "core:fmt"
import "vendor:raylib"
import "entities"


Bullet :: struct {
	x: i32,
	y: i32,
	isVisible: bool,
}


createBullet::proc(player: ^entities.Player) -> ^Bullet {
	bullet := new(Bullet)
	bullet.x = player.position.x + player.size.x /2
	bullet.y = player.position.y - player.size.y / 2
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
	bullets: [dynamic]^Bullet
	
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
				currentBullet = createBullet(player)
				append(&bullets, currentBullet)
				fmt.printf("Bullet size: %d", len(&bullets))
				DrawRectangle(currentBullet.x, currentBullet.y, 5, 10, GREEN)
			}
		}
		
		// TODO: get the shots into an array and fire a few more bullets
		// 		 could also do with some time difference or something similar

		if isShot && currentBullet != nil {
			currentBullet.y -= 10
			if currentBullet.y <= 0 {
				ordered_remove(&bullets, 0)
				free(currentBullet)
				fmt.printf("Bullet size: %d", len(&bullets))
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