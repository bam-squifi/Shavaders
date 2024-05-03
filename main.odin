package game

import "core:fmt"
import "vendor:raylib"
import "entities"

main :: proc() {
	using raylib

	InitWindow(1280, 960, "Shavaders v.0.01dev")

	screenWidth: i32 = GetScreenWidth()
	screenHeight: i32 = GetScreenHeight()
	player: ^entities.Player =  entities.InitPlayer(screenWidth, screenHeight)
	
	DisableCursor()

	SetTargetFPS(60)

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